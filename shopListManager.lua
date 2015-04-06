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
local items = {}
--array containing all the different stores
local stores = {}
--table showing the price of an item in a specific store
local prices = {}




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

--build the full content table
local function buildContentTable()
    local res = {}

    res[1] = getItemColumn()
    res[2] = getMinimumPricesColumn()

    tmp = getPriceColumns()

    for i =1, #tmp do
        res[#res + 1] = tmp[i]
    end

    return res
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
end


function shopListManager.getContentTable()
    local res = nil

    --only return something else than nil when there's content
    if #prices > 0 then
        res = buildContentTable()
    end

    return res
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--return module
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
return shopListManager
