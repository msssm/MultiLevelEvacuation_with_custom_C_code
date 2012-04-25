function data = addDesiredForce(data)
%ADDDESIREDFORCE Summary of this function goes here
%   Detailed explanation goes here

for fi = 1:data.floor_count

    for ai=1:length(data.floor(fi).agents)
        pos = data.floor(fi).agents(ai).pos;
        ex = interp2(data.floor(fi).img_dir_x, pos(2), pos(1), '*linear');
        ey = interp2(data.floor(fi).img_dir_y, pos(2), pos(1), '*linear');
        e = [ex ey];
        
        f = (data.floor(fi).agents(ai).valpha0*e - data.floor(fi).agents(ai).v)/data.taualpha;
        data.floor(fi).agents(ai).f = data.floor(fi).agents(ai).f + f;
    end
end

