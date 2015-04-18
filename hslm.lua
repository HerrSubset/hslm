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
end


--write prompt and move input cursor to correct position
local function drawCommandArea()
    local prompt = "Enter Command: "
    if flashMessage then
        prompt = prompt .. "(" .. flashMessage .. ")"
        flashMessage = nil
    end
    stdscr:mvaddstr(height-2,0, prompt)
    stdscr:move(height-1,0)
end

--converts all the items in the content table to strings
local function convertContentToStrings(contentMatrix)
    local res = contentMatrix

    for i = 1, #res do
        for j = 1, #res[i] do
            res[i][j] = tostring(res[i][j])
        end
    end

    return res
end


local function getLongestStringLength(row)
    --set default minimum width of 6
    local res = 6

    for i = 1, #row do
        res = math.max(res, string.len(row[i]))
    end

    return res
end

--draw a certain amount of hashes starting at a specific index
local function printHashes(y, x, length)
    local x = x
    local y = y

    stdscr:move(y,x)
    for i = 1, length do
        stdscr:addstr("#")
        x = x + 1
    end
end

--print a cell of the content table, print "-" when the cell contains '0'
local function printCell(cellContent, x, y)
    if cellContent == '0' then
        stdscr:mvaddstr(y, x, "-")
    else
        stdscr:mvaddstr(y, x, cellContent)
    end
end


--draw the content in the middle of the screen
local function drawContent()
    local content = slm.getContentTable()
    local startx = 0
    local starty = 3

    --set help message when there's no content
    if content == nil then
        text = 'type "update <storename> <itemname> <price>" to build up the table'
        stdscr:mvaddstr(height/2, width/2 - string.len(text)/2, text)

    else --start drawing content
        content = convertContentToStrings(content)
        for i = 1, #content do  --loop through all the columns

            --determinge column width
            local rowWidth = getLongestStringLength(content[i]) + 1

            for j = 1, #content[i] -1 do
                printCell(content[i][j], startx, starty)

                --move cursor for the next iteration
                starty = starty + 1
            end

            --print hashes row above the row with totals
            printHashes(starty, startx, rowWidth)
            starty = starty + 1

            --print the last cell of the row (the total)
            printCell(content[i][#content[i]], startx, starty)

            --bring cursor to top of next column
            startx = startx + rowWidth
            starty = 3
        end
    end
end


--check if the given command is a valid command to exit the program
local function isValidExitCommand(c)
    return c == "q" or c == "exit" or c == "back"
end

local function isValidUpdateCommand(c)
    local res = true

    if #c > 3 then
        if c[1] ~= "update" then
            res = false
        end
        
    else
        --c can't be correct if it doesn't contain 4 items at least
        res = false
    end

    return res
end


--split command up, put it in an array and return it
local function getCommandArray(c)
    local res = {}

    --assert(string.match(command, "%a+%s%a+%s%a+%s%d+%.?%d*"))

    for str in string.gmatch(c, "%S+") do
        res[#res + 1] = str
    end

    return res
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Main program loop
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local go = true
slm.loadBuild("default")

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
        --TODO: validate input as allowed command
        --process input
        commandArray = getCommandArray(input)
        if(isValidUpdateCommand(commandArray)) then
            slm.setPrice(commandArray[2], commandArray[3], tonumber(commandArray[4]))
        end
    end
end

--end curses
curses.endwin()
