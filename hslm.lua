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
local title = "Herr's Shopping List Manager"
local content = nil
local slm = require "shopListManager"
local flashMessage = nil




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

    if flashMessage then
        stdscr:mvaddstr(2,10,flashMessage)
        flashMessage = nil
    end
end


--write prompt and move input cursor to correct position
local function drawCommandArea()
    stdscr:mvaddstr(height-2,0,"Enter Command:")
    stdscr:move(height-1,0)
end


--draw the content in the middle of the screen
local function drawContent()
    local content = slm.getContentTable()
    local startx = 0
    local starty = 3

    for i = 1, #content do
        for j = 1, #content[i] do
            stdscr:mvaddstr(starty, startx, content[i][j])
            starty = starty + 1
        end
        startx = startx + 7
        starty = 3
    end
end


--check if the given command is a valid command to exit the program
local function isValidExitCommand(c)
    return c == "q" or c == "exit" or c == "back"
end


--split command up, put it in an array and return it
local function getCommandArray(c)
    local res = {}

    --assert(string.match(command, "%a+%s%a+%s%a+%s%d+%.?%d*"))

    for str in string.gmatch(c, "%a+") do
        res[#res + 1] = str
    end

    res[4] = string.match(c, "%d+%.?%d*")

    return res
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Main program loop
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local go = true

while go do
    --draw UI
    stdscr:clear()
    drawTitle()
    drawContent()
    drawCommandArea()

    --get input
    local input = stdscr:getstr()

    --process input
    if isValidExitCommand(input) then
        --exit loop
        go = false
    else
        --process input
        commandArray = getCommandArray(input)
        slm.setPrice(commandArray[2], commandArray[3], commandArray[4])
    end
end

--end curses
curses.endwin()
