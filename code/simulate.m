function simulate()
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here

data = main();

time = 0;
figure;
frame = 0;
plotFloor(data, 1);
while (time < data.duration)
    tic;
    data = addDesiredForce(data);
    data = addWallForce(data);
    data = addAgentRepulsiveForce(data);
    data = applyForcesAndMove(data);
    
    clf;
    plotFloor(data, 1);
    % save floor 1 plot
    set(gcf, 'PaperPosition',[0 0 5 4])
    print('-depsc2',sprintf('frames/floor1_%04i.eps', frame), '-r400');
    clf;
    plotFloor(data, 2);
    % save floor 2 plot
    set(gcf, 'PaperPosition',[0 0 5 4])
    print('-depsc2',sprintf('frames/floor2_%04i.eps', frame), '-r400');
    
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
    
    %pause(max(data.dt - toc, 0.01));
    fprintf('Frame %i done.\n', frame);
    frame = frame + 1;
end

