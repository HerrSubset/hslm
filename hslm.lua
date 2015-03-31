-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--HerrSubset's Shopping List Manager
--
--Compare prices at different stores and keep them up to date. Conveniently
--shows you where the lowest price for each product in your list can be found.
--Also shows the total of all the lowest prices so you know how much money
--you'll spend at minimum.
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Global variables
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--initialize curses
local curses = require("curses")
curses.initscr()
local stdscr = curses.stdscr()

--other variables
local height, width = stdscr:getmaxyx()
local title = "Herr's Shop List Manager"

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Helper functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local function drawTitle()
    --print title in center of screen
    startx = math.floor(width/2) - math.floor(string.len(title)/2)
    stdscr:mvaddstr(0,startx,title)

    --add dottet line under title
    for i = 1, string.len(title) do
        stdscr:move(1,startx+(i-1))
        stdscr:addch("-")
    end
end

local function drawCommandArea()
    stdscr:mvaddstr(height-2,0,"Enter Command:")
    stdscr:move(height-1,0)
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Main program loop
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------



local go = true

while go do
    stdscr:clear()
    drawTitle()
    drawCommandArea()

    local input = stdscr:getstr()

    if input == "exit" then
        go = false
    end
end



--end curses
curses.endwin()
