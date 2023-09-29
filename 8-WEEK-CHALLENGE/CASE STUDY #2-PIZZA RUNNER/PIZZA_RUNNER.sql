  
  create schema pizza_runner;
 show databases;  
 use pizza_runner
  drop table if exists runners;
  create table runners
  (
  runner_id integer,
  registration_date date
  );