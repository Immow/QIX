local images = love.filesystem.getDirectoryItems("images")
local index = 1
local activeImage = love.graphics.newImage("images/"..images[index])
local cW = 600
local cH = 600
local imageCanvas = love.graphics.newCanvas(cW, cH)
local data = love.image.newImageData(cW,cH)
local hide = nil
function love.load()
	for y = 1, 600-1 do
		for x = 1, 600-1 do
			data:setPixel(x, y, 0, 0, 0, 1)
		end
	end

	for y = 1, 100 do
		for x = 1, 100 do
			data:setPixel(x, y, 1, 1, 1, 0)
		end
	end

	hide = love.graphics.newImage(data)
	love.graphics.setCanvas(imageCanvas)
	local w = imageCanvas:getWidth()
	local h = imageCanvas:getHeight()
	local imgW = activeImage:getWidth()
	local imgH = activeImage:getHeight()
	local scale = 1
	if imgW > imgH then
		scale = w / imgW
	else
		scale = h / imgH
	end
	love.graphics.draw(activeImage, 0, 0, 0, scale, scale)
	love.graphics.setCanvas()

end

function love.update() end

function love.draw()
	love.graphics.draw(imageCanvas, 0,0)
	love.graphics.rectangle("line", 0, 0, cW ,cH)
	love.graphics.draw(hide)
end
