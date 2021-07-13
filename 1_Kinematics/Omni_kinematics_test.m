function Omni_kinematics_test()
deltaT = 0.1; % deltaT for calculation (sec)
time = linspace(0,10,10*(1/deltaT)); % test time (sec)
phi_dot = [3;0;0]; % speed of wheels (rad/s)

% forward differential kinematics matrix
F = Omni_kinematics_sol();

% robot state (velocity expressed in robot frame)
xi_dot = F * phi_dot;
xi = [0; 0; pi/2];

% robot state calculation
R = abs(norm(xi_dot(1:2))/xi_dot(3));
w = xi_dot(3);

for i=2:10*(1/deltaT)
    theta = xi(3, i-1);
    xi(3, i) = theta + w*deltaT;
    if (xi_dot(3) > 0.00000001)
        xi(1:2, i) = xi(1:2, i-1) + [R*(-sin(theta)+sin(xi(3, i))); R*(cos(theta)-cos(xi(3, i)))];    
    else
        xi(1:2, i) = xi(1:2, i-1) + xi_dot(1:2)*deltaT;
    end
end

% plot x, y, theta
figure(1)
subplot(3, 1, 1);
plot(time, xi(1, :));
grid
xlabel("time [sec]")
ylabel("x [m]")

subplot(3, 1, 2);
plot(time, xi(2, :));
grid
xlabel("time [sec]")
ylabel("y [m]")

subplot(3, 1, 3);
plot(time, xi(3, :));
grid
xlabel("time [sec]")
ylabel("theta [rad]")

% plot Omni-directional Motion
figure(2)
plot(xi(1, :), xi(2,:), 'MarkerSize',5, "Color",'b');

xlabel("x [m]")
ylabel("y [m]")
xlim([-max(abs(xi(1,:)))-0.2 max(abs(xi(1,:)))+0.5])
ylim([-max(abs(xi(2,:)))-0.2 max(abs(xi(2,:)))+0.5])
hold on

for i=0:9
    x = xi(1, 1+i*(1/deltaT));
    y = xi(2, 1+i*(1/deltaT));
    theta = xi(3, 1+i*(1/deltaT));
    plot(x, y, '.', 'MarkerSize',10, "Color",'r');
    
    line([x x+0.1*cos(theta)], [y y+0.1*sin(theta)], 'Linewidth', 3, 'color', 'k');
end
grid
hold off
end