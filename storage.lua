local sjson = require('sjson')

--=============================================================================

function newBin(type_)
  return {num_cans = 0, type_ = type_}
end

--=============================================================================

local storage = {}

--=============================================================================

function addCan(bin_num)
  if not storage[bin_num] then storage[bin_num] = newBin() end
  storage[bin_num].num_cans = storage[bin_num].num_cans + 1
end

--=============================================================================

function removeCan(bin_num)
  if not storage[bin_num] then return end
  storage[bin_num].num_cans = math.max(0, storage[bin_num].num_cans - 1)
end

--=============================================================================

function setBinType(bin_num, type_)
  if not storage[bin_num] then 
    storage[bin_num] = newBin(type_)
    return
  end
  
  storage[bin_num].type_ = type_
end

--=============================================================================

function showStorage()
  for bin_num, bin in pairs(storage) do
    local type_ = (bin.type_) and string.format("Type: %s", bin.type_) or ""
    print(string.format("Bin: %s  Cans: %s %s", bin_num, bin.num_cans, type_))
  end
  print()
end

--=============================================================================

function makeCSV()
  local CSV = {"Bin number,Number of cans,Type"}
  for bin_num, bin in pairs(storage) do
    table.insert(CSV, string.format("%s,%s,%s", bin_num, bin.num_cans, bin.type_ or ""))
  end
  return table.concat(CSV, "\r\n")
end

--=============================================================================

function makeHTML()
  local HTML = {[[
<html>
<body>
<table border=1>
<tr> <th> Bin Number</th><th>Number of Cans</th><th>Type</th></tr>
]]}
  for bin_num, bin in pairs(storage) do
    table.insert(HTML, string.format("<tr> <td>%s</td><td>%s</td><td>%s</td></tr>", bin_num, bin.num_cans, bin.type_ or ""))
  end
  table.insert(HTML,[[</table></body></html>]])
  return table.concat(HTML, "\r\n")
end

--=============================================================================

file = io

--=============================================================================

function loadStorage()
  local ofile = file.open("storage.dat", "r")
  if not ofile then return false end
  
  local contents = ofile:read()
  storage = sjson.decode(contents)
  return true
end

--=============================================================================

function saveStorage()
  local ofile = file.open("storage.dat", "w")
  ofile:write(sjson.encode(storage))
end

--=============================================================================

