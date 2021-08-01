function [Closed, Path]=A_Star_sol(Map, startPos, goalPos, pop, push)
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
    
    [Queue, CurrNode] = pop(Queue);     % Pop current node
    Closed = push(Closed, CurrNode);
    if CurrNode.pos == goalPos          % Termination Condition
        break;
    end
    
    %%% expand 8 neighbors of CurrNode %%%
    y = CurrNode.pos(1);
    x = CurrNode.pos(2);
    nextPos = [[y-1 x-1]; [y-1 x]; [y-1 x+1]; [y x-1]; [y x+1]; [y+1 x-1]; [y+1 x]; [y+1 x+1]];
    for add=1:1:length(nextPos)
        Next.pos = nextPos(add,:);
        poss = reshape([0 0 Closed.pos],2,[])';
        if Map(nextPos(add,1), nextPos(add,2)) ~= 1 & any(poss - Next.pos,2)
        %insert ElementsToInsert(n) at the end of the heap
        Next.g      = CurrNode.g + norm(CurrNode.pos-Next.pos);
        Next.h      = norm(goalPos-Next.pos);
        Next.f      = Next.g + Next.h;
        Next.parent = CurrNode;
        Queue = push(Queue, Next);
        end
    end
end

%%% extract solution path from goal to start %%%
Curr = Closed(length(Closed));
Path = [];
while Curr.pos ~= startPos
    Path = [Curr.pos; Path];
    Curr = Curr.parent;
end
Path = [startPos; Path];

end



