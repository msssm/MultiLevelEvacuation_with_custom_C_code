function data = initAgents(data_in)

% place agents randomly in desired spots, without overlapping
%
%  return:
%   data             agents are stored as:
%                    data.floor(i).agents(k).pos: vector [y, x]
%                    data.floor(i).agents(k).radius



function radius = getAgentRadius(data)
    %radius of an agent in meters
    radius = data.agents_radius_min + ...
        (data.agents_radius_max-data.agents_radius_min)*rand();
end



floors_with_agents = 0;
agent_count = data_in.agents_per_floor;
for i=1:data_in.floor_count
    data_in.floor(i).agents = [];
    [y,x]=find(data_in.img(i).img_build==data_in.color.agents);
    
    if ~isempty(x)
        floors_with_agents=floors_with_agents+1;
        cur_agent=1;
        for j=1:agent_count
            %place an agent to floor i
            agent_radius = getAgentRadius(data_in)*data_in.pixel_per_meter;
            data_in.floor(i).agents(cur_agent).radius = agent_radius;
            tries=10*j; % make this smaller if initialization is too slow!
            while tries > 0
                %randomly pick a spot and check if it's free
                idx = randi(length(x));
                data_in.floor(i).agents(cur_agent).pos = [y(idx), x(idx)];
                if checkForIntersection(data_in, i, cur_agent, [y(idx), x(idx)]) == 0
                    tries = -1; % leave the loop
                    cur_agent=cur_agent+1;
                end
                tries = tries - 1;
            end
            if tries==0
                %remove the last agent
                data_in.floor(i).agents = data_in.floor(i).agents(1:end-1);
            end
        end
        if cur_agent-1 ~= agent_count
            warning('could only place %d agents on floor %d instead of %d agents' ...
                , cur_agent-1, i, agent_count)
        end
    end
end
if floors_with_agents==0
    error('no spots to place agents!');
end


data = data_in;

end