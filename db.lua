--start module
local db = {}
local lfs = require "lfs"




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Private functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local function goToStorageFolder()

end

local function storeTable(path, table)

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



    return pricesRes, storesRes, itemsRes
end


function db.save(buildName, prices, stores, items)
    goToStorageFolder()
    storeTable(buildName .. "_prices.csv", prices)
    storeTable(buildName .. "_stores.csv", stores)
    storeTable(buildName .. "_items.csv", items)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--return module
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
return db
