function data = addAgentRepulsiveForce(data)
%ADDAGENTREPULSIVEFORCE Summary of this function goes here
%   Detailed explanation goes here

for fi = 1:data.floor_count

    agents_on_floor = length(data.floor(fi).agents);
    for ai=1:agents_on_floor
        posi = data.floor(fi).agents(ai).pos;
        vi = data.floor(fi).agents(ai).v;
        
        for aj=ai+1:agents_on_floor
            posj = data.floor(fi).agents(aj).pos;
            vj = data.floor(fi).agents(aj).v;
            
            r = (posi - posj) * data.meter_per_pixel;
            rn = norm(r);
            
            bi = sqrt((rn + norm( r-vj*data.deltat))^2-(norm(vj)*data.deltat)^2)/2;
            bj = sqrt((rn + norm(-r-vi*data.deltat))^2-(norm(vi)*data.deltat)^2)/2;
            
            Vi = data.Valphabeta0*exp(-bi/data.Valphabetasigma);
            Vj = data.Valphabeta0*exp(-bj/data.Valphabetasigma);
            
            Fi = r*Vi;
            Fj = -r*Vj;
            
            if dot(vi, Fi) > norm(vi)*norm(Fi)*cos(data.wphi*pi/180)
                wi = 1;
            else
                wi = data.wc;
            end
            if dot(vj, Fj) > norm(vj)*norm(Fj)*cos(data.wphi*pi/180)
                wj = 1;
            else
                wj = data.wc;
            end
            
            data.floor(fi).agents(ai).f = data.floor(fi).agents(ai).f + wi*Fi;
            data.floor(fi).agents(aj).f = data.floor(fi).agents(aj).f + wj*Fj;
        end
    end
end

