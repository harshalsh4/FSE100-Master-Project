global key
InitKeyboard();

while 1
    pause(0.1);
    switch key
        case 'uparrow'
            brick.MoveMotor('B', 50);  % press up arrow to go forward
            brick.MoveMotor('C', 50);  
        
        case 'downarrow'    % press down arrow to go backwards
            brick.MoveMotor('B', -50);  % B is left wheel motor
            brick.MoveMotor('C', -50);  % C is right wheel motor

        case 'leftarrow'    % press left arrow on keyboard to turn left
            brick.MoveMotor('C', 20);
            brick.MoveMotor('B', -20);
            
        case 'rightarrow'   % press right arrow on keyboard to turn right
            brick.MoveMotor('B', 20);
            brick.MoveMotor('C', -20);         
           
        case 'shift'        % press the shift key to lift the forklift 
            brick.MoveMotor('A', 13);   % A is forklift motor

        case 'control'      % press the control key to push the forklift down
            brick.MoveMotor('A', -13);

        case 'space'        % press space to stops all motors
            brick.StopMotor('B');
            brick.StopMotor('C');
            brick.StopMotor('A');

        case 'q'            % press "q" to quit.
            break;
    end
end
CloseKeyboard();
