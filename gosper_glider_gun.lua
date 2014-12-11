function make_gosper_glider_gun()
    -- The Gosper glider gun

    local fill = {
        -- Square
        { 2, 6}, { 3, 6},

        { 2, 7}, { 3, 7},

        -- Eye
        { 12, 6}, { 12, 7}, { 12, 8},

        { 13, 5}, { 13, 9},

        { 14, 4}, { 14, 10},

        { 15, 4}, { 15, 10},

        { 16, 7},

        { 17, 5}, { 17, 9},

        { 18, 6}, { 18, 7}, { 18, 8},

        { 19, 7},

        -- Fish
        { 22, 4}, { 22, 5}, { 22, 6},

        { 23, 4}, { 23, 5}, { 23, 6},

        { 24, 3}, { 24, 7},

        { 26, 2}, { 26, 3}, { 26, 7}, { 26, 8},


        -- Square
        { 36, 4}, { 36, 5},

        { 37, 4}, { 37, 5},
    }

    -- Finally build that bad boy
    for i,v in ipairs(fill) do
        grid[v[1]][v[2]].today = true
    end
end
