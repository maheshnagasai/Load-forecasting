

% temp2 = temp.^2;
% temp3 = temp.^3;
temp = 0;

for i = 1:7
tbl = table(Hour1, StationID1, Month1,temp1, Weekday1,Year1);

tbl.Hour = categorical(Hour1);
tbl.weekday = categorical(Weekday1);
tbl.month = categorical(Month1);
tbl.year = categorical(Year1);

% training = tbl(tbl.Year1==2005 | tbl.Year1==2006,:);
% training = training(training.StationID1 == rankings(2),:);
% tempt = training.temp1;temp =temp + tempt; c=2; temp = (temp)/c;

tbl = tbl(tbl.StationID1 == r(i),:);
tempt = tbl.temp1;
temp =temp + tempt;
tempi = (temp)/i;
temp2 = tempi.^2;
temp3 = tempi.^3;

tbl2 =table(tbl.Hour,tbl.weekday,tbl.Year1,tbl.month,tempi,temp2,temp3,'VariableNames',{'Hour','weekday','year','month','temp','temp2','temp3'});

training = tbl2(tbl2.year==2005 | tbl2.year==2006,:);

testing = tbl2(tbl.Year1==2007,:);

tbl3 = table(Load_L,trend_L,Year_L);

tbl4 = tbl3(tbl3.Year_L==2005 | tbl3.Year_L==2006,:);

Load = tbl4.Load_L;

trend = tbl4.trend_L;

tbl5 = tbl3(tbl3.Year_L==2007,:);

Load_Actual = tbl5.Load_L;

trend_p = tbl5.trend_L;

test = table(testing.Hour, testing.weekday,testing.month, testing.temp,testing.temp2,testing.temp3,trend_p,'VariableNames',{'Hour','weekday','month','temp','temp2','temp3','trend'});

train = table(training.Hour, training.weekday,training.month, training.temp,training.temp2,training.temp3,Load,trend,'VariableNames',{'Hour','weekday','month','temp','temp2','temp3','Load','trend'});
mdl = fitglm(train,'Load~trend+month+weekday+Hour+weekday*Hour+temp+temp2+temp3+temp*month+temp2*month+temp3*month+temp*Hour+temp2*Hour+temp3*Hour');
ypred = predict(mdl,test);


%%Error Calculation
Actual_Load = Load_Actual ;
err = Actual_Load-ypred;
errpct = abs(err)./Actual_Load*100;
MAE = mean(abs(err));
MAPE(i) = mean(errpct(~isinf(errpct)));


end
