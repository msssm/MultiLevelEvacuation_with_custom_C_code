function simulate(config_file)
% run this to start the simulation

if nargin==0
    config_file='../data/config1.conf';
end

config = loadConfig(config_file);

data = initialize(config);


data.time = 0;
frame = 0;
timestamp = datestr(datevec(now), 'yyyy.mm.dd-HH.MM.SS');

while (data.time < data.duration)
    tstart=tic;
    data = addDesiredForce(data);
    data = addWallForce(data);
    data = addAgentRepulsiveForce(data);
    data = applyForcesAndMove(data);
    
    % do the plotting
    set(0,'CurrentFigure',data.figure_floors);
    for floor=1:data.floor_count
        plotFloor(data, floor);
    end
    if data.save_frames==1
        set(data.figure_floors, 'PaperPosition',[0 0 5 4])
        print('-depsc2',sprintf('frames/%s_frame%04i.eps', ...
            timestamp,frame), '-r400', data.figure_floors);
    end
    
    set(0,'CurrentFigure',data.figure_exit);
    plotExitedAgents(data);
    
    
    % print mean/median velocity of agents on each floor
%     for fi = 1:data.floor_count
%         avgv = arrayfun(@(agent) norm(agent.v), data.floor(fi).agents);
%         fprintf('Mean/median velocity on floor %i: %g/%g m/s\n', fi, mean(avgv), median(avgv));
%     end
    

    if (data.time + data.dt > data.duration)
        data.dt = data.duration - data.time;
        data.time = data.duration;
    else
        data.time = data.time + data.dt;
    end
    telapsed = toc(tstart);
    pause(max(data.dt - telapsed, 0.01));
    fprintf('Frame %i done (took %.3fs).\n', frame, telapsed);
    frame = frame + 1;
end

