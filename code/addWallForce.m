function data = addWallForce(data)
%ADDWALLFORCE Summary of this function goes here
%   Detailed explanation goes here

for fi = 1:data.floor_count

    for ai=1:length(data.floor(fi).agents)
        pos = data.floor(fi).agents(ai).pos;
        fx = interp2(data.floor(fi).img_wall_force_x, pos(2), pos(1), '*linear');
        fy = interp2(data.floor(fi).img_wall_force_y, pos(2), pos(1), '*linear');
        f = [fx fy];
        
        data.floor(fi).agents(ai).f = data.floor(fi).agents(ai).f + f;
    end
end

