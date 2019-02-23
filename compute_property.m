clc
clear
%% Define Aircraft Mass and Geometry Properties (using grams)%    
                        %mass   xSize   ySize   zSize   xLoc    yLoc    zLoc%    
                        %1      2       3       4       5       6       7
componentMassesAndGeom = [90     0.1     0.96    0.01    -0.23    0.44   0;        % RightWing+Servo     
                         90     0.1     0.96    0.01    -0.23   -0.44   0;        % LeftWing+Servo     
                         13     0.075   0.35    0.002   -0.76   0       0.16;     % Elevator     
                         72     0.065   0.035   0.015   -0.05   0       0.03;     % Battery     
                         106    0.87    0.07    0.07    -0.4    0       0;        % Fuselage     
                         27     0.05    0.03    0.005   -0.05   0       0.02;     % Motor Controller     
                         10     0.04    0.02    0.005   0.1     0       0.02;     % Radio     
                         20     0.05    0.01    0.01    -0.014  0       0;        % 2 Servos  ??   
                         40     0.03    0.02    0.02    0.02    0       0.01;     % Motor     
                         12     0       0.26    0.025   0.05    0       0.01];    % Propeller
[component_count,null] = size(componentMassesAndGeom);
total_mass = sum(componentMassesAndGeom(:,1));
center_of_gravity_local = componentMassesAndGeom(:,1).*componentMassesAndGeom(:,5:7)./componentMassesAndGeom(:,1)
center_of_gravity_global = sum(componentMassesAndGeom(:,1).*componentMassesAndGeom(:,5:7))/total_mass
%Inertia_matrix = 
for i = [1:1:component_count]
    J_xx_local(i) = 1/12*componentMassesAndGeom(i,1)*(componentMassesAndGeom(i,3)^2+componentMassesAndGeom(i,4)^2)+componentMassesAndGeom(i,1)*(center_of_gravity_local(i,1)-center_of_gravity_global(1))^2;
    J_yy_local(i) = 1/12*componentMassesAndGeom(i,1)*(componentMassesAndGeom(i,2)^2+componentMassesAndGeom(i,4)^2)+componentMassesAndGeom(i,1)*(center_of_gravity_local(i,2)-center_of_gravity_global(2))^2;
    J_zz_local(i) = 1/12*componentMassesAndGeom(i,1)*(componentMassesAndGeom(i,2)^2+componentMassesAndGeom(i,3)^2)+componentMassesAndGeom(i,1)*(center_of_gravity_local(i,3)-center_of_gravity_global(3))^2;
end
J_xx = sum(J_xx_local);
J_yy = sum(J_yy_local);
J_zz = sum(J_zz_local);
Inertial_matrix = [J_xx 0 0;
                    0 J_yy 0;
                    0 0 J_zz]
%% Aerosurface
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
density = 1.225;
total_speed = 500;
chord = [componentMassesAndGeom(1,2)+componentMassesAndGeom(2,2),
    componentMassesAndGeom(3,2),
    componentMassesAndGeom(5,2),
    componentMassesAndGeom(1,2),
    componentMassesAndGeom(2,2)];
span = [componentMassesAndGeom(1,3),
    componentMassesAndGeom(3,3),
    componentMassesAndGeom(5,3),
    componentMassesAndGeom(1,3),
    componentMassesAndGeom(2,3)];
area = chord.*span;
for i=[2:1:5]
    position_of_aerosurface(i) = 0.25*chord(i);
    AR_s(i) = span(i)/chord(i);
end
%% Forces Moments
for i=[2:1:5]
    a_s(i) = i_s(i);% -asin(
    AR_s(i) = span(i)/chord(i);
    CLa_s(i) = 2*pi*AR_s(i)/(2+AR_s(i));
    CL_s(i) = CL0_s(i) + CLa_s(i)*a_s(i);
    CD_s(i) = CD0_s(i) + CDa_s(i)*(a_s(i)-a0_s(i)) + CL_s(i)^2/(pi*e_s(i)*AR_s(i));
    CM_s(i) = CM0_s(i) + CMa_s(i)*a_s(i);
    Lift(i) = CL_s(i)*0.5*density*total_speed^2*area(i);
    Drag(i) = CD_s(i)*0.5*density*total_speed^2*area(i);
    Moment(i) = CM_s(i)*0.5*density*total_speed^2*area(i)*chord(i);
end




