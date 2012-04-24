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
        
        data.floor(fi).agents(ai).pos = data.floor(fi).agents(ai).pos + ...
            data.floor(fi).agents(ai).v * data.dt / data.meter_per_pixel;
        
        data.floor(fi).agents(ai).f = [0 0];
    end
end

