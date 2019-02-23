clc
clear
total_speed = 500;
alpha = 8;
beta = -5;
C_W_S = [cos(alpha) 0 -sin(alpha);
    0 0 0;
    sin(alpha) 0 cos(alpha)];
C_S_B = [cos(beta) -sin(beta) 0;
    sin(beta) cos(beta) 0;
    0 0 1];
V_B_E = C_W_S*C_S_B*[total_speed;0;0]