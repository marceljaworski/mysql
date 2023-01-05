
create table account (
account_id integer not null auto_increment,
avail_balance float,
close_date date,
last_activity_date date,
open_date date not null,
pending_balance float,
status varchar(10),
cust_id integer,
open_branch_id integer not null,
open_emp_id integer not null,
product_cd varchar(10) not null,
primary key (account_id)
);

create table acc_transaction (
txn_id bigint not null auto_increment,
amount float not null,
funds_avail_date datetime not null,
txn_date datetime not null,
txn_type_cd varchar(10),
account_id integer,
execution_branch_id integer,
teller_emp_id integer,
primary key (txn_id)
);

create table branch (
branch_id integer not null auto_increment,
address varchar(30),
city varchar(20),
name varchar(20) not null,
state varchar(10),
zip_code varchar(12),
primary key (branch_id)
);

create table business (
incorp_date date,
name varchar(255) not null,
state_id varchar(10) not null,
cust_id integer not null,
primary key (cust_id)
);

create table customer (
cust_id integer not null auto_increment,
address varchar(30),
city varchar(20),
cust_type_cd varchar(1) not null,
fed_id varchar(12) not null,
postal_code varchar(10),
state varchar(20),
primary key (cust_id)
);

create table department (
dept_id integer not null auto_increment,
name varchar(20) not null,
primary key (dept_id)
);

create table employee (
emp_id integer not null auto_increment,
end_date date,
first_name varchar(20) not null,
last_name varchar(20) not null,
start_date date not null,
title varchar(20),
assigned_branch_id integer,
dept_id integer,
superior_emp_id integer,
primary key (emp_id)
);

create table individual (
birth_date date,
first_name varchar(30) not null,
last_name varchar(30) not null,
cust_id integer not null,
primary key (cust_id)
);

create table officer (
officer_id integer not null auto_increment,
end_date date,
first_name varchar(30) not null,
last_name varchar(30) not null,
start_date date not null,
title varchar(20),
cust_id integer,
primary key (officer_id)
);

create table product (
product_cd varchar(10) not null,
date_offered date,
date_retired date,
name varchar(50) not null,
product_type_cd varchar(255),
primary key (product_cd)
);

create table product_type (
product_type_cd varchar(255) not null,
name varchar(50),
primary key (product_type_cd)
);

alter table account 
add constraint account_customer_fk 
foreign key (cust_id) 
references customer (cust_id);

alter table account 
add constraint account_branch_fk 
foreign key (open_branch_id) 
references branch (branch_id);

alter table account 
add constraint account_employee_fk 
foreign key (open_emp_id) 
references employee (emp_id);

alter table account 
add constraint account_product_fk 
foreign key (product_cd) 
references product (product_cd);

alter table acc_transaction 
add constraint acc_transaction_account_fk 
foreign key (account_id) 
references account (account_id);

alter table acc_transaction 
add constraint acc_transaction_branch_fk 
foreign key (execution_branch_id) 
references branch (branch_id);

alter table acc_transaction 
add constraint acc_transaction_employee_fk 
foreign key (teller_emp_id) 
references employee (emp_id);

alter table business 
add constraint business_employee_fk 
foreign key (cust_id) 
references customer (cust_id);

alter table employee 
add constraint employee_branch_fk 
foreign key (assigned_branch_id) 
references branch (branch_id);

alter table employee 
add constraint employee_department_fk 
foreign key (dept_id) 
references department (dept_id);

alter table employee 
add constraint employee_employee_fk 
foreign key (superior_emp_id) 
references employee (emp_id);

alter table individual 
add constraint individual_customer_fk 
foreign key (cust_id) 
references customer (cust_id);

alter table officer 
add constraint officer_customer_fk 
foreign key (cust_id) 
references customer (cust_id);

alter table product 
add constraint product_product_type_fk 
foreign key (product_type_cd) 
references product_type (product_type_cd);




-- begin data population


-- set mode -- 
-- http://stackoverflow.com/questions/11448068/mysql-error-code-1175-during-update-in-mysql-workbench
set sql_safe_updates = 0;


-- department data  
insert into department (dept_id, name)
values (null, 'operations');
insert into department (dept_id, name)
values (null, 'loans');
insert into department (dept_id, name)
values (null, 'administration');

insert into department (dept_id, name)
values (null, 'it');

/* branch data */
insert into branch (branch_id, name, address, city, state, zip_code)
values (null, 'headquarters', '3882 main st.', 'waltham', 'ma', '02451');
insert into branch (branch_id, name, address, city, state, zip_code)
values (null, 'woburn branch', '422 maple st.', 'woburn', 'ma', '01801');
insert into branch (branch_id, name, address, city, state, zip_code)
values (null, 'quincy branch', '125 presidential way', 'quincy', 'ma', '02169');
insert into branch (branch_id, name, address, city, state, zip_code)
values (null, 'so. nh branch', '378 maynard ln.', 'salem', 'nh', '03079');

/* employee data */
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'michael', 'smith', '2001-06-22', 
(select dept_id from department where name = 'administration'), 
'president', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'susan', 'barker', '2002-09-12', 
(select dept_id from department where name = 'administration'), 
'vice president', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'robert', 'tyler', '2000-02-09',
(select dept_id from department where name = 'administration'), 
'treasurer', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'susan', 'hawthorne', '2002-04-24', 
(select dept_id from department where name = 'operations'), 
'operations manager', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'john', 'gooding', '2003-11-14', 
(select dept_id from department where name = 'loans'), 
'loan manager', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'helen', 'fleming', '2004-03-17', 
(select dept_id from department where name = 'operations'), 
'head teller', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'chris', 'tucker', '2004-09-15', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'sarah', 'parker', '2002-12-02', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'jane', 'grossman', '2002-05-03', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'headquarters'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'paula', 'roberts', '2002-07-27', 
(select dept_id from department where name = 'operations'), 
'head teller', 
(select branch_id from branch where name = 'woburn branch'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'thomas', 'ziegler', '2000-10-23', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'woburn branch'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'samantha', 'jameson', '2003-01-08', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'woburn branch'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'john', 'blake', '2000-05-11', 
(select dept_id from department where name = 'operations'), 
'head teller', 
(select branch_id from branch where name = 'quincy branch'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'cindy', 'mason', '2002-08-09', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'quincy branch'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'frank', 'portman', '2003-04-01', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'quincy branch'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'theresa', 'markham', '2001-03-15', 
(select dept_id from department where name = 'operations'), 
'head teller', 
(select branch_id from branch where name = 'so. nh branch'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'beth', 'fowler', '2002-06-29', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'so. nh branch'));
insert into employee (emp_id, first_name, last_name, start_date, 
dept_id, title, assigned_branch_id)
values (null, 'rick', 'tulman', '2002-12-12', 
(select dept_id from department where name = 'operations'), 
'teller', 
(select branch_id from branch where name = 'so. nh branch'));

/* create data for self-referencing foreign key 'superior_emp_id' */
create temporary table emp_tmp as
select emp_id, first_name, last_name from employee;



update employee set superior_emp_id =
(select emp_id from emp_tmp where last_name = 'smith' and first_name = 'michael')
where ((last_name = 'barker' and first_name = 'susan')
or (last_name = 'tyler' and first_name = 'robert'));
update employee set superior_emp_id =
(select emp_id from emp_tmp where last_name = 'tyler' and first_name = 'robert')
where last_name = 'hawthorne' and first_name = 'susan';
update employee set superior_emp_id =
(select emp_id from emp_tmp where last_name = 'hawthorne' and first_name = 'susan')
where ((last_name = 'gooding' and first_name = 'john')
or (last_name = 'fleming' and first_name = 'helen')
or (last_name = 'roberts' and first_name = 'paula') 
or (last_name = 'blake' and first_name = 'john') 
or (last_name = 'markham' and first_name = 'theresa')); 
update employee set superior_emp_id =
(select emp_id from emp_tmp where last_name = 'fleming' and first_name = 'helen')
where ((last_name = 'tucker' and first_name = 'chris') 
or (last_name = 'parker' and first_name = 'sarah') 
or (last_name = 'grossman' and first_name = 'jane'));  
update employee set superior_emp_id =
(select emp_id from emp_tmp where last_name = 'roberts' and first_name = 'paula')
where ((last_name = 'ziegler' and first_name = 'thomas')  
or (last_name = 'jameson' and first_name = 'samantha'));   
update employee set superior_emp_id =
(select emp_id from emp_tmp where last_name = 'blake' and first_name = 'john')
where ((last_name = 'mason' and first_name = 'cindy')   
or (last_name = 'portman' and first_name = 'frank'));    
update employee set superior_emp_id =
(select emp_id from emp_tmp where last_name = 'markham' and first_name = 'theresa')
where ((last_name = 'fowler' and first_name = 'beth')   
or (last_name = 'tulman' and first_name = 'rick'));    

drop table emp_tmp;

/* product type data */
insert into product_type (product_type_cd, name)
values ('account','customer accounts');
insert into product_type (product_type_cd, name)
values ('loan','individual and business loans');
insert into product_type (product_type_cd, name)
values ('insurance','insurance offerings');

/* product data */
insert into product (product_cd, name, product_type_cd, date_offered)
values ('chk','checking account','account','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('sav','savings account','account','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('mm','money market account','account','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('cd','certificate of deposit','account','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('mrt','home mortgage','loan','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('aut','auto loan','loan','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('bus','business line of credit','loan','2000-01-01');
insert into product (product_cd, name, product_type_cd, date_offered)
values ('sbl','small business loan','loan','2000-01-01');

/* residential customer data */
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '111-11-1111', 'i', '47 mockingbird ln', 'lynnfield', 'ma', '01940');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'james', 'hadley', '1972-04-22' from customer
where fed_id = '111-11-1111';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '222-22-2222', 'i', '372 clearwater blvd', 'woburn', 'ma', '01801');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'susan', 'tingley', '1968-08-15' from customer
where fed_id = '222-22-2222';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '333-33-3333', 'i', '18 jessup rd', 'quincy', 'ma', '02169');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'frank', 'tucker', '1958-02-06' from customer
where fed_id = '333-33-3333';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '444-44-4444', 'i', '12 buchanan ln', 'waltham', 'ma', '02451');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'john', 'hayward', '1966-12-22' from customer
where fed_id = '444-44-4444';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '555-55-5555', 'i', '2341 main st', 'salem', 'nh', '03079');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'charles', 'frasier', '1971-08-25' from customer
where fed_id = '555-55-5555';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '666-66-6666', 'i', '12 blaylock ln', 'waltham', 'ma', '02451');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'john', 'spencer', '1962-09-14' from customer
where fed_id = '666-66-6666';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '777-77-7777', 'i', '29 admiral ln', 'wilmington', 'ma', '01887');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'margaret', 'young', '1947-03-19' from customer
where fed_id = '777-77-7777';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '888-88-8888', 'i', '472 freedom rd', 'salem', 'nh', '03079');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'louis', 'blake', '1977-07-01' from customer
where fed_id = '888-88-8888';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '999-99-9999', 'i', '29 maple st', 'newton', 'ma', '02458');
insert into individual (cust_id, first_name, last_name, birth_date)
select cust_id, 'richard', 'farley', '1968-06-16' from customer
where fed_id = '999-99-9999';

/* corporate customer data */
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '04-1111111', 'b', '7 industrial way', 'salem', 'nh', '03079');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'chilton engineering', '12-345-678', '1995-05-01' from customer
where fed_id = '04-1111111';
insert into officer (officer_id, cust_id, first_name, last_name,
title, start_date)
select null, cust_id, 'john', 'chilton', 'president', '1995-05-01'
from customer
where fed_id = '04-1111111';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '04-2222222', 'b', '287a corporate ave', 'wilmington', 'ma', '01887');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'northeast cooling inc.', '23-456-789', '2001-01-01' from customer
where fed_id = '04-2222222';
insert into officer (officer_id, cust_id, first_name, last_name,
title, start_date)
select null, cust_id, 'paul', 'hardy', 'president', '2001-01-01'
from customer
where fed_id = '04-2222222';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '04-3333333', 'b', '789 main st', 'salem', 'nh', '03079');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'superior auto body', '34-567-890', '2002-06-30' from customer
where fed_id = '04-3333333';
insert into officer (officer_id, cust_id, first_name, last_name,
title, start_date)
select null, cust_id, 'carl', 'lutz', 'president', '2002-06-30'
from customer
where fed_id = '04-3333333';
insert into customer (cust_id, fed_id, cust_type_cd,
address, city, state, postal_code)
values (null, '04-4444444', 'b', '4772 presidential way', 'quincy', 'ma', '02169');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'aaa insurance inc.', '45-678-901', '1999-05-01' from customer
where fed_id = '04-4444444';
insert into officer (officer_id, cust_id, first_name, last_name,
title, start_date)
select null, cust_id, 'stanley', 'cheswick', 'president', '1999-05-01'
from customer
where fed_id = '04-4444444';

/* residential account data */
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'woburn' limit 1) e
cross join
(select 'chk' prod_cd, '2000-01-15' open_date, '2005-01-04' last_date,
1057.75 avail, 1057.75 pend union all
select 'sav' prod_cd, '2000-01-15' open_date, '2004-12-19' last_date,
500.00 avail, 500.00 pend union all
select 'cd' prod_cd, '2004-06-30' open_date, '2004-06-30' last_date,
3000.00 avail, 3000.00 pend) a
where c.fed_id = '111-11-1111';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'woburn' limit 1) e
cross join
(select 'chk' prod_cd, '2001-03-12' open_date, '2004-12-27' last_date,
2258.02 avail, 2258.02 pend union all
select 'sav' prod_cd, '2001-03-12' open_date, '2004-12-11' last_date,
200.00 avail, 200.00 pend) a
where c.fed_id = '222-22-2222';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'quincy' limit 1) e
cross join
(select 'chk' prod_cd, '2002-11-23' open_date, '2004-11-30' last_date,
1057.75 avail, 1057.75 pend union all
select 'mm' prod_cd, '2002-12-15' open_date, '2004-12-05' last_date,
2212.50 avail, 2212.50 pend) a
where c.fed_id = '333-33-3333';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'waltham' limit 1) e
cross join
(select 'chk' prod_cd, '2003-09-12' open_date, '2005-01-03' last_date,
534.12 avail, 534.12 pend union all
select 'sav' prod_cd, '2000-01-15' open_date, '2004-10-24' last_date,
767.77 avail, 767.77 pend union all
select 'mm' prod_cd, '2004-09-30' open_date, '2004-11-11' last_date,
5487.09 avail, 5487.09 pend) a
where c.fed_id = '444-44-4444';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'salem' limit 1) e
cross join
(select 'chk' prod_cd, '2004-01-27' open_date, '2005-01-05' last_date,
2237.97 avail, 2897.97 pend) a
where c.fed_id = '555-55-5555';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'waltham' limit 1) e
cross join
(select 'chk' prod_cd, '2002-08-24' open_date, '2004-11-29' last_date,
122.37 avail, 122.37 pend union all
select 'cd' prod_cd, '2004-12-28' open_date, '2004-12-28' last_date,
10000.00 avail, 10000.00 pend) a
where c.fed_id = '666-66-6666';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'woburn' limit 1) e
cross join
(select 'cd' prod_cd, '2004-01-12' open_date, '2004-01-12' last_date,
5000.00 avail, 5000.00 pend) a
where c.fed_id = '777-77-7777';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'salem' limit 1) e
cross join
(select 'chk' prod_cd, '2001-05-23' open_date, '2005-01-03' last_date,
3487.19 avail, 3487.19 pend union all
select 'sav' prod_cd, '2001-05-23' open_date, '2004-10-12' last_date,
387.99 avail, 387.99 pend) a
where c.fed_id = '888-88-8888';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'waltham' limit 1) e
cross join
(select 'chk' prod_cd, '2003-07-30' open_date, '2004-12-15' last_date,
125.67 avail, 125.67 pend union all
select 'mm' prod_cd, '2004-10-28' open_date, '2004-10-28' last_date,
9345.55 avail, 9845.55 pend union all
select 'cd' prod_cd, '2004-06-30' open_date, '2004-06-30' last_date,
1500.00 avail, 1500.00 pend) a
where c.fed_id = '999-99-9999';

-- corporate account data  
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'salem' limit 1) e
cross join
(select 'chk' prod_cd, '2002-09-30' open_date, '2004-12-15' last_date,
23575.12 avail, 23575.12 pend union all
select 'bus' prod_cd, '2002-10-01' open_date, '2004-08-28' last_date,
0 avail, 0 pend) a
where c.fed_id = '04-1111111';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'woburn' limit 1) e
cross join
(select 'bus' prod_cd, '2004-03-22' open_date, '2004-11-14' last_date,
9345.55 avail, 9345.55 pend) a
where c.fed_id = '04-2222222';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'salem' limit 1) e
cross join
(select 'chk' prod_cd, '2003-07-30' open_date, '2004-12-15' last_date,
38552.05 avail, 38552.05 pend) a
where c.fed_id = '04-3333333';
insert into account (account_id, product_cd, cust_id, open_date,
last_activity_date, status, open_branch_id,
open_emp_id, avail_balance, pending_balance)
select null, a.prod_cd, c.cust_id, a.open_date, a.last_date, 'active',
e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
(select b.branch_id, e.emp_id 
from branch b inner join employee e on e.assigned_branch_id = b.branch_id
where b.city = 'quincy' limit 1) e
cross join
(select 'sbl' prod_cd, '2004-02-22' open_date, '2004-12-17' last_date,
50000.00 avail, 50000.00 pend) a
where c.fed_id = '04-4444444';

-- put $100 in all checking/savings accounts on date account opened  
insert into acc_transaction (txn_id, txn_date, account_id, txn_type_cd,
amount, funds_avail_date)
select null, a.open_date, a.account_id, 'cdt', 100, a.open_date
from account a
where a.product_cd in ('chk','sav','cd','mm');
