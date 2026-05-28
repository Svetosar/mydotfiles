-- init.lua — Ослепительный Neovim с ленивым менеджером

-- 1. Базовые настройки редактора
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.relativenumber = true
-- Мышь: выделение → копирует, колёсико → вставляет
vim.keymap.set('v', '<LeftRelease>', '"+y', { silent = true })
vim.keymap.set({'n', 'i', 'v', 'c'}, '<MiddleMouse>', '<C-r>*', { noremap = true, silent = true })

-- 2. Подключение lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 3. Твой набор плагинов
require("lazy").setup({
  -- === ВИЗУАЛЬНАЯ ЧАСТЬ ===

  -- Самая красивая тёмная тема
  {
    "neanias/everforest-nvim",
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.cmd.colorscheme("everforest")
    end,
  },
  -- Иконки для файлов (нужны для многих плагинов)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Статус-бар внизу
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  },

  -- === ГЛАВНОЕ МЕНЮ (САМОЕ СТИЛЬНОЕ) ===
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⡀⠀⠀⠀⠀',
        '⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀',
        '⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀',
        '⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀',
        '⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀',
        '⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀',
        '⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀',
        '⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀',
        '⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀',
        '⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀',
        'Neovim',
      }
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Найти файл', ':Telescope find_files<CR>'),
        dashboard.button('r', '  Недавние файлы', ':Telescope oldfiles<CR>'),
        dashboard.button('g', '  Поиск по тексту', ':Telescope live_grep<CR>'),
        dashboard.button('c', '  Конфигурация', ':e ~/.config/nvim/init.lua<CR>'),
        dashboard.button('q', '  Выйти', ':qa<CR>'),
      }
      alpha.setup(dashboard.opts)
    end
  },

  -- === БУФЕРЛАЙН (ВКЛАДКИ СВЕРХУ) ===
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup()
    end
  },

  -- === ИНСТРУМЕНТЫ ===

  -- Стильная командная строка
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup({
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      })
    end,
  },

  -- Шпаргалка по горячим клавишам
  { 'folke/which-key.nvim', opts = {} },

  -- Мгновенная навигация по коду
  {
    'folke/flash.nvim',
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- Мощный поисковик файлов и текста
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Дерево файлов
 {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Отключаем стандартный netrw, чтобы не было конфликтов
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 30,              -- ширина окна менеджера
        },
        renderer = {
          group_empty = true,      -- группировать пустые папки
        },
        filters = {
          dotfiles = false,        -- показывать скрытые файлы
        },
        actions = {
          open_file = {
            quit_on_open = true,   -- закрывать менеджер при открытии файла
          },
        },
      })
      vim.keymap.set('n', '<F2>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  },
  -- Автодополнение
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      keymap = { preset = 'default' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },

  -- Интеграция с Git
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { buffer = bufnr, desc = 'Preview Git hunk' })
    end,
  },

  -- Rust
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          on_attach = function(client, bufnr) end,
          settings = {
            ["rust-analyzer"] = {}
          }
        },
        dap = {}
      }
    end,
  },

  -- Дебаггер
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      vim.keymap.set('n', '<F5>', dap.continue)
      vim.keymap.set('n', '<F10>', dap.step_over)
      vim.keymap.set('n', '<F11>', dap.step_into)
      vim.keymap.set('n', '<F12>', dap.step_out)
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
    end
  },

  -- === MARKDOWN ПЛАГИНЫ (НОВОЕ) ===

  -- Предпросмотр Markdown в браузере
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },

  -- Улучшенный редактор таблиц для Markdown
  {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
  },
})

-- 4. Последние штрихи
vim.opt.cmdheight = 0
vim.cmd('highlight Cmdline guibg=NONE guifg=#cdd6f4')

-- Автоматический перенос строк для Markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.conceallevel = 2
  end,
})

-- Восстановление тонкого курсора при выходе из Neovim
vim.api.nvim_create_autocmd({ 'VimLeave', 'VimSuspend' }, {
  pattern = '*',
  callback = function()
    vim.o.guicursor = 'a:ver25'
  end
})
vim.keymap.set('n', '<Space>e', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.deprecate = function() end
