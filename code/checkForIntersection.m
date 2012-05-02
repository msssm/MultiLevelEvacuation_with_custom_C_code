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

agent_radius = data.floor(floor_idx).agents(agent_idx).r;

% check for agent intersection
for i=1:length(data.floor(floor_idx).agents)
    if i~=agent_idx
        if norm(data.floor(floor_idx).agents(i).p-agent_new_pos)*data.meter_per_pixel ...
                <= agent_radius +  data.floor(floor_idx).agents(i).r
            val=2;
            return;
        end
    end
end


% check for wall intersection
xmin = floor(agent_new_pos(1) - agent_radius*data.pixel_per_meter);
xmax = ceil(agent_new_pos(1) + agent_radius*data.pixel_per_meter);
ymin = floor(agent_new_pos(2) - agent_radius*data.pixel_per_meter);
ymax = ceil(agent_new_pos(2) + agent_radius*data.pixel_per_meter);

map = false(size(data.floor(floor_idx).img_wall));
map(ymin:ymax, xmin:xmax) = true;
if any(map & data.floor(floor_idx).img_wall)
    val = 1;
end

