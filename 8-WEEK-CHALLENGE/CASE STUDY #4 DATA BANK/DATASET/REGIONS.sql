CREATE DATABASE data_bank;

USE data_bank;

CREATE TABLE regions (
region_id INTEGER,
region_name VARCHAR(9)
);
INSERT INTO regions(region_id, region_name) 
VALUES(1, 'Australia'), (2,'America'), (3, 'Africa'), (4, 'Asia'), (5, 'Europe');

SELECT * FROM regions;