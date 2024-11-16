% function and derivative
f = @(x) x .* sin(x) - 1;
df = @(x) sin(x) + x*cos(x); % found derivative of f(x)

%% Newtons Method

tol = 1e-9;
a = -0.5;
b = 1.5;
x0 = 0.5;
num_iters = 1000; % we stop based on error so num_iters should be large

% define x_vals
x_vals = zeros(1, 1);
x_vals(1) = x0;

% solving
for n = 1:num_iters
    x_new = x_vals(n) - (f(x_vals(n)) / df(x_vals(n)));

    if abs(x_new - x_vals(n)) < tol
        break;
    end
    x_vals(n+1) = x_new;
end

newton_iters = n - 1; % subtract the step for zero

%% Bisection Method

 max_iters = ceil(log2((b-a)/tol));

midpoints = zeros(1, 1);

    % avoid evaluating f more than necessary
    fa = f(a);
    fb = f(b);

    % check if user passed in interval without a sign change
    if fa*fb > 0
        disp('Warning: No sign change on this interval')
        root = NaN;
        return
    % check if user passed in a root
    elseif fa == 0
        root = a;
        return
    elseif fb == 0
        root = b;
        return
    end
    
    for k = 1:max_iters
      m = 0.5*(a + b);
      fm = f(m);

      midpoints (k, :) = m;

         if 0.5*(b - a) < tol
         break;
     
        elseif fa*fm < 0
            b = m;
            fb = fm;

        elseif fb*fm < 0
        a = m;
        fa = fm;

        else
        %f(m) == 0
        % so root_estimate = m;
             break; 

         end
      
    end
    
    root = m;

    bisection_iters = k-1;

    %% Comparing the Methods

    xtrue = fzero(f, 0.5);

    err_newton = abs(xtrue - x_vals);
    err_bisection = abs(xtrue - midpoints);