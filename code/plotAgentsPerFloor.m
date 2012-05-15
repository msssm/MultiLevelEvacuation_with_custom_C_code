function plotAgentsPerFloor(data, floor_idx)
%plot time vs agents on floor

h = subplot(data.floor(floor_idx).agents_on_floor_plot);

set(h, 'position',[0.05+(data.floor_count - floor_idx)/(data.figure_floors_subplots_w+0.1), ...
    0.05, 1/(data.figure_floors_subplots_w+0.4), 0.3-0.05 ]);

hold on;
axis([0 data.duration 0 data.total_agent_count]);

plot(data.time, length(data.floor(floor_idx).agents), 'bx');

title(sprintf('agents on floor %i', floor_idx));

