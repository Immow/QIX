local function myStencilFunction()
   -- Draw four overlapping circles as a stencil.
   love.graphics.circle("fill", 200, 250, 100)
   love.graphics.circle("fill", 300, 250, 100)
   love.graphics.circle("fill", 250, 200, 100)
   love.graphics.circle("fill", 250, 300, 100)
end
 
function love.draw()
   -- Each pixel touched by each circle will have its stencil value incremented by 1.
   -- The stencil values for pixels where the circles overlap will be at least 2.
   love.graphics.stencil(myStencilFunction, "increment")
 
   -- Only allow drawing in areas which have stencil values that are less than 2.
   love.graphics.setStencilTest("less", 2)
 
   -- Draw a big rectangle.
   love.graphics.rectangle("fill", 0, 0, 500, 500)
 
   love.graphics.setStencilTest()
end