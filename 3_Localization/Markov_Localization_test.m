function Markov_Localization_test()
close all                                          % close all figures
Map = [ 
    1   1   1   1   1   1   1   0   1   1;
    1   1   0   0   0   0   1   0   0   1;
    1   1   0   1   0   0   1   0   1   1;
    1   0   1   0   0   0   0   1   0   1;
    1   0   0   0   1   0   0   0   0   1;
    1   0   1   0   0   0   0   0   0   1;
    1   1   1   1   0   0   1   0   0   1;
    1   1   0   0   0   0   1   0   1   1;
    1   1   0   1   0   1   0   1   0   1;
    1   0   1   0   1   1   1   1   1   1];

pTransition = [                                     % uncertain motion
    0   0   0   0   0
    0  .05  .1 .05  0
    0   .1  .4  .1  0
    0  .05  .1 .05  0
    0   0   0   0   0  ];

state =[3 3];                                       % initial position [x y]
u = [0 -1;2 0];u_sz = size(u);                      % motion plan [dx dy]
bel_tm1 = zeros(size(Map));                         % initial probability  
getPerception = @(x, y) Map(y-1:y+1,x-1:x+1);       % perception(sensor) function

% plot Map
figure('Name','Map');
imagesc(Map);colormap(parula);

bel_size = size(bel_tm1);                           % 10 x 10 same as Map size
z = getPerception(state(1), state(2));              % perception(sensor) at initial position

%%% initialize bel_tm1 %%%
for y=2:bel_size(1)-1  % y
    for x=2:bel_size(2)-1  % x
        localMap = Map(y-1:y+1,x-1:x+1);
        bel_tm1(y,x) = sum(~xor(z,localMap),'all') - ~xor(z(2,2),Map(y,x));
    end
end
norm_factor = 1/sum(bel_tm1,'all');
bel_tm1 = norm_factor*bel_tm1;                      % normalize so that sum of bel_tm1 is 1

% plot initial bel_tm1
figure('Name','initial bel_tm1');
imagesc(bel_tm1);colormap(summer);colorbar()

for t=1:u_sz(1)
    state = state + u(t,:);
    z = getPerception(state(1), state(2));
    bel_tm1 = Markov_Localization_sol(Map, pTransition, bel_tm1, u(t,:), z);
end
end

