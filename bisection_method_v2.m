function [ root , intervals ] = bisection_method_v2 (f , a , b , tol )

% calculate required number of iterations to reach tolerance
 max_iters = ceil(log2((b-a)/tol)); % only works if I do ceiling not floor
% ended up not using max_iters for creating the # of interval rows because
% then I would get a bunch of rows of zeros    

% blank intervals
intervals = zeros(1, 3);

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

      intervals (k, :) = [a, m, b];

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

end
%% Test 1
f = @( x ) x ^2 - 4* sin ( x ) ;
a = 1;
b = 3;
tol = 0.2;
[ root , intervals ] = bisection_method_v2 (f , a , b , tol )

%% Test 2

g = @( x ) x ^3;
left_pt = -5.5;
right_pt = 10.5;
tol_2 = 1e-8;
[ root_g , int_g ] = bisection_method_v2 (g , left_pt , right_pt , tol_2 )