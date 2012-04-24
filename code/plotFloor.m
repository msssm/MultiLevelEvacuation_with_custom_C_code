function plotFloor(data, floor_idx)
%PLOTFLOOR Summary of this function goes here
%   Detailed explanation goes here

function plotAgent(agent)
    ang=0:0.1:2*pi; 
    xp=agent.radius*cos(ang);
    yp=agent.radius*sin(ang);
    plot(agent.pos(2)+xp,agent.pos(1)+yp, 'r');
end

imagesc(1-data.floor(floor_idx).img_wall);
colormap gray;
hold on;
axis equal;

wall_force = sqrt(data.floor(floor_idx).img_wall_force_x.^2.+data.floor(floor_idx).img_wall_force_y.^2);
imagesc(wall_force);

for i=1:length(data.floor(floor_idx).agents)
    plotAgent(data.floor(floor_idx).agents(i));
end

end
