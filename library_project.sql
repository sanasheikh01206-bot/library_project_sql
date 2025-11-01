select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from return_status;
select * from members;

-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee','J.B. Lippincott & Co.');

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 main st'
WHERE member_id = 'C101';

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.
delete from issued_status
where issued_id = 'IS104';

-- check the deleted record
select * from issued_status
where  issued_id = 'IS104';

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
select issued_book_name from issued_status
where issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.
select issued_emp_id,
count(issued_id) as id_count
from issued_status
group by issued_emp_id
having count(issued_id) > 1;

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
create table book_issued_cnt
as select b.isbn,
b.book_title,
count(s.issued_book_isbn)
from issued_status s join books b
on s.issued_book_isbn = b.isbn
group by b.isbn,b.book_title;

select * from book_issued_cnt;

-- Task 7. **Retrieve All Books in a Specific Category:
select * from books
where category = 'Classic';

-- Task 8: Find Total Rental Income by Category:
SELECT 
 b.category,
 SUM(b.rental_price),
 COUNT(*)
FROM 
issued_status as ist
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY 1;

-- Task 9. **List Members Who Registered in the Last 180 Days**:
select * from members 
where reg_date> current_date - interval '180 days';

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:
select
e1.emp_name,
e1.branch_id,
b.manager_id,
e2.emp_name as manager_name
from employees e1 join branch b
on e1.branch_id = b.branch_id
join employees e2 on 
b.manager_id = e2.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold
create table price_above_seven as 
select * from books 
where rental_price > 7;

-- check CTE 
select * from price_above_seven;


-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT * FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;





