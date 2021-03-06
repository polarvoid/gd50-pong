push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    ballX = VIRTUAL_WIDTH/2 - 2
    ballY = VIRTUAL_HEIGHT/2 - 22

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    gameState = 'start'
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            ballX = VIRTUAL_WIDTH/2 - 2
            ballY = VIRTUAL_HEIGHT/2 - 22

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50)
        end
    end
end

function love.update(delta)
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y - PADDLE_SPEED * delta)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * delta)
    end

    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y - PADDLE_SPEED * delta)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * delta)
    end
    if gameState == 'play' then
        ballX = ballX + ballDX * delta
        ballY = ballY + ballDY * delta
    end
end

function love.draw()
    push:apply('start')
    love.graphics.clear(40/255, 45/255, 52/255, 1)
    love.graphics.setFont(smallFont)
    love.graphics.printf("Hello World", 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 - 50, VIRTUAL_HEIGHT/3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 + 50, VIRTUAL_HEIGHT/3)
    
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, player2Y, 5, 20)

    love.graphics.rectangle('fill', ballX, ballY, 4, 4)
    push:apply('end')
end
