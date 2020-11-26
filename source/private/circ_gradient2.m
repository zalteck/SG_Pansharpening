function [dfh, dfv] = circ_gradient2(f)

[n,m] = size(f);

dfh = [f(:,1) - f(:,m), f(:,2:m) - f(:,1:m-1)]; % Horizontal 
dfv = [f(1,:) - f(n,:); f(2:n,:) - f(1:n-1,:)]; % Vertical

% Copied from circ_gradient
dfh = [f(:,1:m-1) - f(:,2:m), f(:,m) - f(:,1)]; % Horizontal 
dfv = [f(1:n-1,:) - f(2:n,:); f(n,:) - f(1,:)]; % Vertical

% dfh = [zeros(size(f(:,1) - f(:,m))), f(:,2:m) - f(:,1:m-1)]; % Horizontal 
% dfv = [zeros(size(f(1,:) - f(n,:))); f(2:n,:) - f(1:n-1,:)]; % Vertical
% 
