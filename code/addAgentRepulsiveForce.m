function data = addAgentRepulsiveForce(data)
%ADDAGENTREPULSIVEFORCE Summary of this function goes here
%   Detailed explanation goes here

% Obstruction effects in case of physical interaction

r_max = fzero(@(r) data.A * exp(-r/data.B) - 1e-6, data.r_max);
tree = 0;

for fi = 1:data.floor_count
    pos = [arrayfun(@(a) a.p(1), data.floor(fi).agents);
           arrayfun(@(a) a.p(2), data.floor(fi).agents)];
    
    tree_lower = tree;
    tree = tree_create(pos);
    
    agents_on_floor = length(data.floor(fi).agents);
    for ai = 1:agents_on_floor
        pi = data.floor(fi).agents(ai).p;
        vi = data.floor(fi).agents(ai).v;
        ri = data.floor(fi).agents(ai).r;
        
        n = tree_rangequery(tree, pi(1)-r_max, pi(1)+r_max, pi(2)-r_max, pi(2)+r_max);
        
        for aj = n
        %for aj = ai+1:agents_on_floor
            if aj > ai
            pj = data.floor(fi).agents(aj).p;
            vj = data.floor(fi).agents(aj).v;
            rj = data.floor(fi).agents(aj).r;
            
            % vector pointing from j to i
            nij = (pi - pj) * data.meter_per_pixel;
            
            % distance of agents
            d = norm(nij);
            
            % normalized vector pointing from j to i
            nij = nij / d;
            % tangential direction
            tij = [-nij(2), nij(1)];
            
            % sum of radii
            rij = (ri + rj);
            
            % repulsive interaction forces
            if d < rij
               T1 = data.k*(rij - d);
               T2 = data.kappa*(rij - d)*dot((vj - vi),tij)*tij;
            else
               T1 = 0;
               T2 = 0;
            end

            Fi =  (data.A * exp((rij - d)/data.B) + T1)*nij + T2;
            Fj = -(data.A * exp((rij - d)/data.B) + T1)*nij - T2;
            
            data.floor(fi).agents(ai).f = data.floor(fi).agents(ai).f + Fi;
            data.floor(fi).agents(aj).f = data.floor(fi).agents(aj).f + Fj;
            end
        end
        
        % include agents on stairs!
        if fi > 1
            %agents_on_floor_below = length(data.floor(fi-1).agents);
            
            n = tree_rangequery(tree_lower, pi(1)-r_max, pi(1)+r_max, pi(2)-r_max, pi(2)+r_max);
            
            if ~isempty(n)
            for aj = n
            %for aj = 1:agents_on_floor_below
                pj = data.floor(fi-1).agents(aj).p;
                if data.floor(fi-1).img_stairs_up(round(pj(1)), round(pj(2)))
                    
                    vj = data.floor(fi-1).agents(aj).v;
                    rj = data.floor(fi-1).agents(aj).r;

                    % vector pointing from j to i
                    nij = (pi - pj) * data.meter_per_pixel;

                    % distance of agents
                    d = norm(nij);

                    % normalized vector pointing from j to i
                    nij = nij / d;
                    % tangential direction
                    tij = [-nij(2), nij(1)];

                    % sum of radii
                    rij = (ri + rj);

                    % repulsive interaction forces
                    if d < rij
                       T1 = data.k*(rij - d);
                       T2 = data.kappa*(rij - d)*dot((vj - vi),tij)*tij;
                    else
                       T1 = 0;
                       T2 = 0;
                    end

                    Fi =  (data.A * exp((rij - d)/data.B) + T1)*nij + T2;
                    Fj = -(data.A * exp((rij - d)/data.B) + T1)*nij - T2;

                    data.floor(fi).agents(ai).f = data.floor(fi).agents(ai).f + Fi;
                    data.floor(fi-1).agents(aj).f = data.floor(fi-1).agents(aj).f + Fj;
                end
            end
            end
        end
    end
end

