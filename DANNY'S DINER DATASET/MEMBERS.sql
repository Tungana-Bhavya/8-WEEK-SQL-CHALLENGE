-- case study 1: DANNY'S DINNER

-- creation of members table 


CREATE TABLE bha_members
    (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO bha_members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');