function res=Leakage_test( data, biasIdx, diagIdx, pfa)
% Leakage_test - Detect leakages in purge system
%
% Inputs: 
%   1) data     (Measured data)
%   2) biasIdx  (Samples [start end] for bias estimation)
%   3) diagIdx  (Samples [start end] for diagnosis sequence)
%   4) pfa,     (Probability of false alarm)
%
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
  
  T = 0;
  J = 0;
  R = 0;
  
  % Return results
  res.T = T;
  res.J = J;
  res.R = R;
end


function bhat = EstimateBias(y)
  % Estimate bias
  bhat = ;
end

function s2 = EstimateVariance(y)
  % Estimate variance
  
  s2 = ;
end

function [T, R, J] = TQCalc(y,s2,pfa,k1,Ts)
  % Compute test quantity, residual, and threshold
  
  R = ;
  T = ;
  J = ;
end
