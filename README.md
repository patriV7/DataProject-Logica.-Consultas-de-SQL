# DataProject-Logica.-Consultas-de-SQL
 📖 Descripción: Proyecto donde se aplican los conocimientos aprendidos en el módulo de SQL

/*1. Crea el esquema de la BBDD.*/
En primer lugar, una vez abierto DBeaver, para crear el esquema de la BBDD que he utilizado para este proyecto, dentro de Bases de Datos >> postgres >> Esquemas clico con el botón derecho y selecciono "Crear Nuevo Esquema". Le doy un nombre ("ProyectoLogicaSQL) y acepto. A continuación, establezco este nuevo esquema por defecto, clico botón derecho y selecciono "Editor SQL" >> "Script SQL", pego la información del fichero "BBDD_Proyecto", ejecuto el script y cuando refresco la información en mi base de datos de DBeaver ya tengo las tablas creadas.

/*2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.*/
select title as peliculas_clasificacion_r
from film f  
where "rating" = 'R'
order by title asc; --195 resultados

/*3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.*/
select concat("first_name",' ',"last_name") as actores_id_30_40 --select "first_name"
from actor a 
where actor_id between '30' and '40'
order by concat("first_name",' ',"last_name") asc; --11 resultados

/*4. Obtén las películas cuyo idioma coincide con el idioma original.*/
select title as pelicula_idioma_igual_original
from film f  
where "language_id" = "original_language_id"
order by title asc; 

/*5. Ordena las películas por duración de forma ascendente.*/
select title, length
from film f  
order by length asc;

/*6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.*/
select concat ("first_name",' ',"last_name") as actores_Allen
from actor
where "last_name" IN ('ALLEN');

/*7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.*/
select rating as clasificacion, count(film_id) as recuento
from film f  
group by rating;

/*8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.*/
select title as peliculas_pg13_o_mas_180
from film f  
where "rating" = 'PG-13' or "length" > '180';

/*9. Encuentra la variabilidad de lo que costaría reemplazar las películas.*/
select variance(replacement_cost ) as variabilidad_reemplazo
from film f ; 


/*10. Encuentra la mayor y menor duración de una película de nuestra BBDD.*/
select max(length) as maximo, min(length) as minimo
from film f  ;

/*11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.*/
select amount as coste_antepenultimo_alquiler
from payment 
order by payment_date desc
limit 1 offset 2;

/*12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC- 17ʼ ni ‘Gʼ en cuanto a su clasificación.*/
select title as peliculas_no_nc17_ni_g
from film f 
where "rating" not in ('NC-17','G');

/*13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.*/
select rating as clasificacion, AVG(length) as promedio_duracion
from film f 
group by "rating";

/*14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.*/
select title as peliculas_duracion_mayor_180
from film f 
where "length" > 180;

/*15. ¿Cuánto dinero ha generado en total la empresa?*/
select sum(amount) as dinero_total
from payment p;

/*16. Muestra los 10 clientes con mayor valor de id.*/
select first_name as cliente_mayor_id
from customer c
order by customer_id desc
limit 10

/*17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.*/
select concat(a."first_name",' ',a."last_name") as actores_egg_igby
from actor as a
inner join film_actor as f
on a.actor_id = f.actor_id
inner join film as f2
on f.film_id = f2.film_id
where f2.title = 'EGG IGBY';

/*18. Selecciona todos los nombres de las películas únicos.*/
select distinct(title) as nombres_unicos
from film f ;

/*19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.*/
select title as comedias_mas_180
from film f
inner join film_category fc 
on f.film_id = fc.film_id
where length > '180'
and category_id = '5';

/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/
select name as categoria, avg(length) as promedio_duracion
from film f
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where length > '110'
group by c."name" ;

 /*21. ¿Cuál es la media de duración del alquiler de las películas?*/
SELECT AVG(return_date - rental_date) AS media_duracion
FROM rental r;

 /*22. Crea una columna con el nombre y apellidos de todos los actores y actrices.*/
SELECT concat("first_name",' ',"last_name") as nombre_completo
FROM actor a;

 /*23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.*/
select count(rental_id) as numero_alquiler, rental_date as fecha
from rental r 
group by rental_date
order by count(rental_id) desc;

 /*24. Encuentra las películas con una duración superior al promedio.*/
SELECT title as peliculas_duracion_superior_promedio
FROM film
WHERE length > (select avg(length) from film);

 /*25. Averigua el número de alquileres registrados por mes.*/
SELECT extract(month from rental_date) as mes, count(rental_id) as cantidad_alquileres
FROM rental
group by mes;

 /*26. Encuentra el promedio, la desviación estándar y varianza del total pagado.*/
select avg(amount) as promedio, stddev(amount)as desviacion_estandar, variance(amount) as varianza
from payment p ;

 /*27. ¿Qué películas se alquilan por encima del precio medio?*/
select f.title as peliculas_alquiler_superior_media
from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on r.inventory_id = i.inventory_id
inner join payment p 
on r.rental_id = p.rental_id
where amount > (select avg(amount) from payment)
group by f."title" ;

/*28. Muestra el id de los actores que hayan participado en más de 40 películas.*/
select actor_id, count(film_id) as numero_peliculas
from film_actor fa 
group by actor_id
having count(film_id) > 40;

/*29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.*/
select title as pelicula, count(inventory_id) as cantidad_disponible
from inventory i
inner join film f
on f.film_id = i.film_id
group by title;

/*30. Obtener los actores y el número de películas en las que ha actuado.*/
select concat("first_name", ' ',"last_name") as actor, count(film_id) as numero_peliculas
from film_actor fa
inner join actor a
on fa.actor_id = a.actor_id
group by a.actor_id;

/*31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.*/
select title as pelicula, concat("first_name", ' ',"last_name") as actores_que_participan
from film_actor fa
left join actor a
on fa.actor_id = a.actor_id
left join film f
on f.film_id = fa.film_id
order by title;

/*32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.*/
select concat("first_name", ' ',"last_name") as actores_que_participan, title as pelicula
from actor a
left join film_actor fa
on fa.actor_id = a.actor_id
left join film f
on f.film_id = fa.film_id
order by concat("first_name", ' ',"last_name");

/*33. Obtener todas las películas que tenemos y todos los registros de alquiler.*/
select title as pelicula, rental_id as registro_alquiler
from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on r.inventory_id = i.inventory_id;

/*34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/
select concat("first_name", ' ',"last_name") as cliente_mas_gasta
from customer c
inner join payment p
on c.customer_id = p.customer_id
order by amount desc limit 5;

/*35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.*/
select concat("first_name", ' ',"last_name") as actor_Johnny
from actor a
where "first_name" in ('JOHNNY');

/*36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.*/
select "first_name" as nombre, "last_name" as apellido
from actor a;

