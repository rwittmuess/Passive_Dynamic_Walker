%-------------------------------------------------------------------------
%
%   --> Called at an impact event
%
%   INPUTS  - pre-impact state x_minus
%
%   OUTPUTS - post-impact state x_plus
%
%
%   To-Do:  - impact map & re-labeling
%           
%
%------------------------------------------------------------------------- 

function x_plus = two_link_impactdynamics(x_minus)

    theta = x_minus(1);

    R = [-1 0 0 0;
         -2 0 0 0;
          0 0 cos(2*theta) 0;
          0 0 cos(2*theta)*(1-cos(2*theta)) 0];

    x_plus = R*x_minus;

end