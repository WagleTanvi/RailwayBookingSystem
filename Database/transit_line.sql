use TrainDatabase;
show tables;
describe transit_line;
SET FOREIGN_KEY_CHECKS=0;
Truncate table transit_line;
INSERT INTO transit_line(tl_id,tl_name,origin_station_id,termin_station_id, fare) VALUES
 ('NE','Northeast Corridor',16,25, 2.0)
,('AC','Atlantic City Line',11,15, 5.0)
,('RV','Raritan Valley Line',15,18, 3.0)
,('PB','Princeton Branch',18,24, 10.0)
,('PV','Pascack Valley',25,28, 2.0)
,('NJC','North Jersey Coast Line',29,31, 3.0);
Select * from transit_line;
