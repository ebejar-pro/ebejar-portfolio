-- adding a new column to sales table
alter table sales
add cost_amount real;

update sales
set cost_amount = sale_amount * 0.3;

update sales
set sales_person = trim(sales_person)
where length(sales_person) != length(trim(sales_person));

alter table sales
drop column costs_amount;

alter table sales_data
rename to sales;

insert into sales
    (sales_id, sales_person, sale_amount, sale_date)
values (11, 'Alice Kijo', 3000, '2023-05-28 11:00:55');

insert or ignore into sales
values(11,'Alice Kijo', 3000, '2023-05-28 11:00:55');

delete from sales
where sales_person = 'Peter Silo';

select 
    case 
        when exists (select 1 from sales
        where sales_person = 'Peter Silo')
        then 'Peter in the table'
        else 'Peter is not in the table'
    end as status_of_peter;
    

