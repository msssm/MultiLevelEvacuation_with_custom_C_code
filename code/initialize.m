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

%for convenience
data.pixel_per_meter = 1/data.meter_per_pixel;


% preprocessing: fast sweeping, exits, stairs ...
data = initEscapeRoutes(data);
data = initWallForces(data);

data = initAgents(data);


% statistics, ...



