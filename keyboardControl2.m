global key
InitKeyboard();
while 1
    pause(0.1);
    switch key
        case 'uparrow'
            %disp('Up');
            brick.MoveMotor('A', -30);
            brick.MoveMotor('D', -30);
            
        case 'downarrow'
            %disp('Down');
            brick.MoveMotor('A', 30);
            brick.MoveMotor('D', 30);
            
        case 'leftarrow'
            brick.MoveMotor('A', 18);
            brick.MoveMotor('D', -18);
            
        case 'rightarrow'
            brick.MoveMotor('A', -18);
            brick.MoveMotor('D', 18);
            
        case 0
            %disp('No Key Press');
            brick.StopMotor('ADC', 'Coast');
            
        case 'p'        % press the shift key to lift the forklift 
            brick.beep();
            brick.MoveMotorAngleRel('B', 7, 45, 'Brake'); % A is forklift motor
 
        case 'l'      % press the control kpey to push the forklift down
            brick.MoveMotorAngleRel('B', -7, 45, 'Brake');
            brick.beep();
            
        case 'q'
            brick.StopAllMotors;
            break;
    end
end

CloseKeyboard();