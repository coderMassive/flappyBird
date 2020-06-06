function love.load()
	flappy = love.graphics.newImage("bird.png")
	width = flappy:getWidth()
	bird = {}
	bird.y = 300
	bird.ground = 0
	bird.y_velocity = 0
	bird.jump_velocity = -300	
	bird.gravity = -500
	bird.score = 0
	isPressed = false
	spawn_bottom_pipe()
	spawn_top_pipe()
end

function spawn_bottom_pipe()
	bottom_pipe = {}
	bottom_pipe.x = love.graphics.getWidth()
	bottom_pipe.height = love.math.random(0, love.graphics.getHeight()/2)
	bottom_pipe.y = love.graphics.getHeight() - bottom_pipe.height
	bottom_pipe.width = 50
	bottomExtra = {}
	bottomExtra.x = bottom_pipe.x - 20
	bottomExtra.height = 20
	bottomExtra.y = bottom_pipe.y
	bottomExtra.width = bottom_pipe.width + 20 + 20
end

function spawn_top_pipe()
	top_pipe = {}
	top_pipe.x = love.graphics.getWidth()
	top_pipe.height = love.graphics.getHeight() - bottom_pipe.height - love.math.random(100, 150)
	top_pipe.y = 0
	top_pipe.width = 50
	topExtra = {}
	topExtra.x = top_pipe.x - 20
	topExtra.height = 20
	topExtra.y = top_pipe.height - topExtra.height
	topExtra.width = top_pipe.width + 20 + 20
end

function love.update(dt)
	if (love.keyboard.isDown('space') and not isPressed) then
		bird.y_velocity = bird.jump_velocity
		isPressed = true
	end

	bird.y = bird.y + bird.y_velocity * dt
	bird.y_velocity = bird.y_velocity - bird.gravity * dt
end

function love.keyreleased(key)
   if key == "space" then
      isPressed = false
   end
end

function love.draw()
	love.graphics.reset()
	love.graphics.setBackgroundColor(0, 1, 1)
	font = love.graphics.setNewFont(20)
	love.graphics.draw(flappy, 250, bird.y)
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle('fill', bottom_pipe.x, bottom_pipe.y, bottom_pipe.width, bottom_pipe.height)
	love.graphics.rectangle('fill', bottomExtra.x, bottomExtra.y, bottomExtra.width, bottomExtra.height)
	love.graphics.rectangle('fill', top_pipe.x, top_pipe.y, top_pipe.width, top_pipe.height)
	love.graphics.rectangle('fill', topExtra.x, topExtra.y, topExtra.width, topExtra.height)
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(tostring(bird.score))
	bottom_pipe.x = bottom_pipe.x - 5
	bottomExtra.x = bottomExtra.x - 5
	top_pipe.x = top_pipe.x - 5
	topExtra.x = topExtra.x - 5
	if bottom_pipe.x <= -50 then
		spawn_bottom_pipe()
	end

	if top_pipe.x <= -50 then
		spawn_top_pipe()
	end

	if (bottom_pipe.x + 50) == 210 then
		bird.score = bird.score + 1
	end

	if (bird.y > love.graphics.getHeight() or bird.y < 0 or (bottom_pipe.x <= 220 + width and bottom_pipe.x > 200 and (bird.y + 90) >= bottom_pipe.y) or (top_pipe.x <= 220 + width and top_pipe.x >200 and (bird.y + 30) <= top_pipe.height)) then
		love.load()
	end
end