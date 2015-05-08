# Curl Up and Dye

Description:
This application is a database and interface for storing clients and stylists for a salon.

Author:
Chris Sefkin

Setup:
Requires postgres

License:
Not licensed, do whatever you want with it.

#psql

username=# CREATE DATABASE hair_salon;
username=# \c train_system;
train_system=# CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
train_system=# CREATE TABLE clients (id serial PRIMARY KEY, name varchar);
train_system=# CREATE TABLE stylists_clients (id serial PRIMARY KEY, stylist_id int, client_id int);
train_system=# CREATE DATABASE train_system_test WITH TEMPLATE hair_salon;
