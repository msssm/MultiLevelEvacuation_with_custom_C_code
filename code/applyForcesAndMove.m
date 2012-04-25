function data = applyForcesAndMove(data)
%APPLYFORCESANDMOVE Summary of this function goes here
%   Detailed explanation goes here

for fi = 1:data.floor_count

    for ai=1:length(data.floor(fi).agents)
        v = data.floor(fi).agents(ai).v + data.floor(fi).agents(ai).f * data.dt;
        if norm(v) > data.valphamaxmul*data.floor(fi).agents(ai).valpha0
            v = v / norm(v) * data.valphamaxmul * data.floor(fi).agents(ai).valpha0;
        end
        data.floor(fi).agents(ai).v = v;
        
        newpos = data.floor(fi).agents(ai).pos + ...
            data.floor(fi).agents(ai).v * data.dt / data.meter_per_pixel;
        if data.floor(fi).img_wall(round(newpos(1)), round(newpos(2)))
            pos = data.floor(fi).agents(ai).pos;
            fx = interp2(data.floor(fi).img_wall_force_x, pos(2), pos(1), '*linear');
            fy = interp2(data.floor(fi).img_wall_force_y, pos(2), pos(1), '*linear');
            f = [fx fy];
            v = v - dot(f,v)/dot(f,f)*f;
            data.floor(fi).agents(ai).v = v;
            newpos = data.floor(fi).agents(ai).pos + ...
            data.floor(fi).agents(ai).v * data.dt / data.meter_per_pixel;
        end
            
        data.floor(fi).agents(ai).pos = newpos;
        
        data.floor(fi).agents(ai).f = [0 0];
    end
end

