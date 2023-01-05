SELECT * 
FROM account;
/*
SELECT * FROM acc_transaction;
SELECT * FROM branch;
SELECT * FROM business;
SELECT * FROM customer;
SELECT * FROM individual;
SELECT * FROM product;
*/
/* 4 */
SELECT txn_id, amount, account_id 
FROM acc_transaction;
/* 5 */
SELECT address, city 
FROM branch
LIMIT 3;
/* 6 */
SELECT name, incorp_date
FROM business
ORDER BY incorp_date ASC;
/* 7 */
SELECT fed_id, cust_id
FROM customer
WHERE state LIKE "nh";
/* 8 */
SELECT account_id, last_activity_date
FROM account
WHERE pending_balance<1000;
/* 9 */
SELECT account_id, last_activity_date
FROM account
WHERE pending_balance BETWEEN 1000 AND 3000;
/* 10 */
SELECT first_name, last_name
FROM employee
WHERE title="manager";
/* 11 */
SELECT product_type_cd
FROM product;
/* 12 */
SELECT AVG(avail_balance)
FROM account;
/* 13 */
SELECT MAX(avail_balance)
FROM account;
/* 14 */
SELECT MIN(avail_balance)
FROM account;
/* 15 */
SELECT COUNT(*)
FROM acc_transaction;
/* 16 */
SELECT COUNT(*)
FROM account;
/* 17 */
SELECT last_activity_date
FROM account;


