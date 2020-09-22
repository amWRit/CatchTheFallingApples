push = require 'push'
Class = require 'class'

require 'Bowl'

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 433

BOWL_SPEED = 200

BACKGROUND = {240/255, 248/255, 255/255, 255/255}
BLUE = {0, 0, 1, 1}
WHITE = {1, 1, 1, 1}
CRIMSON = {220/255,20/255,60/255,1}
CHOCOLATE = {210/255,105/255,30/255,1}

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Catch the Falling Apples')
	math.randomseed(os.time())
	smallFont = love.graphics.newFont('font.ttf', 8)
	mediumFont = love.graphics.newFont('font.ttf', 16)
	largeFont = love.graphics.newFont('font.ttf', 32)

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})

	bowl = Bowl(VIRTUAL_WIDTH/2 - 10, VIRTUAL_HEIGHT - 16 , 20, 12)
end

function love.keypressed(key)
	-- body
	if key == 'escape' then
		love.event.quit()
	end
end

function love.resize(w,h)
	-- body
	push:resize(w,h)
end

function love.update(dt)
	-- body
	if love.keyboard.isDown('left') then
		bowl.dx = -BOWL_SPEED
		bowl:update(dt)
	elseif love.keyboard.isDown('right') then
		bowl.dx = BOWL_SPEED
		bowl:update(dt)
	end

	
end

function love.draw()
	-- body
	push:apply('start')

	love.graphics.clear(BACKGROUND)

	love.graphics.setFont(largeFont)
	love.graphics.printf({BLUE, 'WELCOME!'}, 0, VIRTUAL_HEIGHT/2-32, VIRTUAL_WIDTH, 'center')

	bowl:render()

	push:apply('end')
end