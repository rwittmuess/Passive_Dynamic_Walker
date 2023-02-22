%-------------------------------------------------------------------------
%
%   --> Called by ode45
%
%   INPUTS  - time
%           - state vector
%
%   OUTPUTS - ode options
%
%
%   To-Do:  - detect -v to +v crossing
%           - stop integration
%           
%
%------------------------------------------------------------------------- 

function [value, isterminal, direction] = two_link_event(t, x)
    value = x(2)-2*x(1);
    isterminal = 1;
    direction = 1;
end