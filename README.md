# DataProject-Logica.-Consultas-de-SQL
Proyecto donde se aplican los conocimientos aprendidos en el módulo de SQL

1. Crea el esquema de la BBDD.
En primer lugar, una vez abierto DBeaver, para crear el esquema de la BBDD que he utilizado para este proyecto, dentro de Bases de Datos >> postgres >> Esquemas clico con el botón derecho y selecciono "Crear Nuevo Esquema". Le doy un nombre ("ProyectoLogicaSQL) y acepto. A continuación, establezco este nuevo esquema por defecto, clico botón derecho y selecciono "Editor SQL" >> "Script SQL", pego la información del fichero "BBDD_Proyecto", ejecuto el script y cuando refresco la información en mi base de datos de DBeaver ya tengo las tablas creadas.

2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
select title
from film f  
where "rating" = 'R'
order by title asc; 

3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
select concat("first_name",' ',"last_name") --select "first_name"
from actor a 
where actor_id between '30' and '40'
order by concat("first_name",' ',"last_name") asc; 

4. Obtén las películas cuyo idioma coincide con el idioma original.
select title
from film f  
where "language_id" = "original_language_id"
order by title asc;

5. Ordena las películas por duración de forma ascendente.
select title, length --select *
from film f  
order by length asc;

6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
select concat ("first_name",' ',"last_name")
from actor
where "last_name" in ('ALLEN');

7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
select rating, count(film_id)
from film f  
group by rating;

8.  Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
select title
from film f  
where "rating" = 'PG-13' or "length" > '180';

9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select variance(replacement_cost )
from film f ;

10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max(length), min(length)
from film f  ;

11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select amount 
from payment 
order by payment_date desc
limit 1 offset 2;

13. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC- 17ʼ ni ‘Gʼ en cuanto a su clasificación.
select title
from film f 
where "rating" not in ('NC-17','G');

14. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select rating, AVG(length)
from film f 
group by "rating";

15. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title
from film f 
where "length" > 180;

16. ¿Cuánto dinero ha generado en total la empresa?
select sum(amount) as dinero_total
from payment p;

17. Muestra los 10 clientes con mayor valor de id.
select first_name --select *
from customer c
order by customer_id desc
limit 10

18. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
select concat(a."first_name",' ',a."last_name") 
from actor as a
inner join film_actor as f
on a.actor_id = f.actor_id
inner join film as f2
on f.film_id = f2.film_id
where f2.title = 'EGG IGBY';


