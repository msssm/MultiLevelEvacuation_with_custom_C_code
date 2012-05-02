function plotFloor(data, floor_idx)
%PLOTFLOOR Summary of this function goes here
%   Detailed explanation goes here

function plotAgent(agent, i)
    ang=0:0.1:2*pi; 
    xp=agent.radius*cos(ang)*data.pixel_per_meter;
    yp=agent.radius*sin(ang)*data.pixel_per_meter;
    plot(agent.pos(2)+xp,agent.pos(1)+yp, 'r');
    %text(agent.pos(2),agent.pos(1),int2str(i));
end

imagesc(1-data.floor(floor_idx).img_wall);
colormap gray;
hold on;
axis equal;

for i=1:length(data.floor(floor_idx).agents)
    plotAgent(data.floor(floor_idx).agents(i), i);
end

end
