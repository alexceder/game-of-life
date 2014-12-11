--
-- Conway's Game of Life
--
-- @author  Alexander Cederblad
-- @email   alexcederblad@gmail.com
-- @website www.alexceder.se
--

require 'gosper_glider_gun'

function love.load()
    -- Might want the width and height
    --width, height = love.window.getDimensions()

    -- Init board
    grid = {}
    grid.w = 80
    grid.h = 60
    grid.s = 10

    for x = -1, grid.w do
        grid[x] = {}
        for y = -1, grid.h do
           grid[x][y] = { today = false, tomorrow = false }
        end
    end

    -- From gosper_glider_gun.lua
    make_gosper_glider_gun()

    --[[
    -- Create a random grid of active points
    for x = -1, grid.w do
        grid[x] = {}
        for y = -1, grid.h do
            local active = true

            -- Do not populate the padded edges
            if x == -1 or x == grid.w or
               y == -1 or y == grid.h then
               active = false
           else
               active = love.math.random(0, 1) == 0 and true or false
           end

           grid[x][y] = { today = active, tomorrow = false }
        end
    end
    ]]--

    -- Step time setup
    step = 0
    rate = 8
end

function love.update(dt)
    love.window.setTitle('Conway\'s Game of Life a la layback (' .. love.timer.getFPS() .. ' fps)')

    -- Return if we do not want to update yet.
    -- This is quite silly since the calculations might be slow.
    -- In this case though, it works.. however a more sophisticated
    -- algorithm would calculate and save the state during this
    -- auxilary time.
    step = step + dt

    if step < 1/rate then
        return
    end

    -- Do the calculations
    calc_tomorrow()

    -- Turn today into tomorrow
    step_grid()

    -- Also reset the step time when update is done
    step = 0
end

function love.draw()
    for x = 0, grid.w - 1 do
        for y = 0, grid.h - 1 do
            if grid[x][y].today then
                love.graphics.rectangle('fill', x*grid.s, y*grid.s, grid.s, grid.s)
            end
        end
    end
end

function step_grid()
    for x = 0, grid.w - 1 do
        for y = 0, grid.h - 1 do
            grid[x][y].today = grid[x][y].tomorrow
        end
    end
end

function calc_tomorrow()
    for x = 0, grid.w - 1 do
        for y = 0, grid.h - 1 do
            local neighbors = calc_neighbors(x, y)

            if grid[x][y].today then
                -- Things to do to live cells
                if neighbors == 2 or neighbors == 3 then
                    grid[x][y].tomorrow = true
                else
                    grid[x][y].tomorrow = false
                end
            else
                -- Things to do to dead cells
                if neighbors == 3 then
                    grid[x][y].tomorrow = true
                else
                    grid[x][y].tomorrow = false
                end
            end
        end
    end
end

function calc_neighbors(x, y)
    local neighbors = 0

    -- Might be done prettier?
    if (grid[x-1][y-1].today) then neighbors = neighbors + 1 end
    if (grid[x][y-1].today) then neighbors = neighbors + 1 end
    if (grid[x+1][y-1].today) then neighbors = neighbors + 1 end
    if (grid[x-1][y].today) then neighbors = neighbors + 1 end
    if (grid[x+1][y].today) then neighbors = neighbors + 1 end
    if (grid[x-1][y+1].today) then neighbors = neighbors + 1 end
    if (grid[x][y+1].today) then neighbors = neighbors + 1 end
    if (grid[x+1][y+1].today) then neighbors = neighbors + 1 end

    return neighbors
end
