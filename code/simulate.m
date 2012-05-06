function simulate()
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here

data = main();

time = 0;
figure;
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
        if data.save_frames==1
            set(gcf, 'PaperPosition',[0 0 5 4])
            print('-depsc2',sprintf('frames/%s_f%04i_floor%02i.eps', ...
                timestamp,frame, floor), '-r400');
        end
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

