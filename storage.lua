
-- Store number of cans in and number of cans out
local cans = {}

function addCan(bin)
  if not cans[bin] then cans[bin] = {num = 0} end
  cans[bin].num = cans[bin].num + 1
end

function subtractCan(bin)
  if not cans[bin] then return end
  cans[bin].num = math.max(0, cans[bin].num - 1)
end

function setBinType(bin, type_)
  if not cans[bin] then cans[bin] = {num = 0} end
  cans[bin].type_ = type_
end

function showCans()
  for bin, item in pairs(cans) do
    if item.type_ then
      print(string.format("Bin: %s, cans: %s, type: %s", bin, item.num, item.type_))
    else
      print(string.format("Bin: %s, cans: %s", bin, item.num))      
    end
  end
  print()
end


setBinType(1, "olives")
addCan(1)
addCan(1)
addCan(1)
showCans()

addCan(2)
addCan(2)
showCans()

subtractCan(2)
addCan(3)
addCan(3)
showCans()

subtractCan(2)
subtractCan(2)
showCans()
