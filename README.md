# Neovim Setup for Salesforce & Go Development

A meticulously crafted, professional Neovim configuration built around **lazy.nvim**. This setup is highly optimized for **Salesforce (Apex, LWC, Visualforce)** and **Go** backend development, featuring robust LSP support, tailored snippets, and deep Salesforce CLI integration.

## 🌟 Overview

This configuration balances a sleek UI with powerful, developer-centric tooling. It avoids unnecessary bloat while providing everything needed for a modern IDE experience:
* **Salesforce Native:** Deep integration with `sf.nvim` for deployments, org management, Apex testing, and SOQL execution.
* **Go Ready:** Pre-configured with `gopls` and custom error-handling snippets.
* **Fast & Modern:** Uses `lazy.nvim` for lightning-fast startup times and module loading.
* **Aesthetic UI:** Powered by the Catppuccin (Mocha) theme, transparent backgrounds, and a customized `lualine` status bar.

## 📦 Core Plugins

Here is a quick overview of the essential tools powering this config:

* **Package Management:** `lazy.nvim`
* **Fuzzy Finder:** `telescope.nvim` (with `fzf-native` and custom history/quickfix actions)
* **File Explorer:** `oil.nvim` (edit your filesystem like a normal Neovim buffer)
* **LSP & Formatting:** `nvim-lspconfig`, `mason.nvim`, and `conform.nvim` (auto-formatting on save)
* **Salesforce Tooling:** `sf.nvim` (managing orgs, deployments, tests) & `nvim-html-css` (Lightning Design System support)
* **Task Runner:** `overseer.nvim` (handles integrated terminal tasks and tests)
* **Autocompletion & Snippets:** `nvim-cmp`, `LuaSnip`, and `nvim-autopairs`
* **Git Integration:** `neogit` and `gitsigns.nvim`

## 🚀 Installation (WSL / Ubuntu)

This guide assumes you are setting up a fresh Windows Subsystem for Linux (WSL) environment.

**1. Create and launch a fresh Ubuntu WSL instance:**
```powershell
wsl --install -d Ubuntu --name <YOUR_INSTANCE_NAME>
wsl -d <YOUR_INSTANCE_NAME>
```

**2. Clone this repository:**
Make sure to clone the repository directly into your user's config directory.
```bash
git clone <REPO_URL> ~/.config/nvim
```

**3. Run the installation script:**
Navigate to the newly cloned directory and execute the setup script (ensure it has executable permissions).
```bash
cd ~/.config/nvim
chmod +x ./scripts/install.sh
./scripts/install.sh
```

## ⌨️ Key Mappings

The `<leader>` key is mapped to `Space`. Below are some of the most critical daily-driver mappings.

### General & Editing
| Keys | Action |
| :--- | :--- |
| `<leader>pv` | Open **Oil.nvim** file explorer |
| `J` / `K` | (Visual Mode) Move selected text block up/down |
| `<leader>y` / `<C-c>` | Copy to system clipboard (`"+y`) |
| `<leader>co` / `<leader>cc` | Open / Close the Quickfix list |
| `<leader>sn` | Create a scratch buffer clone of the current file |
| `<leader>fo` | Format the current buffer (`conform.nvim`) |

### Telescope (Fuzzy Finding)
| Keys | Action |
| :--- | :--- |
| `<leader>pf` | Find files |
| `<C-p>` | Find recent (old) files in CWD |
| `<leader>ff` | Literal search (grep) across project |
| `<leader>fb` | Literal search in the current buffer |
| `<space>pc` | Find files in Neovim config (`~/.config/nvim`) |
| `gd`, `gr`, `gi` | LSP: Go to Definition, References, Implementation |

### Salesforce (`sf.nvim`)
*Note: These are only active when working inside an `sfdx-project.json` directory.*

| Keys | Action |
| :--- | :--- |
| `<leader>sf` | Fetch/refresh Org List |
| `<leader>ss` | Set target Org for the current workspace |
| `<leader>sp` | Save & Push current metadata file |
| `<leader>sr` | Retrieve current metadata file |
| `<leader>ta` | Run all tests in the current file |
| `\s` | Toggle code coverage signs in the gutter |
| `<leader>sq` | (Visual Mode) Run highlighted SOQL query |

### Git
| Keys | Action |
| :--- | :--- |
| `<leader>gs` | Open **Neogit** |
| `<leader>hs` / `hr` | Stage / Reset Git Hunk under cursor |
| `<leader>hp` | Preview Git Hunk |

## 🛠️ Custom Snippets

This configuration comes pre-loaded with `LuaSnip` to speed up repetitive typing. 

**Go:**
* `ie` ⭢ Expands to `if err != nil { ... }`

**Apex:**
* `if`, `for`, `fori` ⭢ Standard control flow structures.
* `newList`, `newSet`, `newMap` ⭢ Rapidly instantiate collections (e.g., `List<String> lst = new List<String>();`).
* `debug` ⭢ Expands to `System.debug();`
