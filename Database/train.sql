use TrainDatabase;
show tables;
SET FOREIGN_KEY_CHECKS=0;
Truncate table train;
Select * from train;
INSERT INTO train(train_id,number_of_cars,number_of_seats) VALUES
 (101,5,1)
,(102,5,3)
,(103,10,2)
,(104,12,2)
,(105,8,2)
,(106,5,4)
,(107,12,2)
,(108,10,2)
,(109,8,8)
,(110,8,2)
,(111,7,9)
,(112,6,2)
,(113,4,6)
,(114,3,4)
,(115,4,5);
