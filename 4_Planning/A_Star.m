function [Closed, Path]=A_Star(Map, startPos, goalPos, pop, push)
%%% argument dimension check %%%
arguments 
     Map (:,:) {mustBeNumeric}
     startPos (1,2) {mustBeNumeric}
     goalPos (1,2) {mustBeNumeric}
     pop
     push
end   

%%% Insert start Node & Initialize Closed %%%
Queue(1).pos = startPos;
Queue(1).g   = 0;
Queue(1).h   = norm(goalPos-startPos);             % h: Euclidean distance as heuristic
Queue(1).f = Queue(1).g + Queue(1).h;
Queue(1).parent = [];
Closed = struct('pos', {}, 'g', {}, 'h', {}, 'f', {}, 'parent',{});

%%% Iteration %%%
while ~isempty(Queue) 
    ...;
end

%%% extract solution path from goal to start %%%
Path = [];

end

