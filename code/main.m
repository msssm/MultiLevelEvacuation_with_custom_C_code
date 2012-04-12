function data = main(config_file)
% this is the main entry point to start the simulation
%
%  arguments:
%   config_file     (optional) string, which configuration file to load


if nargin==0
    config_file='../data/config1.conf';
end

config = loadConfig(config_file);

data = initialize(config);


% loop over time
    % loop over floors
        %loop over agents
            %loop over forces
    % update plot
    

% do final statistics (?)

