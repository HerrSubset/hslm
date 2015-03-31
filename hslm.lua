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
local content = nil
local slm = require "shopListManager"




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Helper functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--print title in center of screen and underline with dashes
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


--write prompt and move input cursor to correct position
local function drawCommandArea()
    stdscr:mvaddstr(height-2,0,"Enter Command:")
    stdscr:move(height-1,0)
end


--draw the content in the middle of the screen
local function drawContent()
    if content then
        stdscr:mvaddstr(4,0,content)
    end
end


--check if the given command is a valid command to exit the program
local function isValidExitCommand(c)
    return c == "q" or c == "exit" or c == "back"
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
    drawContent()
    drawCommandArea()

    local input = stdscr:getstr()

    if isValidExitCommand(input) then
        go = false
    else
        content = input
    end
end

--end curses
curses.endwin()
