Config = {
    img = "qb-inventory/html/images/", -- Set this to your inventory
    pedmodel = 0xD8F9CD47, -- Ped model hash where you start the delivery
    OpenWithItem = false, -- Open the Moneywash with a specific item ?
    ItemName = "", -- Item name used to open up the washing menu
    RemoveItem = false, -- Remove the item when used to wash money ?
    BlackMoneyName = "dirtycash", -- The name of the item thats used as black money
    Percentage = 1.0, -- The percentage of money the player gets back after washing. 1.0 is 100% 0.1 is 10%
}

Config.Locations = {
["coords"] = {
    -- [1] = vector4(388.19, -7.95, 86.67-0.9, 200.17),
    -- [1] = vector4(139.12, 324.15, 111.14-0.9, 113.1),
    -- [2] = vector4(145.1, 311.59, 111.14-0.9, 122.84)
	[1] =  vector4(55.56, 165.78, 104.79-0.9, 240.58),
        [2] =  vector4(-1808.01, -404.5, 44.61-0.9, 279.01),
        [3] =  vector4(998.56, -1489.6, 31.4-0.9, 6.38),
        [4] =  vector4(-1156.95, -2033.12, 13.16-0.9, 174.09),
        [5] =  vector4(-1543.12, -590.62, 34.87-0.9, 3.41)
}
}