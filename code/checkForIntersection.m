function val = checkForIntersection(data, floor_idx, agent_idx, agent_new_pos)
% check an agent for an intersection with another agent or a wall
% the check is kept as simple as possible
%
%  arguments:
%   data            global data structure
%   floor_idx       which floor to check
%   agent_idx       which agent on that floor
%   agent_new_pos   vector: [x,y], desired agent position to check
%
%  return:
%   0               for no intersection
%   1               has an intersection with wall
%   2                                   with another agent

val = 0;

floor = data.floor(floor_idx);
agent_radius = floor.agents(agent_idx).radius;

% check for agent intersection
for i=1:length(floor.agents)
    if i~=agent_idx
        if norm(floor.agents(i).pos-agent_new_pos) ...
                < agent_radius +  floor.agents(i).radius
            val=2;
            return;
        end
    end
end


% check for wall intersection
pos_xi = cast(agent_new_pos(1), 'int32');
pos_yi = cast(agent_new_pos(2), 'int32');
radiusi = cast(agent_radius, 'int32');

% horizontal check
for i=max(1, pos_xi-radiusi) : min(data.width, pos_xi+radiusi)
    if data.img(floor_idx).img_build(pos_yi, i) == data.color.wall
        val = 1;
        return;
    end
end
% vertical check
for i=max(1, pos_yi-radiusi) : min(data.height, pos_yi+radiusi)
    if data.img(floor_idx).img_build(i, pos_xi) == data.color.wall
        val = 1;
        return;
    end
end

