local M = {}

local function uniq(list)
  local seen = {}
  local result = {}
  for _, value in ipairs(list) do
    if not seen[value] then
      seen[value] = true
      table.insert(result, value)
    end
  end
  return result
end

function M.lsp(msg)
  msg = msg or "LS Inactive"

  local all_clients = vim.lsp.get_clients()
  local buf_clients = vim.tbl_filter(function(client)
    return client.name ~= "copilot" and client.name ~= "null-ls" and client.name ~= "biome"
  end, all_clients)

  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_client_names = {}
  for _, client in ipairs(buf_clients) do
    table.insert(buf_client_names, client.name)
  end

  local unique_client_names = uniq(buf_client_names)
  if #unique_client_names == 0 then
    return ""
  end

  return table.concat(unique_client_names, ",")
end

function M.conform()
  local conform = require("conform")
  local formatters = {}
  for _, formatter in ipairs(conform.list_formatters_to_run()) do
    table.insert(formatters, formatter.name)
  end

  local unique_formatters = uniq(formatters)
  if #unique_formatters == 0 then
    return ""
  end
  return table.concat(unique_formatters, ",")
end

return M
