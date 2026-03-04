---@class CoreRoot
---@field cache table<number, string>
---@field spec table
---@field detectors table<string, fun(buf: number, patterns?: string[]): string[]>
local M = {}

local path = require("utils.path")

M.cache = {}
M.spec = { "lsp", { ".git", "lua" }, "cwd" }

---@param buf number
---@return string|nil
local function buf_path(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return nil
  end
  return path.norm(name)
end

---@return string
function M.cwd()
  return vim.loop.cwd()
end

---@param child string|nil
---@param parent string|nil
---@return boolean
local function is_subpath(child, parent)
  if not child or not parent then
    return false
  end
  return child:find(parent, 1, true) == 1
end

M.detectors = {}

---@param buf number
---@return string[]
M.detectors.lsp = function(buf)
  local roots = {}
  local ignore = vim.g.root_lsp_ignore or {}
  local bufname = buf_path(buf)

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
    if not vim.tbl_contains(ignore, client.name) then
      local workspace = client.config.workspace_folders
      local root_dir = client.config.root_dir
      if workspace then
        for _, folder in ipairs(workspace) do
          local folder_path = path.norm(folder.name)
          if bufname and is_subpath(bufname, folder_path) then
            table.insert(roots, folder_path)
          end
        end
      end
      if root_dir then
        local root_path = path.norm(root_dir)
        if not bufname or is_subpath(bufname, root_path) then
          table.insert(roots, root_path)
        end
      end
    end
  end

  return roots
end

---@param buf number
---@param patterns string[]
---@return string[]
M.detectors.pattern = function(buf, patterns)
  local start = buf_path(buf) or M.cwd()
  local dir = vim.fs.dirname(start)

  while dir do
    for _, pattern in ipairs(patterns) do
      local matches = vim.fn.globpath(dir, pattern, true, true)
      if #matches > 0 then
        return { dir }
      end
    end

    local parent = vim.fs.dirname(dir)
    if not parent or parent == dir then
      break
    end
    dir = parent
  end

  return {}
end

---@return string[]
M.detectors.cwd = function()
  return { M.cwd() }
end

---@param spec string|table|fun(buf: number): string[]
---@return fun(buf: number): string[]
local function resolve(spec)
  if type(spec) == "function" then
    return spec
  end

  if type(spec) == "string" then
    if M.detectors[spec] then
      return M.detectors[spec]
    end
    return function(buf)
      return M.detectors.pattern(buf, { spec })
    end
  end

  if type(spec) == "table" then
    return function(buf)
      return M.detectors.pattern(buf, spec)
    end
  end

  return function()
    return {}
  end
end

---@param list string[]
---@return string[]
local function uniq_sorted(list)
  local seen = {}
  local result = {}
  for _, item in ipairs(list) do
    if item and item ~= "" and not seen[item] then
      seen[item] = true
      table.insert(result, item)
    end
  end
  table.sort(result, function(a, b)
    return #a > #b
  end)
  return result
end

---@param opts? { buf?: number, spec?: table, all?: boolean }
---@return { spec: string|table|function, paths: string[] }[]
function M.detect(opts)
  opts = opts or {}
  local buf = opts.buf or 0
  local spec = opts.spec or vim.g.root_spec or M.spec
  local all = opts.all or false

  local results = {}
  for _, detector in ipairs(spec) do
    local fn = resolve(detector)
    local roots = uniq_sorted(fn(buf))
    if #roots > 0 then
      table.insert(results, { spec = detector, paths = roots })
      if not all then
        break
      end
    end
  end

  return results
end

---@param opts? { buf?: number, normalize?: boolean }
---@return string
function M.get(opts)
  opts = opts or {}
  local buf = opts.buf or 0
  local normalize = opts.normalize

  if M.cache[buf] then
    return M.cache[buf]
  end

  local detected = M.detect({ buf = buf, all = false })
  local root = (#detected > 0 and detected[1].paths[1]) or M.cwd()
  if normalize then
    root = path.norm(root)
  end

  M.cache[buf] = root
  return root
end

---@param buf number
---@param patterns string[]
---@return boolean
function M.has_pattern(buf, patterns)
  return #M.detectors.pattern(buf, patterns) > 0
end

---@param opts? { buf?: number, normalize?: boolean }
---@return string
function M.git(opts)
  local root = M.get(opts)
  local git_dir = vim.fs.find(".git", { path = root, upward = true })[1]
  if git_dir then
    return vim.fs.dirname(git_dir)
  end
  return root
end

---@param buf? number
---@return nil
function M.clear_cache(buf)
  if buf then
    M.cache[buf] = nil
  else
    M.cache = {}
  end
end

return M
