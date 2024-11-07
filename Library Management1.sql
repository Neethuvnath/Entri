CREATE DATABASE library11;
USE library11;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(100),
    Contact_no VARCHAR(15)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, 'Main Branch, Kochi', '1234567890'),
(2, 102, 'North Branch, Palakad', '2345678901'),
(3, 103, 'South Branch, Trivandrum', '3456789012'),
(4, 104, 'Central Branch, Midtown Trivandrum', '6789012345'),
(5, 105, 'North-East Branch, Kotayam', '7890123456'),
(6, 101, 'Main Branch, Trivandrum', '6262626262'),
(7, 102, 'North Branch, Kasaragod', '1234569877'),
(8, 103, 'South Branch, Kollam', '4444555693'),
(9, 104, 'Central Branch, Kochi', '8888777952'),
(10, 105, 'North-East Branch, Kotayam', '8596789452');

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1011, 'Neethu V Nath', 'Manager', 75000, 1),
(1012, 'Kavitha T R', 'Manager', 78000, 2),
(1013, 'Anil Kumar', 'Manager', 76000, 3),
(1014, 'Sheeja M', 'Assistant', 45000, 4),
(1015, 'Mini Jose', 'Clerk', 40000, 5),
(1016, 'Bhavya J N', 'Clerk', 42000, 1),
(1017, 'Jithin R', 'Librarian', 52000, 1),
(1018, 'Eve Davis', 'Manager', 69000, 5),
(1019, 'Frank Miller', 'Manager', 71000, 6),
(1020, 'Grace Lee', 'Manager', 76000, 7),
(1021, 'Hank Kim', 'Manager', 73000, 8),
(2022, 'Ivy Clark', 'Assistant Librarian', 45000, 1),
(2023, 'Jack Evans', 'Assistant Librarian', 46000, 2);

CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);


INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
(1001, 'Introduction to Computer Science', 'Education', 30, 'Yes', 'James Gosling', 'TechBooks Publishing'),
(1002, 'History of the World', 'History', 40, 'Yes', 'Will Durant', 'WorldPress'),
(1003, 'Basic Mathematics', 'Education', 25, 'No', 'John Doe', 'MathPub'),
(1004, 'The Great Gatsby', 'Literature', 35, 'Yes', 'F. Scott Fitzgerald', 'ClassicPress'),
(1005, 'Python Programming', 'Education', 50, 'No', 'Guido van Rossum', 'CodeBooks'),
(1006, 'Modern Art Explained', 'Art', 20, 'Yes', 'Sarah Green', 'ArtWorld'),
(1007, 'Quantum Physics', 'Science', 45, 'No', 'Richard Feynman', 'ScienceHub'),
(1008, 'History of Art', 'History', 30, 'Yes', 'Ernst Gombrich', 'ArtBooks');


CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_address VARCHAR(100),
    Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'Shan', 'Trivandrum', '2022-05-15'),
(202, 'Riya', 'Trivandrum', '2023-01-20'),
(203, 'Jeni', 'Kollam', '2023-04-10'),
(204, 'Dayan', 'Trivandrum', '2021-12-05'),
(205, 'Noble Mathew', 'Palakad', '2021-08-19'),
(206, 'Sophia', 'Trivandrum', '2021-08-19'),
(207, 'Sunitha', 'Kochi', '2022-02-10'),
(208, 'Emma', 'Kotayam', '2023-05-15'),
(209, 'Iva', 'Kollam', '2023-03-05');


CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(501, 201, 'Introduction to Computer Science', '2023-06-15', 1001),
(502, 202, 'The Great Gatsby', '2023-06-20', 1004),
(503, 203, 'Modern Art Explained', '2023-06-25', 1006),
(504, 204, 'History of the World', '2023-05-30', 1002),
(505, 205, 'History of Art', '2023-06-15', 1008),
(506, 206, 'Python Programming', '2023-06-20', 1005),
(507, 207, 'Modern Art Explained', '2023-06-25', 1006),
(508, 208, 'Quantum Physics', '2023-05-30', 1007);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(401, 201, 'Introduction to Computer Science', '2023-07-15', 1001),
(402, 202, 'The Great Gatsby', '2023-07-20', 1004),
(403, 203, 'Modern Art Explained', '2023-07-25', 1006),
(404, 204, 'History of the World', '2023-06-30', 1002);

/*1. Retrieve the book title, category, and rental price of all available books.*/

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'Yes';

/*2. List the employee names and their respective salaries in descending order of salary.*/

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

/*3. Retrieve the book titles and the corresponding customers who have issued those books.*/

SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

/*4. Display the total count of books in each category.*/

SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

/*5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. */

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

/*6. List the customer names who registered before 2022-01-01 and have not issued any books yet. */

SELECT Customer.Customer_name
FROM Customer
LEFT JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Customer.Reg_date < '2022-01-01' AND IssueStatus.Issue_Id IS NULL;

/*7. Display the branch numbers and the total count of employees in each branch.*/

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

/*8. Display the names of customers who have issued books in the month of June 2023.*/

SELECT Customer.Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

/*9. Retrieve book_title from book table containing history.*/

SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

/*10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees*/

SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING Employee_Count > 5;

/*11. Retrieve the names of employees who manage branches and their respective branch addresses. */

SELECT Employee.Emp_name, Branch.Branch_address
FROM Branch
JOIN Employee ON Branch.Manager_Id = Employee.Emp_Id;

/*12. Display the names of customers who have issued books with a rental price higher than Rs. 25. this should be work using my sql work bench*/
SELECT Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;














