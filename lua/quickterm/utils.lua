__fnl_global__import_2dfrom({find}, "functions")
local function find_chan(bufn)
  local _1_ = vim.api.nvim_list_chans()
  if (nil ~= _1_) then
    local _2_
    local function _3_(_241)
      return (bufn == (_241.buffer or nil))
    end
    _2_ = find(_1_, _3_)
    if (nil ~= _2_) then
      return (_2_).id
    else
      return _2_
    end
  else
    return _1_
  end
end
return {["find-chan"] = find_chan}
