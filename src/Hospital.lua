Hospital = Class{}

function Hospital:init(player, level)
    self.level = level

    -- physical layout
    self.width = 16
    self.height = 16
    self.walls = {}

    self.player = player
    self.patient = Patient{
        x = 0,
        y = 18,
        width = 16,
        height = 16,
        direction = 'down',
        health = 200
    }
    self.healthBar = HealthBar{
        x = 0,
        y = 12,
        width = 16,
        height = 4,
        value = 200,
        max = 200
    }
    self.container = Container{
        x = 240,
        y = 240,
        width = 16,
        height = 16
    }

    -- if on higher levels, create vampire
    if self.level >= 6 then
        self.vampire = Vampire{
            x = 0,
            y = 240,
            width = 16,
            height = 16,
            direction = 'down',
            speed = 50
        }

        self.vampire.walking = true
    end

    self.timer = 100
    self.stunTimer = 10
    self.bounceFlag = false
    self.bounceTimer = 5

    self.multiplier = nil

    if self.level == 2 or self.level == 9 then
        self.multiplier = 8
    elseif self.level == 3 or self.level == 8 then
        self.multiplier = 6
    elseif self.level == 4 or self.level == 7 then
        self.multiplier = 5
    elseif self.level == 5 or self.level == 6 then
        self.multiplier = 3
    end

    -- change wall layout every level
    if self.multiplier ~= nil then
        for y = 1, (self.height/4) do
            for x = 1, math.floor(self.width/self.multiplier) do
                table.insert(self.walls, Wall{
                    x = x*16*self.multiplier,
                    y = (y-1)*16*4,
                    width = 16,
                    height = 16
                })
            end
        end
    end
end

function Hospital:update(dt)
    self.player:update(dt)
    self.timer = self.timer - dt

    -- keep patient in front of player
    self.patient.direction = self.player.direction
    if self.patient.direction == 'up' then
        self.patient.x = self.player.x
        self.patient.y = self.player.y - self.patient.height + 5
    elseif self.patient.direction == 'down' then
        self.patient.x = self.player.x
        self.patient.y = self.player.y + self.player.height - 5
    elseif self.patient.direction == 'left' then
        self.patient.x = self.player.x - self.patient.width + 2
        self.patient.y = self.player.y
    elseif self.patient.direction == 'right' then
        self.patient.x = self.player.x + self.player.width - 2
        self.patient.y = self.player.y
    end

    -- keep patient from going past boundaries
    if self.patient.x < 0 then
        self.player.x = 16
    elseif self.patient.x > 240 then
        self.player.x = 224
    elseif self.patient.y < 0 then
        self.player.y = 16
    elseif self.patient.y > 240 then
        self.player.y = 224
    end

    -- collision detection for walls
    if #self.walls > 0 then
        for k, wall in pairs(self.walls) do
            if self.patient:collides(wall) then
                if self.patient.x < wall.x then
                    self.player.x = wall.x - 32
                elseif self.patient.x > wall.x then
                    self.player.x = wall.x + 32
                elseif self.patient.y < wall.y then
                    self.player.y = wall.y - 32
                elseif self.patient.y > wall.y then
                    self.player.y = wall.y + 32
                end
            end
        end
    end

    -- if pumping blood increase health of patient, otherwise drain it
    if love.keyboard.isDown('space') and self.patient.health < 200 and self.player.walking == false then
        self.patient.health = self.patient.health + 1.5
    else
        self.patient.health = self.patient.health - 0.25*(self.level)
    end

    -- game over if patient loses all health or timer is up
    if self.patient.health <= 0 or self.timer <= 0 then
        gStateMachine:change('game-over')
    end
    
    -- update health bar
    self.healthBar:updateValue(self.patient.health)
    self.healthBar.x = self.patient.x
    self.healthBar.y = self.patient.y - 6

    if self.vampire then
        -- vampire will move towards patient
        if self.vampire.walking then
            if self.patient.x < self.vampire.x then
                self.vampire.x = self.vampire.x - self.vampire.speed*dt
            elseif self.patient.x > self.vampire.x then
                self.vampire.x = self.vampire.x + self.vampire.speed*dt
            end

            if self.patient.y < self.vampire.y then
                self.vampire.y = self.vampire.y - self.vampire.speed*dt
                self.vampire.direction = 'up'
            elseif self.patient.y > self.vampire.y then
                self.vampire.y = self.vampire.y + self.vampire.speed*dt
                self.vampire.direction = 'down'
            end
        end

        -- if vampire reaches patient it will suck its blood
        if self.vampire:collides(self.patient) then
            self.vampire.suck = true
            self.vampire.walking = false
        end

        if self.vampire.suck then
            self.patient.health = self.patient.health - 0.5

            -- press space to stun vampire
            if love.keyboard.keysPressed['space'] and self.player.walking == false then
                self.vampire.suck = false
                self.vampire.stunned = true
            end
        end

        -- if vampire is stunned it will be unable to move for a period of time
        if self.vampire.stunned then
            self.stunTimer = self.stunTimer - dt
        
            if self.stunTimer <= 0 then
                self.vampire.stunned = false
                self.vampire.walking = true
                self.stunTimer = 10
            end
        end

        -- walls will bounce back the vampire
        if #self.walls > 0 then
            for k, wall in pairs(self.walls) do
                if self.vampire:collides(wall) then
                    if self.vampire.x < wall.x then
                        self.vampire.x = wall.x - 16
                    elseif self.vampire.x > wall.x then
                        self.vampire.x = wall.x + 16
                    elseif self.vampire.y < wall.y then
                        self.vampire.y = wall.y - 16
                    elseif self.vampire.y > wall.y then
                        self.vampire.y = wall.y + 16
                    end

                    self.bounceFlag = true
                    self.vampire.speed = -self.vampire.speed
                end
            end
        end

        if self.vampire.x < 0 then
            self.vampire.x = 0
        elseif self.vampire.x > 240 then
            self.vampire.x = 240
        elseif self.vampire.y < 0 then
            self.vampire.y = 0
        elseif self.vampire.y > 240 then
            self.vampire.y = 240
        end

        if self.bounceFlag == true then
            self.bounceTimer = self.bounceTimer - dt

            -- if vampire goes offscreen it will return to normal
            if self.bounceTimer <= 0
              or self.vampire.x <= 0 or self.vampire.x >= 240
              or self.vampire.y <= 0 or self.vampire.y >= 240 then
                self.bounceFlag = false
                self.vampire.speed = -self.vampire.speed
                self.bounceTimer = 5
            end
        end
    end

    -- go to next level if patient reaches container
    if self.patient:collides(self.container) then
        if self.level == 10 then
            gStateMachine:change('victory')
        else
            gStateMachine:change('play',{
                level = self.level + 1
            })
        end
    end
end

function Hospital:render()
    -- render floor tiles
    for y = 1, self.height do
        for x = 1, self.width do
            love.graphics.draw(gTextures['tile'], (x - 1)*16, (y - 1)*16)
        end
    end

    if #self.walls > 0 then
        for k, wall in pairs(self.walls) do
            wall:render()
        end
    end

    if self.player then
        self.player:render()
    end

    if self.patient then
        self.patient:render()

        if self.player.y > self.patient.y then
           self.player:render()
        end
    end

    if self.healthBar then
        self.healthBar:render()
    end

    if self.vampire then
        self.vampire:render()
    
        if self.player.y > self.vampire.y then
            self.player:render()
        end

        if self.patient.y > self.vampire.y then
            self.patient:render()
        end

        if self.player.y > self.vampire.y and self.player.y > self.patient.y then
            self.player:render()
        end
    end

    if self.container then
        self.container:render()
    end

    -- render timer
    love.graphics.printf(tostring(math.floor(self.timer)), 0, 0, 256, 'right')
end