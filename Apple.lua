Apple = Class{}

function Apple:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	self.dy = 0
end

--function Apple:reset()

--end

function Apple:update(dt)
	self.y = self.y + self.dy * dt
end

function Apple:render()
	love.graphics.setColor(CRIMSON)
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Apple:reachBottom()
	if self.y + self.height >= VIRTUAL_HEIGHT then
		return true
	end
end

function Apple:collides(bowl)
	if self.x > bowl.x + bowl.width or bowl.x > self.x + self.width then
		return false
	end

	if self.y > bowl.y + bowl.height or bowl.y > self.y + self.height then
		return false
	end

	return true
end