function F = Omni_kinematics_sol()
%%% Wheel 1, the far right wheel %%%
alpha1 = 0;
beta1 = 0;
l1 = 1/2;

%%% Wheel 2, the top left wheel %%%
alpha2 = 2/3*pi;
beta2 = 0;
l2 = 1/2;
      
%%% Wheel 3, the bottom left wheel %%%
alpha3 = 4/3*pi;
beta3 = 0;
l3 = 1/2;

%%% matrices J, R %%%
J = [-sin(alpha1+beta1) cos(alpha1+beta1) l1*cos(beta1);
     -sin(alpha2+beta2) cos(alpha2+beta2) l2*cos(beta2);
     -sin(alpha3+beta3) cos(alpha3+beta3) l3*cos(beta3)];
R = eye(3)*0.1;

%%% F: forward differential kinematics matrix %%%
F = pinv(J)*R;
end