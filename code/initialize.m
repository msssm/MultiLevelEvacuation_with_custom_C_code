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
%                   (is that a good decision ?)


data = config;

data.pixel_per_meter = 1/data.meter_per_pixel; %for convenience

%colors: these are constant
data.color.bg = bitshift(uint32(255), 16) + bitshift(uint32(255), 8) + uint32(255);
data.color.wall = bitshift(uint32(0), 16) + bitshift(uint32(0), 8) + uint32(0);
data.color.agents = bitshift(uint32(255), 16) + bitshift(uint32(0), 8) + uint32(255);
data.color.exit = bitshift(uint32(0), 16) + bitshift(uint32(255), 8) + uint32(0);
data.color.stairs_down = bitshift(uint32(0), 16) + bitshift(uint32(0), 8) + uint32(255);
data.color.stairs_up = bitshift(uint32(255), 16) + bitshift(uint32(0), 8) + uint32(0);


data = initAgents(data);


% preprocessing: fast sweeping, exits, stairs ...
data = initEscapeRoutes(data);
data = initWallForces(data);


% statistics, ...



