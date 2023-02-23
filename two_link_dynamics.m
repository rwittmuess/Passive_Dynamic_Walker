%-------------------------------------------------------------------------
%
%   --> Called by ode45
%
%   INPUTS  - time
%           - start vector
%
%   OUTPUTS - time-derivative of the state
%
%
%   To-Do:  - compute time derivative of state using dynamical model
%           
%
%------------------------------------------------------------------------- 

function dx_0 = two_link_dynamics(t, x_0)
    
    beta = 0.01;    % m/m
    gamma = 0.01;   % rad
    g_div_l = 1;    % 1/s^2
 
    
    % Dynamics
    D   =   [1+2*beta*(1-cos(x_0(2))) -beta*(1-cos(x_0(2)));
            beta*(1-cos(x_0(2))) -beta];
    Cdq =   [-beta*sin(x_0(2))*(x_0(4)^2-2*x_0(3)*x_0(4));
            beta*x_0(3)^2*sin(x_0(2))];
    G   =   [(beta*g_div_l)*(sin(x_0(1)-x_0(2)-gamma)-sin(x_0(1)-gamma))-(g_div_l)*sin(x_0(1)-gamma);
            beta*g_div_l*sin(x_0(1)-x_0(2)-gamma)];
    
    
    % Initialize OUTPUT: time-derivative of the state
    dx_0        = [0 0 0 0]';
    dx_0(1)     = x_0(3);
    dx_0(2)     = x_0(4);
    dx_0(3:4)   = -D\Cdq-D\G;

end 


%------------------------------------------------------------------------- 
%   First approach. Too slow but same results    
%------------------------------------------------------------------------- 


% syms theta dtheta phi dphi real
% syms m M betta gammma g l real 
% 
% % Generalized coordinates, velocities and state vector
% q = [theta phi]';
% dq = [dtheta dphi]';
% x = [q;
%     dq];
% 
% % Dynamics
% D = [1+2*betta*(1-cos(phi)) -betta*(1-cos(phi));
%     betta*(1-cos(phi)) -betta];
% Cdq = [-betta*sin(phi)*(dphi^2-2*dtheta*dphi);
%     betta*dphi^2*sin(phi)];
% G = [(betta*g/l)*(sin(theta-phi-gammma)-sin(theta-gammma))-(g/l)*sin(theta-gammma);
%     betta*g/l*sin(theta-phi-gammma)];
% 
% % substituted
% D_s = subs(D,[x' m M betta gammma g l], [x_0' 1 100 0.01 0.01 1 1]);
% Cdq_s = subs(Cdq,[x' m M betta gammma g l], [x_0' 1 100 0.01 0.01 1 1]);
% G_s = subs(G,[x' m M betta gammma g l], [x_0' 1 100 0.01 0.01 1 1]);
% 
% % Initialize OUTPUT: time-derivative of the state
% dx_0        = [0 0 0 0]';
% dx_0(1)     = x_0(3);
% dx_0(2)     = x_0(4);
% dx_0(3:4)   = -inv(D_s)*Cdq_s-inv(D_s)*G_s+inv(D)*[0;0];