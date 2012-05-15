function data = initialize(config)
% initialize the internal data from the config data
%
%  arguments:
%   config      data structure from loadConfig()
%
%  return:
%   data        data structure: all internal data used for the main loop
%
%               all internal data is stored in pixels NOT in meters


data = config;

%for convenience
data.pixel_per_meter = 1/data.meter_per_pixel;


data = initEscapeRoutes(data);
data = initWallForces(data);

data = initAgents(data);


%init the plots
%exit plot
data.figure_exit=figure;
hold on;
axis([0 data.duration 0 data.total_agent_count]);
title(sprintf('agents that reached the exit (total agents: %i)', data.total_agent_count));

%floors plot
data.figure_floors=figure;
data.figure_floors_subplots_w = data.floor_count;
data.figure_floors_subplots_h = 2;
for i=1:config.floor_count
    data.floor(i).agents_on_floor_plot = subplot(data.figure_floors_subplots_h, data.figure_floors_subplots_w ...
    , data.floor_count - i+1 + data.figure_floors_subplots_w);
    data.floor(i).building_plot = subplot(data.figure_floors_subplots_h, data.figure_floors_subplots_w ...
    , data.floor_count - i+1);
end


