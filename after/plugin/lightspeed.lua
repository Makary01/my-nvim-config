require'lightspeed'.setup {
  ignore_case = false,
}
vim.api.nvim_set_keymap('n', 'f', '<Plug>Lightspeed_s', {})
vim.api.nvim_set_keymap('n', 'F', '<Plug>Lightspeed_S', {})
