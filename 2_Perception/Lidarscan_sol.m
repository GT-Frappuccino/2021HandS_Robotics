function [sensor] = Lidarscan_sol(Map, xi)
%%% argument dimension check %%%
arguments 
     Map (:,:) {mustBeNumeric}
     xi (1,3) {mustBeNumeric}
end                  

%%% current robot position %%%
x = xi(1); % integer
y = xi(2); % integer
theta = rad2deg(xi(3)) + 90; % 0, 45, 90 ...

%%% lidarscan result %%%
for i=1:8
    unit_dx = sign(cosd(theta + 45*(i-1)))*ceil(abs(cosd(theta + 45*(i-1)))); dx = unit_dx;
    unit_dy = sign(sind(theta + 45*(i-1)))*ceil(abs(sind(theta + 45*(i-1)))); dy = unit_dy;
    dist = sqrt(dx^2 + dy^2);
    while dist <= 2    
        if Map(x+dx,y+dy) == 1
            break
        end
        dx = dx + unit_dx;
        dy = dy + unit_dy;
        dist = sqrt(dx^2 + dy^2);
    end
    if dist > 2
        sensor(i) = Inf;
    else
        sensor(i) = dist;
    end
end
end