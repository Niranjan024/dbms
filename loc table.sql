create table location_table1(
   location_id number(4) not null,
    st_addr varchar(40) ,
    postal_code varchar(12),
    city varchar(30) not null,
    state_province varchar(25),
    country_id char(2) 
);
desc location_table1;
