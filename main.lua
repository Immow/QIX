Tprint = require("Tprint")
local offset = 10
local images = love.filesystem.getDirectoryItems("images")
local index = 1
local activeImage = love.graphics.newImage("images/"..images[index])
local area = {w = 400, h = 400}
local overlayPixels = {}
local pixelState = {"Drawing","Line","Transparent"} -- Meta info
local scale = 1

local function overlayPixels_Init ()
	for x = 0, area.w - 1 do
		overlayPixels[x] = {}
		for y = 0, area.h - 1 do
			overlayPixels[x][y] = 0
		end
	end
end


local function overlayPixels_Draw()
	for x , c in pairs(overlayPixels) do
		for y, p in pairs(c) do
			if p == 1 then
				love.graphics.setColor(0,0,1,1)
			elseif p == 2 then
				love.graphics.setColor(1,1,1,1)
			elseif p == 3 then
				love.graphics.setColor(0,0,0,0)
			else
				love.graphics.setColor(0,0,0,1)
			end
			love.graphics.points(x+offset+0.5,y+offset+0.5)
		end
	end
	love.graphics.setColor(1,1,1,1)
end

---@param s integer state of pixel, 1 | Drawing, 2 | Line, 3 | Transparent
local function overlayPixels_Fill(sx,sy,s)
	if s == 0 then return end
	local stack = {{sx,sy}}
	local x
	local y
	local skip

	while #stack > 0 do
		x = stack[#stack][1] -- 1
		y = stack[#stack][2] -- 1
		skip = false
		if overlayPixels[x][y] == s then
			skip = true
		end
		overlayPixels[x][y] = s -- Set the state of this pixel to the given state
		table.remove(stack,#stack)

		if not skip then
			if x - 1 >= 0 and overlayPixels[x-1][y] == 0 then
				table.insert(stack,{x-1,y})
			end
			if x + 1 <= area.w - 1 and overlayPixels[x+1][y] == 0 then
				table.insert(stack,{x+1,y})
			end
			if y - 1 >= 0 and overlayPixels[x][y-1] == 0 then
				table.insert(stack,{x,y-1})
			end
			if y + 1 <= area.h - 1 and overlayPixels[x][y+1] == 0 then
				table.insert(stack,{x,y+1})
			end
		end
	end
end

function love.load()
	local imgW = activeImage:getWidth()
	local imgH = activeImage:getHeight()
	if imgW > imgH then
		scale = area.w / imgW
	else
		scale = area.h / imgH
	end

	overlayPixels_Init()

	overlayPixels_Fill(0, 0, 3)
	
	-- print(tprint(overlayPixels))
end

function love.update()
end

function love.draw()
	love.graphics.setColor(1,1,1,1)
	love.graphics.draw(activeImage, offset, offset, 0, scale, scale)
	overlayPixels_Draw()
	love.graphics.setColor(1,1,1,1)
	love.graphics.setColor(1,0,0,1)
	love.graphics.rectangle("line", offset, offset, area.w , area.h)
end
