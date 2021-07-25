function bel=Markov_Localization(Map, pTransition, bel_tm1, u, z)
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

end

