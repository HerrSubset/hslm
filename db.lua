--start module
local db = {}


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

end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--return module
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
return db