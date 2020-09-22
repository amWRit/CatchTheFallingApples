Bowl = Class{}

function Bowl:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	self.dx = 0
end

--function Bowl:reset()
--	self.x = VIRTUAL_WIDTH/2
--	self.y = VIRTUAL_HEIGHT - 10
--	self.dx = 1
--end

function Bowl:update(dt)
	if self.dx < 0 then
		self.x = math.max(2, self.x + self.dx * dt)
	else
		self.x = math.min(VIRTUAL_WIDTH - self.width - 2 , self.x + self.dx * dt)
	end
end

function Bowl:render()
	love.graphics.setColor(CHOCOLATE)
	--love.graphics.rectangle('fill', self.x, self.y + 6, self.width, self.height - 6)
	--love.graphics.rectangle('fill', self.x, self.y, 6, 6)
	--love.graphics.rectangle('fill', self.x + self.width - 6, self.y, 6, 6)

	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
	love.graphics.setColor(BACKGROUND)
	love.graphics.rectangle('fill', self.x + 6, self.y, 8, 6)
	
end