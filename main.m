leftForward = -40;   %A
rightForward = -40; %D
leftBackwards = 25;
rightBackwards = 25;

limit = 40;

brick.SetColorMode(2, 2);

while 1
    brick.MoveMotor('A', leftForward);  %Move Forward
    brick.MoveMotor('D', rightForward); %Move Forward
    
    touch = brick.TouchPressed(3);  %Sensor Readings
    color = brick.ColorCode(2); %Sensor Readings
    distance = brick.UltrasonicDist(1); %Sensor Readings

    if color == 5       %Color Decisions                                  
        disp('red');    %if color is red stop for 4 sec    
        brick.StopMotor('AD', 'Brake'); %Brake to prevent going off
        pause(4); %wait 4 seconds
        brick.MoveMotor('A', leftForward); 
        brick.MoveMotor('D', rightForward);
        pause(0.5);
    elseif color == 2 || color == 3    %if color is blue or green, activate keyboardControl2.m
        disp('blue/green');
        run('keyboardControl2');
        brick.MoveMotor('A', leftForward);
        brick.MoveMotor('D', rightForward);
        pause(6);
    elseif color == 4   %if color is yellow, stop all motors
        disp('yellow');
        brick.StopAllMotors;
        break;
    end
    
    %Navigation
    if distance > limit     %if right wall falls away from right side
        pause(0.5); %wait to get past wall
        brick.StopMotor('AD', 'Brake');
        brick.MoveMotor('A', -20);
        pause(2); %turning time
        brick.StopMotor('A', 'Brake');
        brick.MoveMotor('A', leftForward); 
        brick.MoveMotor('D', rightForward);
        pause(2);
    end 
    if touch %if hit wall in front
        pause(1); %keep going forward for a short period of time
        
        disp('touched');
        brick.StopMotor('AD');          %stop
        dist = brick.UltrasonicDist(1); %get distance from right wall
        brick.MoveMotor('A', leftBackwards);
        brick.MoveMotor('D', rightBackwards);
        pause(3.5); %time to back up from wall
        brick.StopMotor('AD', 'Brake'); %stop
        
        if distance < limit %if there is no wall on the right
            brick.MoveMotor('D', -20); 
            pause(2.5);
            brick.StopMotor('D', 'Brake');
            brick.MoveMotor('A', leftForward); 
            brick.MoveMotor('D', rightForward);
            pause(2);
        else %if there is a wall on the right
            brick.MoveMotor('A', -20);
            pause(2.5);
            brick.StopMotor('A', 'Brake');
            brick.MoveMotor('A', leftForward); 
            brick.MoveMotor('D', rightForward);
            pause(2);
        end
    end
end