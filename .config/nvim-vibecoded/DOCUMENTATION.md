# LazyVim Documentation

This document provides a comprehensive overview of the LazyVim configuration, its structure, and available utility functions.

## 1. Repository Structure

The LazyVim configuration is organized into a modular structure to ensure maintainability and flexibility.

- `init.lua`: The main entry point for Neovim. It initializes the `lazy.nvim` plugin manager and loads the base configuration.
- `lua/config/`: Contains core configuration files for Neovim settings, keymaps, and autocommands.
- `lua/plugins/`: Contains plugin specifications, categorized by functionality (e.g., coding, editor, lsp, ui).
- `lua/util/`: A collection of utility modules providing helper functions used throughout the configuration.
- `queries/`: Custom Tree-sitter queries.

## 2. Configuration Files (`lua/config/`)

- **`init.lua`**: The central hub for configuration. It sets up the `Util` global object, and handles the loading order of options, keymaps, and autocmds.
- **`options.lua`**: Defines standard Neovim options using `vim.opt`. It includes settings for indentation, search behavior, UI elements, and more.
- **`keymaps.lua`**: Sets up general-purpose keybindings for buffer navigation, window management, and common editing tasks. It uses `Util.safe_keymap_set` to avoid conflicts with plugin-defined keys.
- **`autocmds.lua`**: Defines autocommands for various events, such as highlighting on yank, automatic directory creation on save, and filetype-specific settings (e.g., wrapping for markdown).
- **`defaults.lua`**: Contains default icons and UI constants.

## 3. Plugins (`lua/plugins/`)

Plugins are organized into subdirectories based on their primary purpose:

- **`coding/`**: Plugins related to coding assistance (e.g., completion, snippets, comments).
- **`colorscheme/`**: Configuration for the default colorscheme (e.g., tokyonight).
- **`editor/`**: Enhancements for the editing experience (e.g., file explorer, git signs, telescope/fzf, todo comments).
- **`formatting/`**: Plugins for code formatting (e.g., conform.nvim).
- **`linting/`**: Plugins for code linting (e.g., nvim-lint).
- **`lsp/`**: LSP configuration and related enhancements.
- **`treesitter/`**: Tree-sitter configurations and text objects.
- **`ui/`**: UI components like statusline (lualine), bufferline, and notifications.
- **`util/`**: General-purpose plugin utilities (e.g., persistence).

## 4. Utility Functions (`lua/util/`)

The utility functions are organized into modules. To use them in a file, require the main utility module:
```lua
local Util = require("util")
```

### `Util` (Core Utilities - `lua/util/init.lua`)

- **`is_win()`**: Returns `true` if the current operating system is Windows.
- **`get_plugin(name)`**: Returns the plugin specification for the given plugin name.
- **`get_plugin_path(name, path)`**: Returns the filesystem path to a plugin's directory, optionally appended with a sub-path.
- **`has(plugin)`**: Checks if a plugin with the given name is registered in the configuration.
- **`opts(name)`**: Retrieves the resolved options for a plugin.
- **`lazy_notify()`**: Delays notifications until `vim.notify` is fully initialized.
- **`is_loaded(name)`**: Checks if a plugin is currently loaded by `lazy.nvim`.
- **`dedup(list)`**: Returns a new list with duplicate values removed.
- **`create_undo()`**: Generates an undo point if Neovim is in insert mode.
- **`get_pkg_path(pkg, path, opts)`**: Returns the path to a package installed via Mason.
- **`statuscolumn()`**: Safely retrieves the statuscolumn configuration from `snacks.nvim`.
- **`set_opt(option, value, buf)`**: Safely sets a Neovim option.
- **`try(fn, opts)`**: Executes a function within a `pcall` and displays an error message if it fails.

#### `Util.terminal` (Merged into `lua/util/init.lua`)
- **`setup(shell)`**: Configures terminal settings, with special optimizations for PowerShell on Windows.

### `Util.lsp` (`lua/util/lsp.lua`)

- **`format(opts)`**: Formats the current buffer using LSP, preferring `conform.nvim` if available.
- **`action[name]`**: Provides a convenient way to trigger specific LSP code actions (e.g., `Util.lsp.action["source.organizeImports"]()`).
- **`execute(opts)`**: Executes an LSP command, with support for displaying results in `trouble.nvim`.

### `Util.root` (`lua/util/root.lua`)

- **`get(opts)`**: Returns the detected root directory for the current buffer.
- **`git()`**: Returns the path to the git root.
- **`cwd()`**: Returns the current working directory.

### `Util.cmp` (`lua/util/cmp.lua`)

- **`map(actions, fallback)`**: Helper for mapping completion-related actions.
- **`snippet_preview(snippet)`**: Generates a human-readable preview of an LSP snippet.
- **`auto_brackets(entry)`**: Automatically adds brackets after completing a function or method.
- **`confirm(opts)`**: An enhanced version of `cmp.confirm` with better visibility checks and undo point creation.
- **`expand(snippet)`**: Safely expands a snippet, with automatic fixing for common syntax errors.

### `Util.inject` (`lua/util/inject.lua`)

- **`args(fn, wrapper)`**: Injects a wrapper function that can intercept or modify arguments before calling the original function.
- **`get_upvalue(func, name)`**: Retrieves an upvalue by name from a function.
- **`set_upvalue(func, name, value)`**: Updates an upvalue by name for a function.

### `Util.lualine` (`lua/util/lualine.lua`)

- **`status(icon, status_fn)`**: Creates a custom lualine component with dynamic coloring based on status.
- **`cmp_source(name, icon)`**: Creates a status component for a specific `nvim-cmp` source.
- **`pretty_path(opts)`**: A lualine component that displays a shortened, visually appealing path to the current file.
- **`root_dir(opts)`**: A lualine component that shows the current root directory.

### `Util.mini` (`lua/util/mini.lua`)

- **`ai_buffer(ai_type)`**: Provides a text object for the entire buffer for use with `mini.ai`.
- **`ai_whichkey(opts)`**: Integrates `mini.ai` text objects with `which-key.nvim` for better discoverability.
- **`pairs(opts)`**: Configures `mini.pairs` with enhanced logic for skipping pairs in specific contexts (e.g., within certain Tree-sitter captures).
