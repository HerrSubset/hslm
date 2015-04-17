--start module
local db = {}
local lfs = require "lfs"
local os = require "os"
local csv = require "csv"




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Private functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local function fileExists(fileName)
    local res = true

    local attr = lfs.attributes(fileName)

    if attr == nil then
        res = false
    end

    return res
end

--brings the program to the folder where all the save files should be stored
local function goToStorageFolder()
    local homeFolder = os.getenv("HOME")
    lfs.mkdir(homeFolder .. "/.hslm")
    lfs.chdir(homeFolder .. "/.hslm")
end


--stores a table as a csv file with the given filename
local function storeTable(fileName, table)
    --make sure file exists
    io.output(fileName)

    f = io.open(fileName, "wb")

    for i = 1, #table do
        local line = nil
        for j = 1, #table[i] do
            --do not print a comma if it's the first item
            if line then
                line = line .. "," .. table[i][j]
            else
                line = "" .. table[i][j]
            end
        end
        line = line .. "\n"
        f:write(line)
    end
    f:close()
end


--stores a row as a csv file with the given fileName
local function storeRow(fileName, row)
    --make sure file exists
    io.output(fileName)

    f = io.open(fileName, "wb")
    local line = nil
    for i = 1, #row do
        --do not print a comma if it's the first item
        if line then
            line = line .. "," .. row[i]
        else
            line = "" .. row[i]
        end
    end
    line = line .. "\n"
    f:write(line)
    f:close()
end


--function to retrieve the prices from their csv file
local function loadNumericTable(fileName)
    local res = {}

    if fileExists(fileName) then

        local f = csv.open(fileName)
        local lineNumber = 1

        for fields in f:lines() do
            local tmp = {}

            for i, v in ipairs(fields) do
                tmp[i] = tonumber(v)
            end

            res[lineNumber] = tmp
            lineNumber = lineNumber + 1
        end

    end

    return res
end


--function to load the items and shop rows from a csv file
local function loadStringRow(fileName)
    local res = {}

    if fileExists(fileName) then

        local f = csv.open(fileName)

        for fields in f:lines() do
            for i, v in ipairs(fields) do
                res[i] = v
            end
        end
    end

    return res
end




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Public functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--loads the tables with prices, stores and items for the given buildname.
function db.load(buildName)
    local pricesRes = {}
    local storesRes = {}
    local itemsRes = {}

    goToStorageFolder()
    pricesRes = loadNumericTable(buildName .. "_prices.csv")
    storeRes = loadStringRow(buildName .. "_stores.csv")
    itemsRes = loadStringRow(buildName .. "_items.csv")

    return pricesRes, storesRes, itemsRes
end


function db.save(buildName, prices, stores, items)
    goToStorageFolder()
    storeTable(buildName .. "_prices.csv", prices)
    storeRow(buildName .. "_stores.csv", stores)
    storeRow(buildName .. "_items.csv", items)
end




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--return module
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
return db
