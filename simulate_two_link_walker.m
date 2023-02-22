%-------------------------------------------------------------------------
%
%   Runs the simulation
%
%   (INPUTS)  - start vector
%
%   (OUTPUTS) - simulation
%
%
%   To-Do:    - t_sol
%             - x_sol
%           
%
%------------------------------------------------------------------------- 


function simulate_two_link_walker

    clc; clear all; close all;

    x_0 = [0.2065 0.4130 -0.2052 -0.0172]';
    tspan = 0:.1:10; 

    x_sol_full = [0.2065 0.4130 -0.2052 -0.0172];
    t_sol_full = [0];
    
    gamma = 0.01;
    options = odeset('Events', @two_link_event);

    for step = 1:10
        
        [t_sol,x_sol] = ode45(@(t, x_0)two_link_dynamics(t, x_0),tspan,x_0,options);
 
        t_sol_full = [  t_sol_full;
                        t_sol_full(end)+t_sol(2:end)];
        x_sol_full = [  x_sol_full;
                        x_sol(2:end,:)];

        if step==1
            t_I = [length(t_sol_full)];
        else 
            t_I = [ t_I;
                    length(t_sol_full)];
        end

        x_0 = two_link_impactdynamics(x_sol(end,:)');
    
    end

    animate_two_link_walker(t_sol_full, x_sol_full, gamma, t_I)

end

