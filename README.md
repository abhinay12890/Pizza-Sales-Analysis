# Pizza Sales Analysis with SQL

## Overview
This Project explores the sales of Pizzas and analyze the trends. This is done in MySQL WorkBench.

## Project Structure
This repository contains the following files:

- `Dataset/`: Contains different tables like order, order details, pizza type, pizzas.

- `Questions.txt`: The questions which are answered through analysis of this project ranging from Beginner, Intermediate, Advanced.

- `Analysis of Pizzhut.sql`: SQL querys to extract information for the questions.

## Pre-Processing Used
Orders.csv have date and time columns which are difficult to import.

Manually creaing custom datatype columms for imorting.

```sql
Use your_database_name;

create table if not exists your_database_name.orders (
order_id int not null primary key,
order_date date not null,
order_time time not null);
```
# Database Schema Overview

| TABLE_NAME   | COLUMN_NAME        | DATA_TYPE | IS_NULLABLE | COLUMN_KEY | COLUMN_DEFAULT | EXTRA |
|--------------|--------------------|-----------|-------------|------------|----------------|-------|
| order_details| order_details_id    | int       | YES         |            | NULL           |       |
| order_details| order_id            | int       | YES         |            | NULL           |       |
| order_details| pizza_id            | text      | YES         |            | NULL           |       |
| order_details| quantity            | int       | YES         |            | NULL           |       |
| orders       | order_id            | int       | NO          | PRI        | NULL           |       |
| orders       | order_date          | date      | NO          |            | NULL           |       |
| orders       | order_time          | time      | NO          |            | NULL           |       |
| pizza_types  | pizza_type_id       | text      | YES         |            | NULL           |       |
| pizza_types  | name                | text      | YES         |            | NULL           |       |
| pizza_types  | category            | text      | YES         |            | NULL           |       |
| pizza_types  | ingredients         | text      | YES         |            | NULL           |       |
| pizzas       | pizza_id            | text      | YES         |            | NULL           |       |
| pizzas       | pizza_type_id       | text      | YES         |            | NULL           |       |
| pizzas       | size                | text      | YES         |            | NULL           |       |
| pizzas       | price               | double    | YES         |            | NULL           |       |

