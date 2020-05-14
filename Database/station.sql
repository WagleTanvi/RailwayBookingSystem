use TrainDatabase;
show tables;
SET FOREIGN_KEY_CHECKS=0;
Truncate table station;
Select * from station;
INSERT INTO station(station_id,name,state_name,city_name) VALUES
 (11,'Atlantic City','NJ','Atlantic City')
,(12,'Egg Harbor City','NJ','Egg Harbor City')
,(13,'Hammonton','NJ','Atlantic County')
,(14,'Cherry Hill','NJ','Camden')
,(15,'Philadelphia','NJ','Philadelphia')
,(16,'Trenton','NJ','Trenton')
,(17,'Hamilton','NJ','Hamilton')
,(18,'Princeton Junction','NJ','Princeton')
,(19,'Jersey Avenue','NJ','New Brunswick')
,(20,'New Brunswick','NJ','New Brunswick')
,(21,'Edison','NJ','Edison')
,(22,'Metuchen','NJ','Metuchen')
,(23,'Elizabeth','NJ','Elizabeth')
,(24,'Newark Penn Station','NJ','Newark')
,(25,'New York','NY','New York')
,(26,'Teterboro','NJ','Hasbrouck Heights')
,(27,'Secaucus Junction','NJ','Secaucus')
,(28,'Hoboken','NJ','Hoboken')
,(29,'Red Bank','NJ','Red Bank')
,(30,'Woodbridge','NJ','Woodbridge')
,(31,'Linden','NJ','Linden');




