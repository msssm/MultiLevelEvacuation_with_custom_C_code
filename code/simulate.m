function simulate()
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here

data = main();

time = 0;
figure;
while (time < data.duration)
    tic;
    data = addDesiredForce(data);
    data = addWallForce(data);
    data = addAgentRepulsiveForce(data);
    data = applyForcesAndMove(data);
    
    clf;
    plotFloor(data, 1);
    
    for fi = 1:data.floor_count
        nanpos = arrayfun(@(agent) any(isnan(agent.p)), data.floor(fi).agents);
        data.floor(fi).agents = data.floor(fi).agents(~nanpos);
    end

    if (time + data.dt > data.duration)
        data.dt = data.duration - time;
        time = data.duration;
    else
        time = time + data.dt;
    end
    
    pause(max(data.dt - toc, 0.01));
end

