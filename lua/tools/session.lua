local M = {}

local function project_session_file()
  local projectname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  return vim.fn.stdpath("state") .. "/sessions/" .. projectname .. ".vim"
end

local function make_parents(filename)
  vim.fn.mkdir(vim.fn.fnamemodify(filename, ":p:h"), "p")
end

M.save_project_session = function()
  local session_file = project_session_file()
  make_parents(session_file)
  vim.cmd("mksession! " .. session_file)
end

M.load_project_session = function()
  local session_file = project_session_file()
  if vim.fn.filereadable(session_file) ~= 0 then
    vim.cmd("source " .. session_file)
  else
    print("No such session file:", session_file)
  end
end

return M
