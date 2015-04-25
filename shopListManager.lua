-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--HerrSubset's Shopping List Manager (module)
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--start module
local shopListManager = {}



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Global variables
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--array used to store the different items in the shopping list
local items = nil
--array containing all the different stores
local stores = nil
--table showing the price of an item in a specific store
local prices = nil

local currentBuild = nil

local db = require "db"




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Private functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--add a row of 0's in the prices table at the given index
local function addEmptyPriceRow(index)
    -- create a new row for the new item
    prices[index] = {}

    --set prices in all stores to zero
    for i =1, #stores do
        prices[index][i] = 0
    end
end


--add a column of 0's in the prices table at the given index
local function addEmptyPriceColumn(index)
    for i = 1, #items do
        prices[i][index] = 0
    end
end


--create store if it doesn't exist and returns the index of the new store.
--If the store already existed it just returns the store's index.
local function createStore(storeName)
    res = nil

    --check if store exists
    for i =1, #stores do
        if stores[i] == storeName then
            res = i
        end
    end

    --create store if it didn't exist
    if not res then
        stores[#stores + 1] = storeName
        res = #stores
        addEmptyPriceColumn(res)
    end

    return res
end


--create item if it doesn't exist and returns the index of the new item.
--If the item already existed it just returns the item's index.
local function createItem(itemName)
    res = nil

    --check if item exists
    for i = 1, #items do
        if items[i] == itemName then
            res = i
        end
    end

    --create item if it didn't exist
    if not res then
        items[#items + 1] = itemName
        res = #items
        addEmptyPriceRow(res)
    end

    return res
end


--get the minimal price of a certain row in the prices table
local function getMinOfRow(index)
    local res = 999
    local row = prices[index]

    for i = 1, #row do
        if (row[i] < res) and (row[i] ~= 0) then
            res = row[i]
        end
    end

    return res
end




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Content building functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--return an array containing all the items, with the first space being blank
--to have correct spacing
local function getItemColumn()
    local res = {""}  --leave first space blank to have correct spacing

    for i = 1, #items do
        res[i+1] = items[i]
    end

    return res
end


--return a column with the lowest prices for every item
local function getMinimumPricesColumn()
    local res = {"Minimum"}

    for i = 1, #items do
        res[i+1] = getMinOfRow(i)
    end

    return res
end


--returns a table with all the prices per store, with the storename on top
--of every column
local function getPriceColumns()
    local res = {}

    for i = 1, #stores do
        local storeCol = {stores[i]}
        --get item prices for that store out of prices table
        for j = 1, #items do
            storeCol[j+1] = prices[j][i]
        end
        res[i] = storeCol
    end

    return res
end


--returns the sum of the numbers in the given column
local function getSumOfCol(column)
    local res = 0

    for i = 2, #column do
        res = res + column[i]
    end

    return res
end


--add a row containing the total of every column
local function addTotalRow(table)
    table[1][#table[1] + 1] = "total"

    --calculate sum for every store and the minimum column
    for i = 1, #stores +1 do
        table[i+1][#table[i+1] +1] = getSumOfCol(table[i+1])
    end

    return table
end


--build the full content table
local function buildContentTable()
    local res = {}

    res[1] = getItemColumn()
    res[2] = getMinimumPricesColumn()

    local tmp = getPriceColumns()

    for i =1, #tmp do
        res[#res + 1] = tmp[i]
    end

    res = addTotalRow(res)

    return res
end


--delete item at index i and move the following items forward
local function deleteAtIndex(i, array)
    --move items
    for index = i, (#array -1) do
        array[index] = array[index + 1]
    end

    --remove last item in array
    array[#array] = nil
end




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Public functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function shopListManager.setPrice(storeName, itemName, price)

    local storeIndex = createStore(storeName)
    local itemIndex = createItem(itemName)

    --store item price
    prices[itemIndex][storeIndex] = price

    db.save(currentBuild, prices, stores, items)
end


function shopListManager.getContentTable()
    local res = nil

    --only return something else than nil when there's content
    if #prices > 0 then
        res = buildContentTable()
    end

    return res
end

--retrieve build from the db module
function shopListManager.loadBuild(buildName)
    prices, stores, items = db.load(buildName)
    currentBuild = buildName
end


--remove an item and it's prices from the build
function shopListManager.removeItem(itemName)
    --createItem returns the index of the item. If it creates a new item, we
    --will just undo it anyway.
    local index = createItem(itemName)

    deleteAtIndex(index, items)
    deleteAtIndex(index, prices)
    
    db.save(currentBuild, prices, stores, items)
end


--remove a store and it's prices from the build
function shopListManager.removeStore(storeName)
    --createStore returns the index of the store. If it creates a new store, we
    --will just undo it anyway.
    local index = createStore(storeName)

    deleteAtIndex(index, stores)
    for i = 1, #prices do
        deleteAtIndex(index, prices[i])
    end

    db.save(currentBuild, prices, stores, items)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--return module
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
return shopListManager
