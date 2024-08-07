-- Function to get the default register content
local function get_default_register()
  local reg_content = vim.fn.getreg('"')
  if #reg_content > 30 then
    reg_content = reg_content:sub(1, 30) .. '...'
  end
  return reg_content
end

require('lualine').setup {
  options = { theme = 'catppuccin' },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 4,
        use_mode_colors = true,
      }
    },
    lualine_x = {
      { get_default_register, color = {  gui = 'bold' } }
    },
    lualine_y = {},
    lualine_z = {}
  }
}
