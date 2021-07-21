function Lidarscan_test()
Map = [ 
    1   1   1   1   1   1   1   1   1   1;
    1   1   0   0   0   0   1   0   0   1;
    1   1   0   1   0   0   0   0   0   1;
    1   0   1   0   0   0   0   1   1   1;
    1   0   0   0   1   0   0   0   0   1;
    1   0   1   0   0   0   0   0   0   1;
    1   1   0   0   0   0   1   0   0   1;
    1   1   0   1   0   0   1   0   0   1;
    1   0   1   0   0   1   0   1   1   1;
    1   1   1   1   1   1   1   1   1   1];

xi = [5 6 0;6 6 pi/4;7 6 pi;7 5 0;7 4 pi*3/4;];                     % robot path
xi = [7 5 pi/4];
xi_size = size(xi);

for i=1:xi_size(1)
    sensor(i,:) = Lidarscan_sol(Map, [xi(i,2) xi(i,1) xi(i,3)])    
    Map(xi(i,2), xi(i,1)) = 0.5;                                    % robot position
end

% plot Map with robot position
figure(1)
imagesc(Map)

% plot lidarscan result with robot position
figure1 = figure; axes1 = axes('Parent',figure1);
hold on
r = 2; theta = linspace(0,2*pi);
for i=1:xi_size(1)
    x = r*cos(theta) + xi(i,1);
    y = r*sin(theta) + xi(i,2);
    plot(x,y, '--', "Color",'b')                                    % lidarscan range
    plot(xi(i,1), xi(i,2), '.', 'MarkerSize',50, "Color",'b');      % robot position
    line([xi(i,1) xi(i,1)+0.5*cos(-xi(i,3))], [xi(i,2) xi(i,2)+0.5*sin(-xi(i,3))], 'Linewidth', 3, 'color', 'k');       % robot direction
    % plot obstacles
    for k=1:8
        if sensor(i,k) ~= inf
            th = -(xi(i,3)+(k-1)*pi/4);
            plot(xi(i,1)+sensor(i,k)*cos(th), xi(i,2)+sensor(i,k)*sin(th), 'gs', 'LineWidth', 2, 'MarkerSize',10, "Color",'r');
        end
    end
end

set(axes1,'YDir','reverse')  % reverse Y axis
grid
xlim([0 10]);
ylim([0 10]);
end