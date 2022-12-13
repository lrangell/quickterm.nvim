local utils = require("quickterm.utils")
local config = require("quickterm.config")
local functions = require("quickterm.functions")
do local _ = {nil, nil, nil} end
local api = vim.api
local layouts = {"float", "vsplit", "split"}
local default_keymaps = {toggle = "<space>k"}
local terminal
local function _1_(text)
  return text
end
terminal = {split = "float", window = nil, new_line = "\n", transform = _1_}
local function screen_size(p)
  local _let_2_ = vim.api.nvim_list_uis()[1]
  local width = _let_2_["width"]
  local height = _let_2_["height"]
  local term_width = math.floor((width * p))
  local term_heigth = math.floor((height * p))
  return {width = term_width, height = term_heigth, col = (((width - term_width) / 2) - 1), row = (((height - term_heigth) / 2) - 1)}
end
terminal.create_window = function(_3_)
  local _arg_4_ = _3_
  local bufn = _arg_4_["bufn"]
  local split = _arg_4_["split"]
  local function open_split(v)
    vim.cmd((v .. "split"))
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, bufn)
    return win
  end
  local _5_ = split
  if (_5_ == "float") then
    return api.nvim_open_win(bufn, true, vim.tbl_deep_extend("force", {relative = "editor", noautocmd = true, style = "minimal", border = "solid"}, screen_size(0.9)))
  elseif (_5_ == "vsplit") then
    return open_split("v")
  elseif (_5_ == "split") then
    return open_split("")
  else
    return nil
  end
end
terminal.open = function(_7_)
  local _arg_8_ = _7_
  local bufn = _arg_8_["bufn"]
  local window = _arg_8_["window"]
  local split = _arg_8_["split"]
  local visible = _arg_8_["visible"]
  local term = _arg_8_
  if (nil == window) then
    term["window"] = term:create_window()
    return nil
  else
    return nil
  end
end
terminal.close = function(_10_)
  local _arg_11_ = _10_
  local window = _arg_11_["window"]
  local term = _arg_11_
  if (nil ~= window) then
    api.nvim_win_hide(window)
    do end (term)["window"] = nil
    return nil
  else
    return nil
  end
end
terminal.toggle = function(_13_)
  local _arg_14_ = _13_
  local visible = _arg_14_["visible"]
  local term = _arg_14_
  if visible then
    term:close()
  else
    term:open()
  end
  term["visible"] = not visible
  return nil
end
local function cycle(term)
  local curr_split
  local function _16_(l)
    return (term.split == l)
  end
  curr_split = utils.find(_16_, layouts)
  local next_split
  local function _17_()
    return layouts
  end
  next_split = ((curr_split + 1) % _17_)
  pp(curr_split)
  return pp(next_split)
end
terminal.change_split = function(term, new_split)
  term["split"] = new_split
  term:close()
  return term:open()
end
local function keymap(term, mode, lhs, rhs)
  return vim.keymap.set((mode or "t"), lhs, rhs, {})
end
terminal.find_chan = function(term)
  local function _18_(c)
    return (term.bufn == c.buffer)
  end
  (utils.find(api.nvim_list_chans(), _18_)).id[term] = "chan_id"
  return nil
end
terminal.send = function(_19_, text)
  local _arg_20_ = _19_
  local chan_id = _arg_20_["chan_id"]
  local new_line = _arg_20_["new_line"]
  local transform = _arg_20_["transform"]
  local term = _arg_20_
  if (chan_id == nil) then
    term.chan_id = utils["find-chan"](term.bufn)
  else
  end
  return api.nvim_chan_send(chan_id, (transform(text) .. new_line))
end
terminal.init = function(_22_)
  local _arg_23_ = _22_
  local cmd = _arg_23_["cmd"]
  local bufn = _arg_23_["bufn"]
  local term = _arg_23_
  functions["merge-inplace"](term, {window = term:create_window(), visible = true})
  local function _24_(...)
    return vim.fn.termopen("zsh", ...)
  end
  api.nvim_buf_call(term.bufn, _24_)
  api.nvim_command("startinsert")
  vim.fn.feedkeys(((cmd .. "\n") or ""))
  local function _25_(...)
    return term:close(...)
  end
  for lhs, rhs in pairs({["<Esc>"] = "<C-\\><C-n>", ["<Esc><Esc>"] = _25_, Tab = "<C-\\><C-w>w"}) do
    vim.keymap.set("t", lhs, rhs, {buffer = bufn})
  end
  return nil
end
local function create(_26_)
  local _arg_27_ = _26_
  local cmd = _arg_27_["cmd"]
  local keymaps = _arg_27_["keymaps"]
  local split = _arg_27_["split"]
  local bufn = vim.api.nvim_create_buf(false, false)
  local new_term = vim.tbl_deep_extend("force", terminal, {bufn = bufn, cmd = cmd, split = split})
  local all_keymaps = vim.tbl_deep_extend("force", default_keymaps, (keymaps or {}))
  for method, lhs in pairs(all_keymaps) do
    local function _28_()
      return new_term[method](new_term)
    end
    vim.keymap.set({"n", "t"}, lhs, _28_)
  end
  new_term:init()
  return new_term
end
return {create = create}
