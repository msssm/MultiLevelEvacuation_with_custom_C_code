function simulate(config_file)
% run this to start the simulation

if nargin==0
    config_file='../data/config1.conf';
end

config = loadConfig(config_file);

data = initialize(config);


time = 0;
data.figure=figure;
frame = 0;
timestamp = datestr(datevec(now), 'yyyy.mm.dd-HH.MM.SS');

while (time < data.duration)
    tic;
    data = addDesiredForce(data);
    data = addWallForce(data);
    data = addAgentRepulsiveForce(data);
    data = applyForcesAndMove(data);
    
    for floor=1:data.floor_count
        plotFloor(data, floor);
    end
    if data.save_frames==1
        set(data.figure, 'PaperPosition',[0 0 5 4])
        print('-depsc2',sprintf('frames/%s_frame%04i.eps', ...
            timestamp,frame), '-r400', data.figure);
    end
    
    % print mean/median velocity of agents on each floor
%     for fi = 1:data.floor_count
%         avgv = arrayfun(@(agent) norm(agent.v), data.floor(fi).agents);
%         fprintf('Mean/median velocity on floor %i: %g/%g m/s\n', fi, mean(avgv), median(avgv));
%     end
    

    if (time + data.dt > data.duration)
        data.dt = data.duration - time;
        time = data.duration;
    else
        time = time + data.dt;
    end
    
    pause(max(data.dt - toc, 0.01));
    fprintf('Frame %i done.\n', frame);
    frame = frame + 1;
end

