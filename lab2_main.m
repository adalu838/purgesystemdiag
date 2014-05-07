%% *** TSFS06 Laboration 2 Skeleton main file: Diagnosis of Purge System ***
clc
clear
close all

%% *** Data Loading ***
load diagnosisFile.mat

%% *** Plot data ***
d = diagnosisSequences.F00;

figure(1);
subplot(211)
plot(d.y);
title('F00')
subplot(212)
plot(d.D);
hold on;
plot(d.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d = diagnosisSequences.F05;

figure(2);
subplot(211)
plot( d.time, d.y);
title('F05')
subplot(212)
plot( d.time, d.D);
hold on;
plot( d.time, d.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d = diagnosisSequences.F10;

figure(3);
subplot(211)
plot( d.time, d.y);
title('F10')
subplot(212)
plot( d.time, d.D);
hold on;
plot( d.time, d.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d = diagnosisSequences.F35;

figure(4);
subplot(211)
plot( d.time, d.y);
title('F35')
subplot(212)
plot( d.time, d.D);
hold on;
plot( d.time, d.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d = diagnosisSequences.F50;

figure(5);
subplot(211)
plot( d.time, d.y);
title('F50')
subplot(212)
plot( d.time, d.D);
hold on;
plot( d.time, d.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d = diagnosisSequences.Fxx;

figure(6);
subplot(211)
plot( d.time, d.y);
title('Fxx')
subplot(212)
plot( d.time, d.D);
hold on;
plot( d.time, d.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

%% *** Set index intervals for all datasets
diagnosisSequences.F00.biasIdx  = []; %(Samples [start end] for bias estimation)
diagnosisSequences.F00.diagIdx  = []; %(Samples [start end] for diagnosis sequence 1)
diagnosisSequences.F00.diagIdx2 = []; %(Samples [start end] for diagnosis sequence 2)

diagnosisSequences.F10.biasIdx  = [];
diagnosisSequences.F10.diagIdx  = [];
diagnosisSequences.F10.diagIdx2 = [];

diagnosisSequences.F35.biasIdx  = [];
diagnosisSequences.F35.diagIdx  = [];
diagnosisSequences.F35.diagIdx2 = [];

diagnosisSequences.F50.biasIdx  = [];
diagnosisSequences.F50.diagIdx  = [];
diagnosisSequences.F50.diagIdx2 = [];

diagnosisSequences.F05.biasIdx  = [];
diagnosisSequences.F05.diagIdx  = [];

diagnosisSequences.Fxx.biasIdx  = [];
diagnosisSequences.Fxx.diagIdx  = [];

%% *** Detection results ***
pfa  = 0.01; % Probability of false alarm

d = diagnosisSequences.F00;
res00a  = Leakage_test( d, d.biasIdx, d.diagIdx, pfa)  ;
res00b  = Leakage_test( d, d.biasIdx, d.diagIdx2, pfa) ;

d = diagnosisSequences.F05;
res05  = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;

d = diagnosisSequences.F10;
res10a = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;
res10b = Leakage_test( d, d.biasIdx, d.diagIdx2, pfa);

d = diagnosisSequences.F35;
res35a = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;
res35b = Leakage_test( d, d.biasIdx, d.diagIdx2, pfa);

d = diagnosisSequences.F50;
res50a = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;
res50b = Leakage_test( d, d.biasIdx, d.diagIdx2, pfa);

d = diagnosisSequences.Fxx;
resxx  = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;

%% *** Assumptions validation

