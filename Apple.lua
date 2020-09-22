Apple = Class{}

function Apple:init(x, y, width, height, character)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	self.dy = 0

	self.character = character
end

function Apple:reset()
	self.y = 0
	self.x = math.random(0, VIRTUAL_WIDTH)
end

function Apple:update(dt)
	self.y = self.y + self.dy * dt
end

function Apple:render()

	if self.character == 'bomb' then
		love.graphics.setColor(GOLD)
	elseif self.character == 'power' then
		love.graphics.setColor(PARROT)
	else
		love.graphics.setColor(CRIMSON)
	end

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