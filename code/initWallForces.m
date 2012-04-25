function data = initWallForces(data)
%INITWALLFORCES Summary of this function goes here
%   Detailed explanation goes here

for i=1:data.floor_count

    boundary_data = zeros(size(data.floor(i).img_wall));
    boundary_data(data.floor(i).img_wall) = -1;
    
    wall_dist = max(0,fastSweeping(boundary_data)-1) * data.meter_per_pixel;
    [data.floor(i).img_wall_force_x, data.floor(i).img_wall_force_y] = ...
        getNormalizedGradient(boundary_data, wall_dist);
    
    mul = data.UalphaB0*exp(-wall_dist/data.UalphaBR);
    data.floor(i).img_wall_force_x = data.floor(i).img_wall_force_x.*mul;
    data.floor(i).img_wall_force_y = data.floor(i).img_wall_force_y.*mul;
end

