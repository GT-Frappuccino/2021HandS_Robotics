function bel=Markov_Localization_sol(Map, pTransition, bel_tm1, u, z)
%%% argument dimension check %%%
arguments 
     Map (:,:) {mustBeNumeric}
     pTransition (:,:) {mustBeNumeric}
     bel_tm1 (:,:) {mustBeNumeric}
     u (1,2) {mustBeNumeric}
     z (3,3) {mustBeNumeric}
end                                                  

%%% anonymous functions %%%
getPLocalTransition = @(localCoordinate) ...
    pTransition(localCoordinate(1) + 3, localCoordinate(2) + 3);
calcPTransition = @(dxdy) getPLocalTransition(max([min([flip(dxdy);2 2]);-2 -2])); 

bel_size = size(bel_tm1);   % 10 x 10 same as Map size
bel_ = zeros(bel_size);  
bel = zeros(bel_size);

for y=2:bel_size(1)-1  % y
for x=2:bel_size(2)-1  % x
    %%% control(motion) update %%%
    for dy=-2:2
    for dx=-2:2
        if  [1 1] <= [y+dy-u(2), x+dx-u(1)] & [y+dy-u(2), x+dx-u(1)] <= [10 10]
        bel_(y,x) = bel_(y,x) + calcPTransition([dx dy])*bel_tm1(y+dy-u(2), x+dx-u(1));
        end
    end
    end
    %%% mesurement update %%%
    localMap = Map(y-1:y+1,x-1:x+1);
    pMeasurement = sum(~xor(z,localMap),'all') - ~xor(z(2,2),Map(y,x));
    bel(y,x) = pMeasurement*bel_(y,x);
end
end

norm_factor = 1/sum(bel,'all');
bel = norm_factor*bel;                              % normalize bel

% plot bel_ (control update)
figure('Name','bel_ (control update)');
imagesc(bel_);colormap(summer);colorbar()
% plot bel (measurement update)
figure('Name','bel (measurement update)');
imagesc(bel);colormap(summer);colorbar()

end



