/*2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.*/
select title as peliculas_clasificacion_r
from film f  
where "rating" = 'R'
order by title asc; --195 resultados

/*3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.*/
select concat("first_name",' ',"last_name") as actores_id_30_40 --select "first_name"
from actor a 
where actor_id between 30 and 40
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
where "last_name" IN ('Allen');

/*7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.*/
select rating as clasificacion, count(film_id) as recuento
from film f  
group by rating;

/*8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.*/
select title as peliculas_pg13_o_mas_180
from film f  
where "rating" = 'PG-13' or "length" > 180;

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
where length > 180
and category_id = 5;

/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/
select name as categoria, avg(length) as promedio_duracion
from film f
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
group by name
having avg(length) > 110;

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
group by  concat("first_name", ' ',"last_name");

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
select concat("first_name", ' ',"last_name") as cliente_mas_gasta, sum (amount) as gasto
from customer c
inner join payment p
on c.customer_id = p.customer_id
group by concat("first_name", ' ',"last_name")
order by gasto limit 5;

/*35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.*/
select concat("first_name", ' ',"last_name") as actor_Johnny
from actor a
where "first_name" ILIKE ('JOHNNY');

/*36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.*/
select "first_name" as nombre, "last_name" as apellido
from actor a;

/*37. Encuentra el ID del actor más bajo y más alto en la tabla actor.*/
select max(actor_id) as maximo_id, min (actor_id) as minimo_id
from actor a;

 /*38. Cuenta cuántos actores hay en la tabla “actorˮ.*/
select count(actor_id) as numero_actores
from actor a;

 /*39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.*/
select concat("first_name",' ',"last_name") as nombre_actor
from actor a
order by last_name asc; 

/*40. Selecciona las primeras 5 películas de la tabla “filmˮ.*/
select title as pelicula
from film film 
order by film_id asc
limit 5;

/*41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?*/
select "first_name" as nombre, count(distinct(actor_id)) as cantidad_actores
from actor a
group by first_name
order by count(distinct(actor_id)) desc;
--Los nombres más repetidos son Penélope, Kenneth y Julia

/*42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.*/
select rental_id as alquiler, concat("first_name",' ',"last_name") as cliente
from rental r
inner join customer c
on r.customer_id = c.customer_id;

/*43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.*/
select concat("first_name",' ',"last_name") as cliente, rental_id as alquiler
from customer c
left join rental r
on c.customer_id = r.customer_id
order by concat("first_name",' ',"last_name");

/*44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/
select *
from film f
cross join category c;
--Esta consulta no tiene mucho sentido porque a cada film_id le corresponde una categoría única y determinada, asi que no nos aporta valor saber qué posibles combinaciones de categorías e id se pueden hacer...

/*45. Encuentra los actores que han participado en películas de la categoría 'Action'.*/
select concat("first_name",' ',"last_name") as actores_action
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id 
inner join film_category fc
on fa.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
where c.category_id = 1;

/*46. Encuentra todos los actores que no han participado en películas.*/
select concat("first_name",' ',"last_name") as actores_sin_pelicula
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
where film_id is null;

/*47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.*/
select concat("first_name",' ',"last_name") as actores, count(film_id) as numero_peliculas
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
group by concat("first_name",' ',"last_name");

/*48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.*/
create view actor_num_peliculas as
select concat("first_name",' ',"last_name") as actores, count(film_id) as numero_peliculas
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
group by concat("first_name",' ',"last_name");

select * from actor_num_peliculas;

/*49. Calcula el número total de alquileres realizados por cada cliente.*/
select concat("first_name",' ',"last_name") as nombre_cliente, count(rental_id) as num_alquileres
from customer c
inner join rental r
on c.customer_id = r.customer_id
group by concat("first_name",' ',"last_name");

/*50. Calcula la duración total de las películas en la categoría 'Action'.*/
select sum(length)
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id 
where c.category_id = 1;

/*51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.*/
create temporary table cliente_rentas_temporal as
select concat("first_name",' ',"last_name") as nombre_cliente, count(rental_id) as num_alquileres
from customer c
inner join rental r
on c.customer_id = r.customer_id
group by concat("first_name",' ',"last_name");

select * from cliente_rentas_temporal;

/*52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.*/
create temporary table peliculas_alquiladas as
select title as pelicula, count(rental_id) as num_alquileres
from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on r.inventory_id = i.inventory_id
group by title
having count(rental_id) >= 10;

select * from peliculas_alquiladas;

/*53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.*/
select title as pelicula_alquilada_TammySanders
from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on r.inventory_id = i.inventory_id
inner join customer c
on r.customer_id = c.customer_id
where c.customer_id in (select customer_id from customer c where "first_name" = 'TAMMY' and "last_name" = 'SANDERS')
order by title asc;

/*54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.*/
select distinct(concat("first_name",' ',"last_name")) as actores_SciFi
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join film_category fc
on fa.film_id =fc.film_id
inner join category c
on fc.category_id = c.category_id
where c.category_id = 14
order by concat("first_name",' ',"last_name") asc;

/*55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.*/
--Primero quiero saber qué fecha corresponde a la fecha en la que 'Spartacus Cheaper' se alquiló por primera vez
select min(rental_date)
from rental r
inner join inventory i
on r.inventory_id = i.inventory_id
inner join film f
on i.film_id = f.film_id
where f.title = 'SPARTACUS CHEAPER' --2005-07-08 06:43:42.000

--A continuación, busco los actores que han actuado en peliculas que se alquilaran posterior a la fecha 2005-07-08 06:43:42.000
select distinct(concat(a.first_name, ' ', a.last_name))
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join film f
on fa.film_id = f.film_id
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on i.inventory_id = r.inventory_id
where r.rental_date > '2005-07-08 06:43:42.000'
order by concat(a.first_name, ' ', a.last_name) asc; 

/*56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.*/
select category_id
from category c
where name = 'Music'; --consulta para saber qué categoría es 'Music'

select distinct(concat("first_name",' ',"last_name")) as actores_no_music
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join film_category fc
on fa.film_id =fc.film_id
inner join category c
on fc.category_id = c.category_id
where c.category_id <> 12;

/*57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.*/
select title
from film f
where rental_duration > 8;

/*58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.*/
select category_id
from category c
where name = 'Animation'; --consulta para saber qué categoría es 'Animation' --2

select title 
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
where c.category_id = 2;

/*59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.*/
select title 
from film f
where rental_duration = (select rental_duration from film f where title = 'DANCING FEVER')
order by title asc;

/*60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.*/
select c.first_name
from customer c
inner join rental r 
on c.customer_id = r.customer_id
group by c.first_name
having count(distinct r.rental_id) >= 7
order by first_name asc;

/*61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/
select c.name as categoria, count(distinct(r.rental_id)) as recuento_alquileres
from category c
inner join film_category fc
on c.category_id = fc.category_id
inner join film f
on fc.film_id = f.film_id
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on i.inventory_id = r.inventory_id
group by c.name;

/*62. Encuentra el número de películas por categoría estrenadas en 2006.*/
select c.name as categoria, count(distinct(f.film_id)) as peliculas_categoria_2006
from category c
inner join film_category fc
on c.category_id = fc.category_id
inner join film f
on fc.film_id = f.film_id
where f.release_year = 2006
group by c.name;

/*63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.*/
select *
from staff s 
cross join store ss;

/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/
select c.customer_id as IDCLIENTE, c.first_name as nombre, c.last_name as apellido, count(distinct(r.rental_id)) as recuento_alquileres
from customer c
inner join rental r
on c.customer_id = r.customer_id
group by c.customer_id;
