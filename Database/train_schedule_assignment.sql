use TrainDatabase;
show tables;
SET FOREIGN_KEY_CHECKS=0;
Truncate table train_schedule_assignment;
Select * from train_schedule_assignment;
INSERT INTO train_schedule_assignment(schedule_num,tl_id,train_id) VALUES
 (1000,'AC',101)
,(1001,'AC',101)
,(1002,'AC',101)
,(1003,'AC',101)
,(1004,'AC',102)
,(1005,'AC',102)
,(1006,'AC',102)
,(1007,'AC',102)
,(1008,'NE',103)
,(1009,'NE',103)
,(1010,'NE',104)
,(1011,'NE',104)
,(1012,'NE',104)
,(1013,'NE',105)
,(1014,'NE',105)
,(1015,'NE',105)
,(1016,'NE',106)
,(1017,'NE',107)
,(1018,'NE',107)
,(1019,'NE',108)
,(1020,'NE',108)
,(1021,'PV',101)
,(1022,'PV',113)
,(1023,'NJC',114)
,(1024,'NJC',114)
,(1025,'NJC',115)
,(1026,'RV',106)
,(1027,'RV',113)
,(1028,'RV',107)
,(1029,'RV',108)
,(1030,'PB',109)
,(1031,'PB',110);
