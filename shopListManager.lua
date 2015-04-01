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
--Functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function shopListManager.setPrice(storeName, itemName, price)
    --check if store exists

    --check if item exists

    --store item price
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
