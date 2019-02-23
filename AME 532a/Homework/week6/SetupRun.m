clc
clear
%% Setup and Run
% Define Aircraft Mass and Geometry Properties (using grams)%    
                %mass   xSize   ySize   zSize   xLoc    yLoc    zLoc%    
                %1      2       3       4       5       6       7
GeometryMass = [90     0.1     0.96    0.01    -0.23    0.44   0;        % RightWing+Servo     
                 90     0.1     0.96    0.01    -0.23   -0.44   0;        % LeftWing+Servo     
                 13     0.075   0.35    0.002   -0.76   0       0.16;     % Elevator     
                 72     0.065   0.035   0.015   -0.05   0       0.03;     % Battery     
                 106    0.87    0.07    0.07    -0.4    0       0;        % Fuselage     
                 27     0.05    0.03    0.005   -0.05   0       0.02;     % Motor Controller     
                 10     0.04    0.02    0.005   0.1     0       0.02;     % Radio     
                 20     0.05    0.01    0.01    -0.014  0       0;        % 2 Servos  ??   
                 40     0.03    0.02    0.02    0.02    0       0.01;     % Motor     
                 12     0       0.26    0.025   0.05    0       0.01];    % Propeller
             
% Define Aerosurface Properties             
n_s =[0     0     0     0     0;
     0     0     1     0     0;
     0    -1     0    -1    -1];
CL0_s = [0         0         0    0.0500    0.0500];
e_s =[0 0.8000 0.8000 0.9000 0.9000];
i_s =[0 0 0 0.0500 0.0500];
CD0_s =[0 0.0100 0.0100 0.0100 0.0100];
CDa_s =[0 1 1 1 1];
a0_s =[0 0 0 0.0500 0.0500];
CM0_s =[0 0 0 -0.0500 -0.0500];
CMa_s =[0 0 0 0 0];
aerosurface_property = [n_s;CL0_s;e_s;i_s;CD0_s;CDa_s;a0_s;CM0_s;CMa_s];

angle_of_attack = 8;
side_slip_angle =-5 ;
total_speed =100;

sim('freebody_simulation_with_wind')