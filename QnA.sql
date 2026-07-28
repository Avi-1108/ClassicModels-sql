-- 1.List the customers in the United States with a credit limit higher than \$1000.
SELECT * FROM customers
WHERE country = 'USA' AND creditLimit > 1000;

-- 2.List the employee codes for sales representatives of customers in Spain, France and Italy. 
--   - Make another query to list the names and email addresses of those employees.
SELECT DISTINCT salesRepEmployeeNumber, e.firstname, e.lastname, e.email FROM customers c
JOIN Employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE country IN('Spain', 'France', 'Italy');

-- 3.Change the job title "Sales Rep" to "Sales Representative"
UPDATE Employees
SET jobTitle = "Sales Representative" WHERE jobTitle = "Sales Rep";

-- 4.Delete the entries for Sales Representatives working in London.
DELETE e FROM employees e
JOIN (SELECT officeCode FROM Offices WHERE city = "London") AS t
ON e.officeCode = t.officeCode;

-- 5.Show a list of employees who are not sales representatives
SELECT * FROM Employees
WHERE jobTitle <> "Sales Representative";

-- 6.Show a list of customers with "Toys" in their name
SELECT * FROM Customers
WHERE customerName LIKE '%toys%';

-- 7.List the 5 most expensive products from the "Planes" product line
SELECT * FROM products
WHERE productline = 'Planes'
ORDER BY buyprice DESC LIMIT 5;

-- 8.Identify the products that are about to run out of stock (quantity in stock < 100)
SELECT * FROM products
WHERE quantityInStock < 100;

-- 9.List 10 products in the "Motorcycles" category with the lowest buy price and more than 1000 units in stock
SELECT * FROM products
WHERE productLine = "Motorcycles" AND quantityInStock > 1000
ORDER BY buyPrice ASC LIMIT 10;

-- 10.Prepare a list of offices sorted by country, state, city.
SELECT * FROM Offices
ORDER BY country, state, city;

-- 11.How many employees are there in the company?
SELECT COUNT(employeeNumber) FROM Employees;

-- 12.What is the total of payments received?
SELECT SUM(amount) AS Amount_received FROM Payments;

-- 13.List the product lines that contain 'Cars'.
SELECT * FROM Products
WHERE productLine LIKE '%Car%';

-- 14.Report total payments for October 28, 2004.
SELECT SUM(amount) FROM payments
WHERE paymentdate = "2004-10-28";

-- 15.Report those payments greater than \$100,000.
SELECT * FROM payments
WHERE amount > 100000;

-- 16.List the products in each product line.
SELECT * FROM products
ORDER BY productline;

-- 17.How many products in each product line?
SELECT COUNT(ProductCode) AS products, productline FROM products
GROUP BY productline;

-- 18.What is the minimum payment received?
SELECT MIN(amount) AS min_amount FROM payments;

-- 19.List all payments greater than twice the average payment.
SELECT * FROM payments
WHERE amount > (
SELECT 2*AVG(amount) FROM payments
);

-- 20.How many distinct products does ClassicModels sell?
SELECT COUNT(DISTINCT productname) AS total_product FROM products
WHERE productline LIKE "%Classic%";

-- 21.Report the name and city of customers who don't have sales representatives?
SELECT customername,city FROM customers
WHERE salesRepEmployeeNumber IS NULL;

-- 22.Which orders have a value greater than $5,000?
SELECT ordernumber, SUM(quantityordered*priceEach) AS value FROM OrderDetails
GROUP BY ordernumber
HAVING value > 5000;

-- 23.What are the names of executives with VP or Manager in their title? Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.
SELECT CONCAT(firstname," ",lastname ) AS fullname, jobtitle FROM Employees
WHERE jobtitle LIKE "%VP%" OR jobtitle LIKE "%manager%";

-- 24.Report the total number of payments received before October 28, 2004.
SELECT COUNT(checknumber) FROM payments
WHERE paymentdate < "2004-10-28";

-- 25.Report the number of customers who have made payments before October 28, 2004.
SELECT COUNT(DISTINCT customernumber) AS total_customer FROM payments
WHERE paymentdate < "2004-10-28";

-- 26.Retrieve the list of customer numbers for customers who have made a payment before October 28, 2004.
SELECT DISTINCT customernumber FROM payments
WHERE paymentdate < "2004-10-28";

-- 27.Retrieve details of all the customers in the United States who have made payments between April 1st 2003 and March 31st 2004.
SELECT * FROM customers c 
JOIN payments p USING(customernumber)
WHERE p.paymentdate BETWEEN "2003-04-01" AND "2004-03-31" AND country = "USA";

-- 28.Find the total number of payments made by each customer before October 28, 2004.
SELECT customernumber, COUNT(checknumber) AS total_payments FROM payments
WHERE paymentdate < "2004-10-28"
GROUP BY customernumber;

-- 29.Find the total amount paid by each customer payment before October 28, 2004.
SELECT customernumber, SUM(Amount) AS total_amount FROM payments
WHERE paymentdate < "2004-10-28"
GROUP BY customernumber;

-- 30.Determine the total number of units sold for each product
SELECT productcode, productname, SUM(quantityordered) AS total_quantity FROM orderdetails od
JOIN products p USING(productcode)
GROUP BY productcode, productname;

-- 31.Find the total no. of payments and total payment amount for each customer for payments made before October 28, 2004.
SELECT customernumber, COUNT(checknumber) AS number_of_payment, SUM(amount) AS total_payment FROM payments
WHERE paymentdate < "2004-10-28"
GROUP BY customernumber;

-- 32.Modify the above query to also show the minimum, maximum and average payment value for each customer.
SELECT customernumber, COUNT(checknumber) AS number_of_payment, SUM(amount) AS total_payment ,MIN(amount) AS min_payment, MAX(amount) AS max_payment, AVG(amount) AS avg_payment FROM payments
WHERE paymentdate < "2004-10-28"
GROUP BY customernumber;

-- 33.List the largest single payment done by every customer in the year 2004, ordered by the transaction value (highest to lowest).
SELECT customernumber, MAX(amount) AS largest_payment FROM payments
WHERE YEAR(paymentdate) = 2004
GROUP BY customernumber
ORDER BY largest_payment DESC;

-- 34.Show the total payments received month by month for every year.
SELECT YEAR(paymentdate) AS year, MONTH(paymentdate) AS month, SUM(amount) AS payments FROM payments
GROUP BY year,month
ORDER BY year ASC, month ASC;