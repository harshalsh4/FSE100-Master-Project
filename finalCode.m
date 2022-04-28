%{
ports:
ultrasonic: 1
color: 2
touch: 3
left motor:  A
right motor: D
%}

motorlf = -60;   %A
motorrf = -60; %D
motorlb = 20;
motorrb = 20;

threshold = 50;

brick.SetColorMode(2, 2);

while 1
    %Move Forward
    brick.MoveMotor('A', motorlf);
    brick.MoveMotor('D', motorrf);
    
    %Get Sensor Readings
    touch = brick.TouchPressed(3);
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(1);

    
    %Color Decisions
    if color == 5                      %if color is red stop for 4 sec                   
        disp('red');
        brick.StopMotor('AD', 'Brake'); %Brake to prevent going off course
        pause(4); %wait 4 seconds
        brick.MoveMotor('A', motorlf); 
        brick.MoveMotor('D', motorrf);
        pause(0.5);
    elseif color == 2 || color == 3    %if color is blue or green, activate keyboard control
        disp('blue/green');
        run('keyboardControl2');
        brick.MoveMotor('A', motorlf);
        brick.MoveMotor('D', motorrf);
        pause(1);
    elseif color == 4   %if color is yellow, stop all motors
        disp('yellow');
        pause(1);
        brick.StopAllMotors;
        break;
    end
    
    %Navigation
    if distance > threshold                %if right wall falls away from right side
        pause(0.5); %wait to get past wall
        brick.StopMotor('AD', 'Brake');
        brick.MoveMotor('A', -27.3);
        pause(2.2); %turning time
        brick.StopMotor('A', 'Brake');
        brick.MoveMotor('A', motorlf); 
        brick.MoveMotor('D', motorrf);
        pause(2);
    end 
    if touch %if hit wall in front
        pause(0.2); %keep going forward for a short period of time in order to calibrate
        
        disp('touched');
        brick.StopMotor('AD');          %stop
        dist = brick.UltrasonicDist(1); %get distance from right wall
        brick.MoveMotor('A', motorlb);
        brick.MoveMotor('D', motorrb);
        pause(3); %time to back up from wall
        brick.StopMotor('AD', 'Brake'); %stop
        
        if distance < threshold %if there is no wall on the right
            brick.MoveMotor('D', -27.3); 
            pause(2.2);
            brick.StopMotor('D', 'Brake');
            brick.MoveMotor('A', motorlf);
            brick.MoveMotor('D', motorrf);
            pause(1.5);
        else %if there is a wall on the right
            brick.MoveMotor('A', -29);
            pause(2.4);
            brick.StopMotor('A', 'Brake');
            brick.MoveMotor('A', motorlf); 
            brick.MoveMotor('D', motorrf);
            pause(2);
        end
    end
end