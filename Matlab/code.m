%% Load in the datset checkbook-explorerfy18.csv using Import Data
% Subset it to relevant values
% filter only certain variables
chk = checkbookexplorerfy18(:,checkbookexplorerfy18.Properties.VariableNames([4,5,6,7,8,9,10,14,15,16]));

%% Get a summary across months
fire = grpstats(chk(chk.DepartmentName == 'Fire Department',{'FiscalYear','FiscalMonth','MonetaryAmount'}),'FiscalMonth','sum');
% fire 12x4 table
police = grpstats(chk(chk.DepartmentName == 'Police Department',{'FiscalYear','FiscalMonth','MonetaryAmount'}),'FiscalMonth','sum');
% police 12x4 table

%% Smooth line chart
% FD data points 
scatter(fire.FiscalMonth,fire.sum_MonetaryAmount,'.r'); 
% on the same chart
hold on
% FD fitted line
plot(fit(fire.FiscalMonth,fire.sum_MonetaryAmount,'smoothingspline'),'r');
% PD data points 
scatter(police.FiscalMonth,police.sum_MonetaryAmount,'.b');
% PD fitted line
plot(fit(police.FiscalMonth,police.sum_MonetaryAmount,'smoothingspline'),'b');

%% Mean line
average_level = mean(fire.sum_MonetaryAmount);
plot([1,12],[average_level ,average_level] ,'k--', Color='r')
average_level = mean(police.sum_MonetaryAmount);
plot([1,12],[average_level ,average_level] ,'k--', Color='b')
hold off

%% Label / axis / legend
xlabel('Month');
ylabel('Money spent');
title('Monthly Expenditure for Boston FD & PD');

ax = gca;
ax.XTick = 1:12;
ax.XTickLabel = {'JUL','AUG','SEP','OCT','NOV','DEC','JAN','FEB','MAR','APR','MAY','JUN'};
axis([0.5,12.5,1e6,8e6]);
box off

legend('Data FD','Fitted FD','Data PD','Fitted PD', 'Avg FD', 'Avg PD')