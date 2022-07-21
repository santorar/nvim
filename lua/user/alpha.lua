local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[]],
  [[ ______   ________   ___   __    _________  ______   ______    ________   ______          ]],
  [[/_____/\ /_______/\ /__/\ /__/\ /________/\/_____/\ /_____/\  /_______/\ /_____/\         ]],
  [[\::::_\/_\::: _  \ \\::\_\\  \ \\__.::.__\/\:::_ \ \\:::_ \ \ \::: _  \ \\:::_ \ \        ]],
  [[ \:\/___/\\::(_)  \ \\:. `-\  \ \  \::\ \   \:\ \ \ \\:(_) ) )_\::(_)  \ \\:(_) ) )_      ]],
  [[  \_::._\:\\:: __  \ \\:. _    \ \  \::\ \   \:\ \ \ \\: __ `\ \\:: __  \ \\: __ `\ \     ]],
  [[    /____\:\\:.\ \  \ \\. \`-\  \ \  \::\ \   \:\_\ \ \\ \ `\ \ \\:.\ \  \ \\ \ `\ \ \    ]],
  [[    \_____\/ \__\/\__\/ \__\/ \__\/   \__\/    \_____\/ \_\/ \_\/ \__\/\__\/ \_\/ \_\/    ]],
  [[                      ___   __    __   __   ________  ___ __ __     ]],
  [[                     /__/\ /__/\ /_/\ /_/\ /_______/\/__//_//_/\    ]],
  [[                     \::\_\\  \ \\:\ \\ \ \\__.::._\/\::\| \| \ \   ]],
  [[                      \:. `-\  \ \\:\ \\ \ \  \::\ \  \:.      \ \  ]],
  [[                       \:. _    \ \\:\_/.:\ \ _\::\ \__\:.\-/\  \ \ ]],
  [[                        \. \`-\  \ \\ ..::/ //__\::\__/\\. \  \  \ \]],
  [[                         \__\/ \__\/ \___/_( \________\/ \__\/ \__\/]],
  [[]],
  [[]],
}
dashboard.section.buttons.val = {
  dashboard.button("f", icons.documents.Files .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button(
    "p",
    icons.git.Repo .. " Find project",
    ":lua require('telescope').extensions.projects.projects()<CR>"
  ),
  dashboard.button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", icons.ui.List .. " Find text", ":Telescope live_grep <CR>"),
  dashboard.button("s", icons.ui.SignIn .. " Find Session", ":silent Autosession search <CR>"),
  dashboard.button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("u", icons.ui.CloudDownload .. " Update", ":PackerSync<CR>"),
  dashboard.button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
}

local function footer()
  -- NOTE: requires the fortune-mod package to work
  -- local handle = io.popen("fortune")
  -- local fortune = handle:read("*a")
  -- handle:close()
  -- return fortune
  return "Enjoy your coding :D "
end

local config = {
    layout = {
        { type = "padding", val = 1 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        dashboard.section.footer,
    },
    opts = {
        margin = 2,
    },
}


dashboard.config = config
dashboard.section.footer.val = footer()
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
