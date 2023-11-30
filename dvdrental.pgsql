1. Identify the top 10 customers and their email so we can reward them
SELECT concat(first_name,' ',last_name) as fullname, customer.email, 
sum(payment.amount) as total_amount
FROM customer
INNER JOIN payment
ON customer.customer_id=payment.customer_id
GROUP BY 1,2 order by 3 desc
LIMIT 10;

2. Identify the bottom 10 customers and their emails
SELECT concat(first_name,' ',last_name) as fullname, customer.email, 
sum(payment.amount) as total_amount
FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY 1,2 order by 3 asc
LIMIT 10;

3. What are the most profitable movie genres (ratings)? 
select category.name as Genre, count(customer.customer_id) as total_demand,
sum(payment.amount) as total_amount
from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id=category.category_id
inner join inventory on film.film_id=inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
inner join customer on rental.customer_id = customer.customer_id
group by 1 order by 2 desc

4. How many rented movies were returned late, early, and on time?
select case
	   when rental_duration > date_part('day',return_date - rental_date) then 'Returned early'
	   when rental_duration = date_part('day',return_date - rental_date) then 'Returned on time'
	   else 'Returned Late'
	   end as Return_status, count(*) as total_film
	   from film
	   inner join inventory on film.film_id = inventory.film_id
	   inner join rental on inventory.inventory_id = rental.inventory_id
	   group by 1 order by 2 desc

5. What is the customer base in the countries where we have a presence?
select country, count(customer_id)as total_customer
from country
inner join city on country.country_id = city.country_id
inner join address  on city.city_id = address.city_id
inner join customer  on address.address_id = customer.address_id
group by 1 order by 2 desc limit 10

6. Which country is the most profitable for the business?
select country, count(customer.customer_id) total_customer, 
avg(film.rental_rate) as rental_rate, sum(payment.amount) as total_amount
from country
inner join city on country.country_id = city.country_id
inner join address  on city.city_id = address.city_id
inner join customer  on address.address_id = customer.address_id
inner join payment  on customer.customer_id = payment.customer_id
inner join rental  on payment.rental_id = rental.rental_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on inventory.film_id = film.film_id
group by 1 order by 2 desc limit 10

7. What is the average rental rate per movie genre (rating)?
select category.name as Genre, 
avg(film.rental_rate) as rental_rate
from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id=category.category_id
group by 1 order by 2 desc


