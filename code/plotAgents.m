function plotAgents()
% simple test function to plot the initialized agents

function circle(x,y,r)
    ang=0:0.1:2*pi; 
    xp=r*cos(ang);
    yp=r*sin(ang);
    plot(x+xp,y+yp);
end


data=main();
floor_idx = 2;

hold off;
imagesc(data.img(floor_idx).img_build);
hold on;

for i=1:length(data.floor(floor_idx).agents)
     %plot(data.floor(floor_idx).agents(i).pos(1), data.floor(floor_idx).agents(i).pos(2), 'wx')
     circle(data.floor(floor_idx).agents(i).pos(1), data.floor(floor_idx).agents(i).pos(2), ...
         data.floor(floor_idx).agents(i).radius); 
end

axis equal; %keep aspect ratio

end