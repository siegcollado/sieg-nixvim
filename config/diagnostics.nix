{
  diagnostic.settings = {
    underline = true;
    update_in_insert = false;
    severity_sort = true;
    signs = {
      text = {
        "ERROR" = " ";
        "WARN" = " ";
        "HINT" = " ";
        "INFO" = " ";
      };
    };
    virtual_text = {
      spacing = 4;
      source = "if_many";
      prefix = "● ";
      virt_text_pos = "right_align";
    };
  };
}
