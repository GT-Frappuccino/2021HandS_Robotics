function A_Star_test()
close all                                          % close all figures

function [Queue, minNode] = pop(Queue)
    if ~isempty(Queue)
        [~, idx] = min([Queue.f]);   
        minNode = Queue(idx);
        Queue(idx) = [];
    else
        disp('Queue is empty')
        return
    end
end

function newQueue = push(Queue, Node)  
    newQueue = Queue;
    poss = reshape([0 0 newQueue.pos],2,[])';
    if any(poss - Node.pos,2)           % if Node.pos is not in the Queue
        idx = length(newQueue);   
        newQueue(idx+1) = Node;         % insert Node
    end
end

Map = [ 
    1   1   1   1   1   1   1   1   1   1;
    1   1   0   0   0   0   1   0   0   1;
    1   1   0   0   0   0   0   0   1   1;
    1   0   0   0   0   0   0   0   0   1;
    1   0   0   0   1   1   1   1   1   1;
    1   0   0   0   1   1   1   1   1   1;
    1   1   0   0   0   0   0   0   0   1;
    1   1   0   0   0   0   0   0   1   1;
    1   1   1   1   0   1   0   1   0   1;
    1   1   1   1   1   1   1   1   1   1];

startPos = [3,7];
goalPos  = [8,6];
SolutionMap = Inf*ones(size(Map)); 
PathMap = Map; 

[Closed, Path]=A_Star_sol(Map, startPos, goalPos, @pop, @push);
for i=1:length(Closed) 
    Curr = Closed(i);
    SolutionMap(Curr.pos(1),Curr.pos(2)) = Curr.g;  % store g values of Nodes in Closed
end

for i=1:length(Path) 
    pos = Path(i,:);
    PathMap(pos(1),pos(2)) = 0.5;                   % store path
end

% plot Map, SolutionMap, PathMap
figure('Name','Map');
imagesc(Map);
figure('Name','SolutionMap');
set(gca,'dataAspectRatio',[1 1 1])
imagesc(SolutionMap);colorbar();
figure('Name','PathMap');
imagesc(PathMap);
end

