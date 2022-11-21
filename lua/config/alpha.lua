local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  local function header()
    return {
     [[]],
      [[888888888888888888888888888888888888888888888888888888888888]],
      [[888888888888888888888888888888888888888888888888888888888888]],
      [[8888888888888888888888888P""  ""9888888888888888888888888888]],
      [[8888888888888888P"88888P          988888"9888888888888888888]],
      [[8888888888888888  "9888            888P"  888888888888888888]],
      [[888888888888888888bo "9  d8o  o8b  P" od88888888888888888888]],
      [[888888888888888888888bob 98"  "8P dod88888888888888888888888]],
      [[888888888888888888888888    db    88888888888888888888888888]],
      [[88888888888888888888888888      8888888888888888888888888888]],
      [[88888888888888888888888P"9bo  odP"98888888888888888888888888]],
      [[88888888888888888888P" od88888888bo "98888888888888888888888]],
      [[888888888888888888   d88888888888888b   88888888888888888888]],
      [[8888888888888888888oo8888888888888888oo888888888888888888888]],
      [[888888888888888888888888888888888888888888888888888888888888]],
      [[]],    }
  end

  dashboard.section.header.val = header()

  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y  %H:%M:%S"
    local plugins_text = "\t" .. total_plugins .. " plugins  " .. datetime

    -- Quote
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
