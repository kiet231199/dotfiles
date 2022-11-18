local highlight = vim.api.nvim_set_hl

-- Syntax highlight(0, "Group", { fg = "#RGB, bg = "#RGB", bold = true ?, italic = true ?, reverse = true ?, link = "OtherGroup" })

-- Neovim group
highlight(0, "cNormal", { fg = "#bfc7f1", bg = "#1a1b26" })
highlight(0, "Pmenu", { bg = cNormal })
highlight(0, "PmenuSel", { fg = None, bg = "#292938" })
highlight(0, "PmenuSbar", { bg = cNormal })
highlight(0, "PmenuThumb", { fg = "#a9b1d6" })

-- Swap Split group
-- highlight(0, 'SwapSplitStatusLine', { fg = "Black", bg = "Red", bold = true })

-- Floaterm group
highlight(0, 'Floaterm', { bg = Normal })
highlight(0, 'FloatermBorder', { fg = "Red" })

--  ScrollView group
highlight(0, "ScrollView", { fg = "#a9b1d6" })

-- GitSigns group
highlight(0, "GitSignsCurrentLineBlame", { fg = "Yellow", bg = cNormal })
highlight(0, "GitSignsAdd", { fg = "Green" })
highlight(0, "GitSignsAddNr", { fg = "Green" })
highlight(0, "GitSignsChange", { fg = "Yellow" })
highlight(0, "GitSignsChangeNr", { fg = "Yellow" })
highlight(0, "GitSignsDelete", { fg = "Red" })
highlight(0, "GitSignsDelteNr", { fg = "Red" })

-- Hlslens group
highlight(0, "MyHlSearch", { fg = "Red", bg = cNormal, bold = true })
highlight(0, "HlSearchNear", { link = "IncSearch" })
highlight(0, "HlSearchLens", { link = "cNormal" })
highlight(0, "HlSearchLensNear", { link = "MyHlSearch" })
highlight(0, "HlSearchFloat", { link = "IncSearch" })

-- Trouble group
highlight(0, "TroubleTextInformation", { link = "DiagnosticVirtualTextInfo" })
highlight(0, "TroubleTextError", { link = "DiagnosticError" })
highlight(0, "TroubleTextWarning", { link = "DiagnosticWarning" })
highlight(0, "TroubleTextHint", { link = "DiagnosticHint" })

-- Telescope group
highlight(0, "TelescopeMatching", { fg = "Orange", bold = true })
highlight(0, "TelescopePreviewMatch", { link = "MyHlSearch" })

-- Cmp group
highlight(0, "CmpItemAbbrMatch", { fg = "Orange", bold = true })
highlight(0, "CmpItemAbbrMatchDefault", { fg = "Orange", bold = true })
highlight(0, "CmpItemAbbrMatchFuzzy", { fg = "Red", bold = true })
highlight(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "Red", bold = true })
highlight(0, "CmpItemKindText", { fg = "Yellow", bold = true })
