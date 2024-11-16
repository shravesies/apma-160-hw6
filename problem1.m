% Given Values
p = 9.55e5;
N = 2;
T = 300;
R = 8.314462;
c1 = 3.69e-1;
c2 = 4.27e-5;

%% Part 1
% function F(V)
f = @(V) ((p+(c1.*(N^2/V.^2))) .* (V - (N * c2))) - (N * R * T);

a = 0.001;
b = 0.006;
tol = 1e-9;
num_steps = 1000;
root_estimate = 0;

% avoid evaluating f more than necessary
fa = f(a);
fb = f(b);

% use bisection method
for k = 1:num_steps
    m = 0.5*(a + b);
    fm = f(m);
  
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
        root_estimate = m;
end

V_true = 5.00565254961085e-3;

error = abs(root_estimate - V_true);
rel_error = error / V_true;
residual = abs(f(root_estimate));

%% Part 2
% function g(v)
g = @(V) (1 / (N * R * T)) .* (p + (c1 .* (N^2 ./ V.^2))) .* (V - (N * c2)) - 1;

% defn
a2 = 0.001;
b2 = 0.006;
tol = 1e-9;
num_steps_2 = 1000;
root_estimate_2 = 0;

% avoid evaluating g more than necessary
ga = g(a2);
gb = g(b2);

% use bisection method
for k2 = 1:num_steps_2
    m2 = 0.5*(a2 + b2);
    gm = g(m2);
  
 if 0.5*(b2 - a2) < tol
     break;
     
 elseif ga*gm < 0
      b2 = m2;
      gb = gm;

 elseif gb*gm < 0
        a2 = m2;
        ga = gm;

 else
      %g(m2) == 0
      % so root_estimate_2 = m2;
      break; 

  end
        root_estimate_2 = m2;
end

V_true = 5.00565254961085e-3;

error_2 = abs(root_estimate_2 - V_true);
residual_2 = abs(g(root_estimate_2));

% Absolute error of the final midpointfrom part 1 and part 2 are the same. 
% The residual from part 1 is 1.0459e-04 larger than the residual from 
% part 2. Essentially, the absolute error and residuals are practially 
% equal in both part 1 and part 2.

% I don't think using the value of the residuals is a good way to estimate
% the accuracy of an approximate root because the residual does not reflect
% how small/large the interval is which is important when using the
% bisection method.

%% Part 3

% New Values
p = 9.55e3; 
N = 2; 
T = 300; 
R = 8.314462e4; 
c1 = 3.69e9; 
c2 = 42.7; 

% function h(V_3)
h = @(V) ((p+(c1.*(N^2/V.^2))) .* (V - (N * c2))) - (N * R * T);

% defn
a3 = 1e3;
b3 = 6e3;
tol = 1e-9;
num_steps_3 = 23; % same number of bisection steps that k went up until 
% in part 1 even though the num_steps was 1000 for part 1, the number of 
% actual bisection steps stopped at 23

root_estimate_3 = 0;

predicted_iters = ceil(log2((b3-a3)/tol)); % floor was giving me the wrong output for problem 2 so I also changed it for problem 1

% avoid evaluating h more than necessary
ha = h(a3);
hb = h(b3);

% use bisection method
for k3 = 1:num_steps_3
    m3 = 0.5*(a3 + b3);
    hm = h(m3);
  
 if 0.5*(b3 - a3) < tol
     break;
     
 elseif ha*hm < 0
      b3 = m3;
      hb = hm;

 elseif hb*hm < 0
        a3 = m3;
        ha = hm;

 else
      % h(m3) == 0
      % so root_estimate_3 = m3;
      break; 

  end
        root_estimate_3 = m3;
end

V3_true = 5.00565254961085e3;

error_3 = abs(root_estimate_3 - V3_true);
rel_error_3 = error_3 / V3_true;

% There is a very small difference between absolute and relative error of 
% the midpoint for part 1 and part 3. The relative error of part 3 is larger 
% than the relative error for part 1 by 7.2535e-08. The absolute error of 
% part 3 is larger than the absolute error for part 1 by 4.7957e-04. Since
% these values are so small, the relative and absolute error of the
% midpoint for both part 1 and part 3 are practically the same.

m_in_meters  = m*1e-6;
V_true = 5.00565254961085e-3;

error_in_meters = abs(m_in_meters - V_true);
% This error is 0.0050 so it seems pretty significant.

% Relative error is more reliable than absolute error because it compares
% the error to the size of the true value which is helpful when the you
% have very large or small values since the absolute error could be really
% small but when you compare it to the true value you find a relative error
% that is actually large.