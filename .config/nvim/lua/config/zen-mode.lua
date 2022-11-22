------------------------------------------------------------------------------
-- HEADER zen-mode
------------------------------------------------------------------------------
require('zen-mode').setup{
    window = {
        backdrop = 0.95,
        width = 128,
        height = 1,
        options = {
          number = true,
          cursorline = true, -- diable cursorline
          cursorlineopt = 'number',
          scrolloff = 99
        }
    },
    plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = false },
    }
}

