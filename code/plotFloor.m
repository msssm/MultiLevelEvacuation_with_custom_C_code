function plotFloor(data, floor_idx)
%PLOTFLOOR plot floor

% function to plot one agent
function plotAgent(agent, i)
    ang=0:0.1:2*pi;
    r = agent.r*data.pixel_per_meter;
    %r = norm(agent.v);
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(agent.p(2)+xp,agent.p(1)+yp, 'r');
    %text(agent.pos(2),agent.pos(1),int2str(i));
end

hold off;
subplot(1, data.floor_count,floor_idx)

% background image
imagesc(1-data.floor(floor_idx).img_wall);
colormap gray;
hold on;
axis equal;
%set(gca, 'Visible', 'off')

title(sprintf('floor %i', floor_idx));

for i=1:length(data.floor(floor_idx).agents)
    plotAgent(data.floor(floor_idx).agents(i), i);
end
end
