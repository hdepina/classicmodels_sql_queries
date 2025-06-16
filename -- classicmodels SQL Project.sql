-- classicmodels SQL Project

-- 1. Products not included in any order
SELECT p.productCode, p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;

-- 2. Identify Employees Who Have Sold to the Same Customer More Than Once
SELECT e.employeeNumber, c.customerName, COUNT(o.orderNumber) AS number_of_orders
FROM employees e
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON o.customerNumber = c.customerNumber
GROUP BY c.customerName, e.employeeNumber
HAVING number_of_orders > 1;

-- 3. Customers that purchased 1969 Harley Davidson Ultimate Chopper
SELECT COUNT(DISTINCT c.customerNumber) AS Customer_Count
FROM customers c
INNER JOIN orders o ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails ord ON ord.orderNumber = o.orderNumber
INNER JOIN products p ON p.productCode = ord.productCode
WHERE p.productName = '1969 Harley Davidson Ultimate Chopper'
ORDER BY c.customerNumber;

-- 4. Find Customers Who Have Placed Orders for at Least Three Different Product Lines
SELECT c.customerName, COUNT(DISTINCT p.productLine) AS orders_per_productline
FROM products p
JOIN orderdetails od ON od.productCode = p.productCode
JOIN orders o ON o.orderNumber = od.orderNumber
JOIN customers c ON c.customerNumber = o.customerNumber
GROUP BY c.customerName
HAVING orders_per_productline >= 3;

-- 5. Calculate the Percentage of Total Sales for Each Product Line
SELECT p.productLine, (COUNT(od.orderNumber) * 100) / (SELECT COUNT(o2.orderNumber) FROM orderdetails o2) AS percentage_sales
FROM products p
JOIN orderdetails od ON od.productCode = p.productCode
GROUP BY p.productLine;

-- 6. Count of Customer Orders
SELECT c.customerNumber, c.customerName, COUNT(*) AS Total
FROM customers c
INNER JOIN orders o ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails ord ON ord.orderNumber = o.orderNumber
INNER JOIN products p ON p.productCode = ord.productCode
GROUP BY c.customerNumber, c.customerName
ORDER BY c.customerNumber;
