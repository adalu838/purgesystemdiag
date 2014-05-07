function res=Leakage_test( data, biasIdx, diagIdx, pfa)
% Leakage_test - Detect leakages in purge system
%
% Inputs: 
%   1) data     (Measured data)
%   2) biasIdx  (Samples [start end] for bias estimation)
%   3) diagIdx  (Samples [start end] for diagnosis sequence)
%   4) pfa,     (Probability of false alarm)
% Outputs:
%   res is a struct variable which includes:
%   1) T, (The test quantity)
%   2) J, (The threshold value)
%   3) R, (The residual vector)

  % Compute test quantity, threshold, and residual.
  % Write, and use, the three functions 
  % 1. EstimateBias()
  % 2. EstimateVariance()
  % 3. TQCalc()
  
  %daigdata = data()
  y = data.y;
  k1 = data.k1;
  Ts = data.Ts;
  
%   T = 0;
%   J = 0;
%   R = 0;
  % Estimate bias
  bhat = EstimateBias(y, biasIdx);
  
  % Extract data
  diagdata = y(diagIdx(1):diagIdx(2)) - bhat;
  
  % Estimate variance
  s2 = EstimateVariance(diagdata);
  
  % Compute test quantity, residual, and threshold
  [T, R, J] = TQCalc(diagdata,s2,pfa,k1,Ts);
  
  % Return results
  res.T = T;
  res.J = J;
  res.R = R;
end


function bhat = EstimateBias(y,index)
  % Estimate bias
  bhat = mean(y(index(1):index(2)));
end

function s2 = EstimateVariance(y)
  % Estimate variance
  N = length(y);
  Y = y(2:end);
  phi = [y(1:(end-1)) sqrt(-y(1:(end-1))) ones(N-1,1)];
  theta_hat = phi\Y;
  r = Y - phi*theta_hat;
  s2 = cov(r);
end

function [T, R, J] = TQCalc(y,s2,pfa,k1,Ts)
  % Compute test quantity, residual, and threshold
  N = length(y);
  alpha = 1 - Ts*k1;
  Y = y(2:end) - alpha*y(1:(end-1));
  phi = ones(N-1,1);
  theta_hat = phi\Y;
  R = Y - phi*theta_hat;
  T = 1/s2*R'*R;
  J = chi2inv(1-pfa, N-1);
end
