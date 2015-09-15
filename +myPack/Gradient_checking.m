function [ error ] = Gradient_checking(fun, theta0, num_checks, varargin)
% gradient checking: this function randomly checks the gradient calculated
% by fun num_checks times and output the average error.


    delta = 10^(-4);%can not be very small, avoid numeric error
    %get the gradient calculated by fun
    T = theta0;
    [f,g] = fun(T, varargin{:});
    %initial error value
    error = 0;
    %random checking num_checks times
    for i=1:num_checks
        %randomly choose jth entry 
        j = randsample(numel(T),1);
        %T_minus and T_plus are used to do numerical estimation of the
        %gradient. only differ from T at jth entry
        T_minus=T; T_minus(j) = T_minus(j)-delta;
        T_plus=T; T_plus(j) = T_plus(j)+delta;
        %calulate the function value at T_minus and T_plus
        f_minus =fun(T_minus, varargin{:});
        f_plus =fun(T_plus, varargin{:});
        %numerical estimate of the gradient
        g_est = (f_plus-f_minus)/(2*delta);
        %calculate the difference between estimated and calculated gradient
        error = abs(g(j)-g_est)+error;
    end
    %average the error
    error = error/num_checks;
end