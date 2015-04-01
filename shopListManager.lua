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
local items = {"cpu","psu"}
--array containing all the different stores
local stores = {"amazon","tones"}
--table showing the price of an item in a specific store
local prices = {{214.99,200},{40,50.33}}




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Private functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--add a column of 0's in the prices table at the given index
local function addEmptyPriceRow(index)
    -- create a new row for the new item
    prices[index] = {}

    --set prices in all stores to zero
    for i =1, #stores do
        prices[index][i] = 0
    end
end


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
    local res = {}

    --add item column
    local itemCol = {""}  --leave first space blank to have correct spacing
    for i = 1, #items do
            itemCol[i+1] = items[i]
    end

    res[1] = itemCol

    --add store columns
    for i = 1, #stores do
        local storeCol = {stores[i]}
        --get item prices for that store out of prices table
        for j = 1, #items do
            storeCol[j+1] = prices[j][i]
        end
        res[i+1] = storeCol
    end

    return res
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--return module
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
return shopListManager
