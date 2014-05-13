%% *** TSFS06 Laboration 2 Skeleton main file: Diagnosis of Purge System ***
clc
clear
close all
cd Y:/Desktop/TSFS06/lab2/purgesystemdiag
%% *** Data Loading ***
load diagnosisFile.mat

%% *** Plot data ***
d_hat = diagnosisSequences.F00;

figure(1);
subplot(211)
plot(d_hat.time, d_hat.y);
title('F00')
xlabel('Tid [s]')
ylabel('Tryck i bränsletanken');
subplot(212)
plot(d_hat.time, d_hat.D);
hold on;
plot(d_hat.time, d_hat.P,'r');
legend('Diagnosventilposition','Purgeventilposition');
xlabel('Tid [s]')
ylabel('Ventilläge');
hold off;
%pdf_print('pFxx');

d_hat = diagnosisSequences.F05;

figure(2);
subplot(211)
plot(d_hat.time, d_hat.y);
title('F05')
subplot(212)
plot(d_hat.D);
hold on;
plot(d_hat.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d_hat = diagnosisSequences.F10;

figure(3);
%subplot(211)
plot(d_hat.time, d_hat.y);
title('F10')
subplot(212)
plot(d_hat.D);
hold on;
plot(d_hat.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d_hat = diagnosisSequences.F35;

figure(4);
subplot(211)
plot(d_hat.time, d_hat.y);
title('F35')
subplot(212)
plot(d_hat.D);
hold on;
plot(d_hat.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d_hat = diagnosisSequences.F50;

figure(5);
subplot(211)
plot(d_hat.time, d_hat.y);
title('F50')
subplot(212)
plot(d_hat.D);
hold on;
plot(d_hat.P,'r');
legend('Diagnosis valve position','Purge valve position');
hold off;

d_hat = diagnosisSequences.Fxx;

figure(6);
subplot(211)
plot(d_hat.time, d_hat.y);
title('Fxx')
xlabel('Sample')
ylabel('Tryck i bränsletanken');
subplot(212)
plot(d_hat.D);
hold on;
plot(d_hat.P,'r');
legend('Diagnosventilposition','Purgeventilposition');
xlabel('Sample')
ylabel('Ventilläge');
hold off;


%% *** Set index intervals for all datasets
diagnosisSequences.F00.biasIdx  = [953 1011];   %(Samples [start end] for bias estimation)
diagnosisSequences.F00.diagIdx  = [226 903];    %(Samples [start end] for diagnosis sequence 1)
diagnosisSequences.F00.diagIdx2 = [1330 2014];  %(Samples [start end] for diagnosis sequence 2)

diagnosisSequences.F05.biasIdx  = [9200 10000]; %
diagnosisSequences.F05.diagIdx  = [1753 8646];  %

diagnosisSequences.F10.biasIdx  = [1 76];       %
diagnosisSequences.F10.diagIdx  = [476 1021];   %
diagnosisSequences.F10.diagIdx2 = [1583 2193];  %

diagnosisSequences.F35.biasIdx  = [1120 1426];  %
diagnosisSequences.F35.diagIdx  = [891 999];    %
diagnosisSequences.F35.diagIdx2 = [1737 1830];  %

diagnosisSequences.F50.biasIdx  = [970 1500];   %
diagnosisSequences.F50.diagIdx  = [782 820];    %
diagnosisSequences.F50.diagIdx2 = [1938 1975];  %

diagnosisSequences.Fxx.biasIdx  = [9275 9999];  %
diagnosisSequences.Fxx.diagIdx  = [1717 8690];  %

%% *** Detection results ***
pfa  = 0.01; % Probability of false alarm

d_hat = diagnosisSequences.F00;
res00a  = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx, pfa)  ;
res00b  = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx2, pfa) ;

d_hat = diagnosisSequences.F05;
res05  = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx, pfa) ;

d_hat = diagnosisSequences.F10;
res10a = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx, pfa) ;
res10b = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx2, pfa);

d_hat = diagnosisSequences.F35;
res35a = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx, pfa) ;
res35b = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx2, pfa);

d_hat = diagnosisSequences.F50;
res50a = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx, pfa) ;
res50b = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx2, pfa);

d_hat = diagnosisSequences.Fxx;
resxx  = Leakage_test( d_hat, d_hat.biasIdx, d_hat.diagIdx, pfa) ;

%% *** Assumptions validation ***
japan{1} = 'F00';
japan{2} = 'F05';
japan{3} = 'F10';
japan{4} = 'F35';
japan{5} = 'F50';
japan{6} = 'FXX';


figure(7); clf;
subplot(2,2,1);
plot(xcorr(res00a.R))
title('Autocorrelation av residualen i fall A')
subplot(2,2,2);
normplot(res00a.R);
title('Normal Probability Plot (Fall A)')
subplot(2,2,3);
plot(xcorr(res00b.R))
title('Autocorrelation av residualen i fall B')
subplot(2,2,4);
normplot(res00b.R);
title('Normal Probability Plot (Fall B)')
pdf_print('modelval');

%%
figure(8); clf;
subplot(2,1,1);
plot(xcorr(res05.R));
title([japan{2}])
subplot(2,1,2);
normplot(res05.R);

figure(9); clf;
subplot(2,2,1);
plot(xcorr(res10a.R))
title([japan{3} 'a'])
subplot(2,2,2);
normplot(res10a.R);
title([japan{3} 'a'])
subplot(2,2,3);
plot(xcorr(res10b.R))
title([japan{3} 'b'])
subplot(2,2,4);
normplot(res10b.R);
title([japan{3} 'b'])

figure(10); clf;
subplot(2,2,1);
plot(xcorr(res35a.R))
title([japan{4} 'a'])
subplot(2,2,2);
normplot(res35a.R);
title([japan{4} 'a'])
subplot(2,2,3);
plot(xcorr(res35b.R))
title([japan{4} 'b'])
subplot(2,2,4);
normplot(res35b.R);
title([japan{4} 'b'])

figure(11); clf;
subplot(2,2,1);
plot(xcorr(res50a.R))
title([japan{5} 'a'])
subplot(2,2,2);
normplot(res50a.R);
title([japan{5} 'a'])
subplot(2,2,3);
plot(xcorr(res50b.R))
title([japan{5} 'b'])
subplot(2,2,4);
normplot(res50b.R);
title([japan{5} 'b'])

figure(12); clf;
subplot(2,1,1);
plot(xcorr(resxx.R));
title([japan{6}])
subplot(2,1,2);
normplot(resxx.R);
title([japan{6}])

%% 

test(1) = res00a.T/res00a.J;
test(2) = res05.T/res05.J;
test(3) = res10a.T/res10a.J;
test(4) = res35a.T/res35a.J;
test(5) = res50b.T/res50b.J; % dulig
test(6) = resxx.T/resxx.J;

xp=linspace(0.5,3.5,10);
yp=interp1([0.5 1 3.5],test(2:4),xp,'spline');

figure(13); clf;
plot([0 xp],[test(1) yp], 0.1*[0 5 10 35], [test(6) test(6) test(6) test(6)])
%axis([0 0.6 0.8 1.2]);
%% Estimation model of k2

rho = 1.2041;

B = [res05.k2;
     %res10a.k2;
     %res10b.k2;
     res35a.k2;
     res35b.k2;
     res50a.k2;
     res50b.k2];

A = [0.0005^2;
     %0.001^2;
     %0.001^2;
     0.0035^2;
     0.0035^2;
     0.005^2;
     0.005^2;];

C = A\B;

% Estimation of orifice diameter in the unknown case

d_haten(1) = sqrt(res05.k2/C);
d_haten(2) = sqrt(res10a.k2/C);
d_haten(3) = sqrt(res10b.k2/C);
d_haten(4) = sqrt(res35a.k2/C);
d_haten(5) = sqrt(res35b.k2/C);
d_haten(6) = sqrt(res50a.k2/C);
d_haten(7) = sqrt(res50b.k2/C);
d_haten(8) = sqrt(resxx.k2/C);

figure(14); clf;
plot([0.5 0.95 1.05 3.45 3.55 4.95 5 ],real(d_haten(1:end-1))./(10^(-4)*[5 10 10 35 35 50 50]),'o-')
hold on
plot([0.5 5],[0.9 1.1;0.9 1.1],'r-.')
hold off
xlabel('Håldiameter [mm]')
ylabel('Normaliserad diameterskattning')
pdf_print('d_hat_norm');