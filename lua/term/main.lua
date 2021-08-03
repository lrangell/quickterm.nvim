local _2afile_2a = "fnl/term/main.fnl"
local _0_
do
  local name_0_ = "term.main"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  do end (module_0_)["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  do end (package.loaded)[name_0_] = module_0_
  _0_ = module_0_
end
local autoload
local function _1_(...)
  return (require("term.aniseed.autoload")).autoload(...)
end
autoload = _1_
local function _2_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _2_()
    return {}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local _2amodule_2a = _0_
local _2amodule_name_2a = "term.main"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
package.loaded["term.main"] = nil
local api = vim.api
local terminals = {}
local init
do
  local v_0_
  do
    local v_0_0
    local function init0()
    end
    v_0_0 = init0
    _0_["init"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["init"] = v_0_
  init = v_0_
end
local tlist
do
  local v_0_
  do
    local v_0_0 = {}
    _0_["tlist"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["tlist"] = v_0_
  tlist = v_0_
end
local create_window
do
  local v_0_
  do
    local v_0_0
    local function create_window0(kind, bufn)
      local function split(v)
        vim.cmd((v .. "split"))
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, bufn)
        return win
      end
      local _3_ = kind
      if (_3_ == "float") then
        return api.nvim_open_win(bufn, false, {col = 0, height = 10, relative = "editor", row = 80, style = "minimal", width = 60})
      elseif (_3_ == "vsplit") then
        return split("v")
      elseif (_3_ == "split") then
        return split("")
      end
    end
    v_0_0 = create_window0
    _0_["create-window"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["create-window"] = v_0_
  create_window = v_0_
end
local open_terminal
do
  local v_0_
  do
    local v_0_0
    local function open_terminal0(_3_)
      local _arg_0_ = _3_
      local term = _arg_0_
      local buffer = _arg_0_["buffer"]
      local split = _arg_0_["split"]
      local window = _arg_0_["window"]
      if (nil == window) then
        local new_win = create_window(split, term.buffer)
        do end (term)["window"] = new_win
        return nil
      end
    end
    v_0_0 = open_terminal0
    _0_["open-terminal"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["open-terminal"] = v_0_
  open_terminal = v_0_
end
local close_term
do
  local v_0_
  do
    local v_0_0
    local function close_term0(_3_)
      local _arg_0_ = _3_
      local term = _arg_0_
      local window = _arg_0_["window"]
      if (nil ~= window) then
        api.nvim_win_close(window, true)
        do end (term)["window"] = nil
        return nil
      end
    end
    v_0_0 = close_term0
    _0_["close-term"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["close-term"] = v_0_
  close_term = v_0_
end
local toggle
do
  local v_0_
  do
    local v_0_0
    local function toggle0(_3_)
      local _arg_0_ = _3_
      local term = _arg_0_
      local window = _arg_0_["window"]
      if (nil == window) then
        return term:open()
      else
        return term:close()
      end
    end
    v_0_0 = toggle0
    _0_["toggle"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["toggle"] = v_0_
  toggle = v_0_
end
local change_split
do
  local v_0_
  do
    local v_0_0
    local function change_split0(_3_, new_split)
      local _arg_0_ = _3_
      local term = _arg_0_
      local close = _arg_0_["close"]
      local open = _arg_0_["open"]
      term["split"] = new_split
      close()
      return open()
    end
    v_0_0 = change_split0
    _0_["change-split"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["change-split"] = v_0_
  change_split = v_0_
end
local keymap
do
  local v_0_
  do
    local v_0_0
    local function keymap0(_3_, lhs, rhs)
      local _arg_0_ = _3_
      local buffer = _arg_0_["buffer"]
      return api.nvim_buf_set_keymap(buffer, "t", lhs, rhs, {})
    end
    v_0_0 = keymap0
    _0_["keymap"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["keymap"] = v_0_
  keymap = v_0_
end
local setk
do
  local v_0_
  do
    local v_0_0
    local function setk0(_3_)
      local _arg_0_ = _3_
      local term = _arg_0_
      local name = _arg_0_["name"]
      print(("lua require'term.main'.tlist." .. name .. ".change-split('float')"))
      term:keymap("<Esc>", "<C-\\><C-n>")
      return term:keymap("<C-v>", ("lua require'term.main'.terminals." .. name .. ".change-split('float')"))
    end
    v_0_0 = setk0
    _0_["setk"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["setk"] = v_0_
  setk = v_0_
end
local create_term
do
  local v_0_
  do
    local v_0_0
    local function create_term0(name)
      do
        local bufn = vim.api.nvim_create_buf(false, false)
        do end (terminals)[name] = {buffer = bufn, name = name, split = "vsplit", window = nil}
        open_terminal(terminals[name])
        vim.cmd("term")
      end
      terminals[name]["toggle"] = toggle
      terminals[name]["open"] = open_terminal
      terminals[name]["close"] = close_term
      terminals[name]["keymap"] = keymap
      terminals[name]["change_split"] = change_split
      return setk(terminals[name])
    end
    v_0_0 = create_term0
    _0_["create-term"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["create-term"] = v_0_
  create_term = v_0_
end
vim.cmd("nmap <space>l lua require'term.main'.create('za')")
local function _3_()
  return print(vim.inspect((("require")("term.main")).terminals))
end
do end (require("config.utils")).nmap("<space>p", _3_)
return {create = create_term, terminals = terminals}