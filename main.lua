push = require 'push'
Class = require 'class'

require 'Bowl'
require 'Apple'

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 433

BOWL_SPEED = 200
APPLE_SPEED = 80

SCORE = 0

--BACKGROUND = {240/255, 248/255, 255/255, 255/255}
BACKGROUND = {176/255,196/255,222/255,1}
BLUE = {0, 0, 1, 1}
WHITE = {1, 1, 1, 1}
CRIMSON = {220/255,20/255,60/255,1}
CHOCOLATE = {210/255,105/255,30/255,1}
GOLD = {255/255, 215/255, 0, 1}
PARROT ={124/255 ,252/255, 0, 1}

gameState = 'start'


function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Catch the Falling Apples')
	math.randomseed(os.time())
	smallFont = love.graphics.newFont('font.ttf', 8)
	mediumFont = love.graphics.newFont('font.ttf', 16)
	largeFont = love.graphics.newFont('font.ttf', 32)

	sounds = {
		['score'] = love.audio.newSource('sounds/score.wav', 'static'),
		['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
		['power'] = love.audio.newSource('sounds/power.wav', 'static'),
		['bomb'] = love.audio.newSource('sounds/bomb.wav', 'static'),
	}

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})

  bowl = Bowl(VIRTUAL_WIDTH/2 - 10, VIRTUAL_HEIGHT - 16 , 20, 12)

  apple1 = Apple(math.random(0, VIRTUAL_WIDTH), 0, 8, 8, 'apple')
  apple2 =  Apple(math.random(0, VIRTUAL_WIDTH), 0, 8, 8, 'apple')
  apple3 =  Apple(math.random(0, VIRTUAL_WIDTH), 0, 8, 8, 'apple')
  bomb =  Apple(math.random(0, VIRTUAL_WIDTH), 0, 8, 8, 'bomb')
  power =  Apple(math.random(0, VIRTUAL_WIDTH), 0, 8, 8, 'power')

  apples = {apple1, apple2, apple3, bomb, power}

end

function love.keypressed(key)
	-- body
	if key == 'escape' then
		love.event.quit()
	elseif key == 'enter' or key == 'return' then
		if gameState == 'pause' or gameState == 'start' then
			gameState = 'play'
		elseif gameState == 'play' then
			gameState = 'pause'
		elseif gameState == 'done' then
			gameState = 'play'
			--reset
		end
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
	apple1.dy = APPLE_SPEED
	apple2.dy = APPLE_SPEED - 20
	apple3.dy = APPLE_SPEED - 40
	bomb.dy = APPLE_SPEED - 20
	power.dy = APPLE_SPEED

	if gameState == 'play' then
		-- apple hit bottom
		--[[
		if apple1:reachBottom() then 
			sounds['hit']:play()
			apple1:reset()
			SCORE = SCORE - 1
		end

		-- apple caught by the bowl
		if apple1:collides(bowl) then 
			sounds['score']:play()
			apple1:reset()
			SCORE = SCORE + 1
		end
		apple1:update(dt)
		apple2:update(dt)
		]]--

		for i=1, #apples do
			apple = apples[i]
			if apple:reachBottom() then 
				sounds['hit']:play()
				apple:reset()
				SCORE = SCORE - 1
			end

			-- apple caught by the bowl
			if apple:collides(bowl) then 
				sounds['score']:play()
				apple:reset()
				if apple.character == 'bomb' then
					sounds['bomb']:play()
					gameState = 'done'
				elseif apple.character == 'power' then
					SCORE = SCORE + 5
					sounds['power']:play()
				else 
					SCORE = SCORE + 1
				end
			end
			apple:update(dt)
		end
	end

end

function love.draw()
	-- body
	push:apply('start')


	love.graphics.clear(BACKGROUND)

	love.graphics.setFont(smallFont)
	love.graphics.setColor(BLUE)
	--love.graphics.printf({BLUE, 'WELCOME!'}, 0, VIRTUAL_HEIGHT/2-32, VIRTUAL_WIDTH, 'center')

	love.graphics.printf({BLUE, 'SCORE: ' .. tostring(SCORE)}, -10, 10, VIRTUAL_WIDTH, 'right')

	

	if gameState == 'start' then
		love.graphics.setFont(smallFont)
		love.graphics.printf('Press ENTER to begin!', 0, 0, VIRTUAL_WIDTH, 'center')
	elseif gameState == 'pause' then
		love.graphics.setFont(smallFont)
		love.graphics.printf('Game PAUSED! Press ENTER to start!', 0, 0, VIRTUAL_WIDTH, 'center')
	elseif gameState == 'play' then
		for i=1, #apples do
			apples[i]:render()
		end
	elseif gameState == 'done' then
		love.graphics.setFont(mediumFont)
		love.graphics.printf('GAME OVER!', 0, 50, VIRTUAL_WIDTH, 'center')
		love.graphics.setFont(smallFont)
		love.graphics.printf('_Press ENTER to restart_', 0, 75, VIRTUAL_WIDTH, 'center')
	end

	bowl:render()
	--apple1:render()
	--apple2:render()



	push:apply('end')
end