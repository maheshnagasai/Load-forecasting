% Variables creation

tbl = table(Hour,temp,month1, weekday1,year1,Load,trend);
tbl.Hour = categorical(Hour);
tbl.weekday = categorical(weekday1);
tbl.month = categorical(month1);
temp2 = temp.^2;
temp3 = temp.^3;
templag1 = lagmatrix(temp,4);
temp2lag1 = power(templag1,2);
temp3lag1 = power(templag1,3);
tempavg;
H;
H = categorical(H);
tempavg2 = power(tempavg,2);
tempavg3 = power(tempavg,3);

%Training dataset
tbl2 =table(tbl.Hour,tbl.weekday,tbl.year1,tbl.month,temp,temp2,temp3,tbl.Load,tbl.trend,templag1,temp2lag1,temp3lag1,tempavg,tempavg2,tempavg3,H,'VariableNames',{'Hour','weekday','year','month','temp','temp2','temp3','Load','trend','templag1','temp2lag1','temp3lag1','tempavg','tempavg2','tempavg3','H'});
%   training = tbl2(tbl2.year==2005 | tbl2.year==2006,:);
  training = tbl2(tbl2.year==2005 | tbl2.year==2006 | tbl2.year ==2007,:);
%training = tbl2(tbl2.year==2006 | tbl2.year ==2007,:);

%Validation dataset
tbl3 =table(tbl.Hour,tbl.weekday,tbl.year1,tbl.month,temp,temp2,temp3,tbl.trend,templag1,temp2lag1,temp3lag1,tempavg,tempavg2,tempavg3,H,'VariableNames',{'Hour','weekday','year','month','temp','temp2','temp3','trend','templag1','temp2lag1','temp3lag1','tempavg','tempavg2','tempavg3','H'});
validation = tbl3(tbl3.year==2008,:);

%Regression Model
%   mdl = fitglm(training,'Load~trend+month+weekday+Hour+weekday*Hour+temp+temp2+temp3+temp*month+temp2*month+temp3*month+temp*Hour+temp2*Hour+temp3*Hour+templag+temp2lag+temp3lag+templag*month+temp2lag*month+temp3lag*month+templag*Hour+temp2lag*Hour+temp3lag*Hour');
  mdl = fitglm(training,'Load~trend+H+month+weekday+Hour+weekday*Hour+temp+temp2+temp3+temp*month+temp2*month+temp3*month+temp*Hour+temp2*Hour+temp3*Hour+templag1+temp2lag1+temp3lag1+templag1*month+temp2lag1*month+temp3lag1*month+templag1*Hour+temp2lag1*Hour+temp3lag1*Hour+tempavg+tempavg2+tempavg3+tempavg*month+tempavg2*month+tempavg3*month+tempavg*Hour+tempavg2*Hour+tempavg3*Hour');
%   mdl = fitglm(training,'Load~trend+month+weekday+Hour+weekday*Hour+temp+temp2+temp3+temp*month+temp2*month+temp3*month+temp*Hour+temp2*Hour+temp3*Hour');

ypred = predict(mdl,validation);


% Error Calculation
% Actual_Load = A ;
% err = Actual_Load-ypred;
% errpct = abs(err)./Actual_Load*100;
% MAE = mean(abs(err));
% MAPE = mean(errpct(~isinf(errpct)));

