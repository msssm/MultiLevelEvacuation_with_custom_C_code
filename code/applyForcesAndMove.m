function data = applyForcesAndMove(data)
%APPLYFORCESANDMOVE apply current forces to agents and move them using
%the timestep and current velocity

% loop over all floors
for fi = 1:data.floor_count

    % init logical arrays to indicate agents that change the floor or exit
    % the simulation
    floorchange = false(length(data.floor(fi).agents),1);
    exited = false(length(data.floor(fi).agents),1);
    
    % loop over all agents
    for ai=1:length(data.floor(fi).agents)
        % add current force contributions to velocity
        v = data.floor(fi).agents(ai).v + data.dt * ...
            data.floor(fi).agents(ai).f  / data.floor(fi).agents(ai).m;
        
        % clamp velocity
        if norm(v) > data.v_max
            v = v / norm(v) * data.v_max;
        end
        
        % get agent's new position
        newp = data.floor(fi).agents(ai).p + ...
               v * data.dt / data.meter_per_pixel;
           
        % if the new position is inside a wall, remove perpendicular
        % component of the agent's velocity
        while data.floor(fi).img_wall(round(newp(1)), round(newp(2)))
            
            % get agent's position
            p = data.floor(fi).agents(ai).p;
            
            % get wall distance gradient (which is off course perpendicular
            % to the nearest wall)
            nx = interp2(data.floor(fi).img_wall_dist_grad_x, ...
                 p(2), p(1), '*linear');
            ny = interp2(data.floor(fi).img_wall_dist_grad_y, ...
                 p(2), p(1), '*linear');
            n = [nx ny];
            
            % project out perpendicular component of velocity vector
            v = v - dot(n,v)/dot(n,n)*n;
            
            % get agent's new position
            newp = data.floor(fi).agents(ai).p + ...
                   v * data.dt / data.meter_per_pixel;
        end
        
        % update agent's velocity and position
        data.floor(fi).agents(ai).v;
        data.floor(fi).agents(ai).p = newp;
        
        % reset forces for next timestep
        data.floor(fi).agents(ai).f = [0 0];
        
        % check if agent reached a staircase and indicate floor change
        if data.floor(fi).img_stairs_down(round(newp(1)), round(newp(2)))
            floorchange(ai) = 1;
        end
        
        % check if agent reached an exit
        if data.floor(fi).img_exit(round(newp(1)), round(newp(2)))
            exited(ai) = 1;
        end
    end
    
    % add appropriate agents to next lower floor
    if fi > 1
        data.floor(fi-1).agents = [data.floor(fi-1).agents data.floor(fi).agents(floorchange)];
    end
    
    % delete these and exited agents
    data.floor(fi).agents = data.floor(fi).agents(~(floorchange|exited));
end
