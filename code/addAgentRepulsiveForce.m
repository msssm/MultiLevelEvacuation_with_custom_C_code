function data = addAgentRepulsiveForce(data)
%ADDAGENTREPULSIVEFORCE Summary of this function goes here
%   Detailed explanation goes here

% Obstruction effects in case of physical interaction

for fi = 1:data.floor_count

    agents_on_floor = length(data.floor(fi).agents);
    for ai = 1:agents_on_floor
        pi = data.floor(fi).agents(ai).p;
        vi = data.floor(fi).agents(ai).v;
        
        for aj = ai+1:agents_on_floor
            pj = data.floor(fi).agents(aj).p;
            vj = data.floor(fi).agents(aj).v;
            
            
            % vector pointing from j to i
            nij = (pi - pj) * data.meter_per_pixel;
            
            % distance of agents
            d = norm(nij);
            
            % normalized vector pointing from j to i
            nij = nij / d;
            % tangential direction
            tij = [-nij(2), nij(1)];
            
            % sum of radii
            rij = (data.floor(fi).agents(ai).r + ...
                   data.floor(fi).agents(aj).r);
            
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
end

