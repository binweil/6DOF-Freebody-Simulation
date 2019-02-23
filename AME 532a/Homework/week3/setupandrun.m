
timeStart = 0;
timeStop = 1000;
timeStep = 0.01;
deg2rad = pi/180;
Rearth=6371000;

xInit_E_E_BE = [Rearth; 0; 0];
thetaInit_BN_deg = [0; 0; 45];
thetaInit_BN = thetaInit_BN_deg * deg2rad;
quatInit_BN = att2quat(thetaInit_BN);
xDotInit_E_B_BE = [150; 0; 0];
InitRates = [0; 0; 0];
sim('Integrate_velocity_to_position');

function quat = att2quat(att)
quat = [0;0;0;0];
quat(1) = cos(att(1)/2)*cos(att(2)/2)*cos(att(3)/2) + sin(att(1)/2)*sin(att(2)/2)*sin(att(3)/2);
quat(2) = sin(att(1)/2)*cos(att(2)/2)*cos(att(3)/2) - cos(att(1)/2)*sin(att(2)/2)*sin(att(3)/2);
quat(3) = cos(att(1)/2)*sin(att(2)/2)*cos(att(3)/2) + sin(att(1)/2)*cos(att(2)/2)*sin(att(3)/2);
quat(4) = cos(att(1)/2)*cos(att(2)/2)*sin(att(3)/2) - sin(att(1)/2)*sin(att(2)/2)*cos(att(3)/2);
end
