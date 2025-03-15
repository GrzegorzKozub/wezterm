local M = {}

function M.concat(a, b)
  for _, val in ipairs(b) do
    table.insert(a, val)
  end
  return a
end

return M
