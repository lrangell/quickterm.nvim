local M = {}
M.map = function(f, xs)
  local tbl_17_auto = {}
  local i_18_auto = #tbl_17_auto
  for _, x in ipairs(xs) do
    local val_19_auto = f(x)
    if (nil ~= val_19_auto) then
      i_18_auto = (i_18_auto + 1)
      do end (tbl_17_auto)[i_18_auto] = val_19_auto
    else
    end
  end
  return tbl_17_auto
end
M["table?"] = function(x)
  return (type(x) == "table")
end
M["ensure-table"] = function(key_or_table, val)
  if M["table?"](key_or_table) then
    return key_or_table
  else
    return {[key_or_table] = val}
  end
end
M["ensure-pairs"] = function(...)
  return pairs(M["ensure-table"](...))
end
M["string?"] = function(x)
  return ("string" == type(x))
end
M["nil?"] = function(x)
  return (nil == x)
end
M["table?"] = function(x)
  return ("table" == type(x))
end
M["run!"] = function(f, xs)
  if xs then
    local nxs = M.count(xs)
    if (nxs > 0) then
      for i = 1, nxs do
        f(xs[i])
      end
      return nil
    else
      return nil
    end
  else
    return nil
  end
end
M.reduce = function(f, init, xs)
  local result = init
  local function _5_(x)
    result = f(result, x)
    return nil
  end
  M["run!"](_5_, xs)
  return result
end
M.find = function(t, p)
  local x = nil
  for _, v in ipairs(t) do
    if (nil ~= x) then break end
    if p(v) then
      x = v
    else
    end
  end
  return x
end
M["merge-inplace"] = function(left_tbl, right_tbl)
  for k, v in pairs(right_tbl) do
    left_tbl[k] = v
  end
  return nil
end
return M
