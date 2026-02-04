CREATE DATABASE IF NOT EXISTS mental_social_health;

USE mental_social_health;



-- H1 Comportamiento digital según país y género

WITH USA_data as (
	SELECT 
	CASE 
		WHEN age BETWEEN 18 and 24 THEN 'Jóvenes 18-24'
        WHEN age BETWEEN 25 and 34 THEN 'Adultos Jóvenes 25-34'
		WHEN age BETWEEN 35 and 44 THEN 'Adultos 35-44'
		WHEN age BETWEEN 45 and 54 THEN 'Mediana edad 45-54'
		WHEN age BETWEEN 55 and 65 THEN 'Adultos mayores 55-65'
		ELSE '-18 o +65'
		END AS edades,
        gender,
		
	ROUND(AVG (posts_created_per_week), 2) as post_semanales,
	ROUND(AVG (reels_watched_per_day), 2) as reels_por_dia,
	ROUND(AVG (stories_viewed_per_day), 2) as stories_por_dia,
	ROUND(AVG (likes_given_per_day), 2) as likes_por_dia,
	ROUND(AVG (comments_written_per_day), 2) as comentarios_por_dia,
	ROUND(AVG (ads_viewed_per_day), 2) as ads_por_dia,
	ROUND(AVG (daily_active_minutes_instagram), 2) as minutos_diarios_ig,
	ROUND(AVG (time_on_feed_per_day), 2) as tiempo_en_feed,
	ROUND(AVG (time_on_reels_per_day), 2) as tiempo_en_reels
	FROM tabla_ig
	WHERE country = 'USA'
	GROUP BY 
	country, 
	edades,
    gender
), 
UK_data as (
SELECT 
	CASE 
		WHEN age BETWEEN 18 and 24
		  THEN 'Jóvenes 18-24'
		WHEN age BETWEEN 25 and 34
		  THEN 'Adultos Jóvenes 25-34'
		WHEN age BETWEEN 35 and 44
		  THEN 'Adultos 35-44'
		WHEN age BETWEEN 45 and 54
		  THEN 'Mediana edad 45-54'
		WHEN age BETWEEN 55 and 65
		  THEN 'Adultos mayores 55-65'
		ELSE '-18 o +65'
		END AS edades,
        gender,
		
	ROUND(AVG (posts_created_per_week), 2) as post_semanales,
	ROUND(AVG (reels_watched_per_day), 2) as reels_por_dia,
	ROUND(AVG (stories_viewed_per_day), 2) as stories_por_dia,
	ROUND(AVG (likes_given_per_day), 2) as likes_por_dia,
	ROUND(AVG (comments_written_per_day), 2) as comentarios_por_dia,
	ROUND(AVG (ads_viewed_per_day), 2) as ads_por_dia,
	ROUND(AVG (daily_active_minutes_instagram), 2) as minutos_diarios_ig,
	ROUND(AVG (time_on_feed_per_day), 2) as tiempo_en_feed,
	ROUND(AVG (time_on_reels_per_day), 2) as tiempo_en_reels
	FROM tabla_ig
	WHERE country = 'UK'
	GROUP BY 
	country, 
	edades,
    gender
) 
SELECT 
	uk.edades,
    uk.gender,
    uk.likes_por_dia - usa.likes_por_dia as diff_likes_por_dia,
    usa.likes_por_dia as usa_likes,
    uk.likes_por_dia as uk_likes
FROM UK_data uk
INNER JOIN USA_data usa ON uk.edades = usa.edades AND uk.gender = usa.gender
WHERE uk.gender != 'Prefer not to say'
ORDER BY 
uk.gender;


/* En esta última consulta podemos seleccionar lo que queremos mirar más en detalle, 
si la quiero completa, la de abajo: */

WITH USA_data AS (
    SELECT 
        CASE 
            WHEN age BETWEEN 18 AND 24 THEN 'Jóvenes 18-24'
            WHEN age BETWEEN 25 AND 34 THEN 'Adultos Jóvenes 25-34'
            WHEN age BETWEEN 35 AND 44 THEN 'Adultos 35-44'
            WHEN age BETWEEN 45 AND 54 THEN 'Mediana edad 45-54'
            WHEN age BETWEEN 55 AND 65 THEN 'Adultos mayores 55-65'
            ELSE '-18 o +65'
        END AS edades,
        gender,
        AVG(posts_created_per_week) as posts,
        AVG(reels_watched_per_day) as reels,
        AVG(stories_viewed_per_day) as stories,
        AVG(likes_given_per_day) as likes,
        AVG(comments_written_per_day) as comentarios,
        AVG(ads_viewed_per_day) as ads,
        AVG(daily_active_minutes_instagram) as mins_ig,
        AVG(time_on_feed_per_day) as t_feed,
        AVG(time_on_reels_per_day) as t_reels
    FROM tabla_ig
    WHERE country = 'USA' AND gender != 'Prefer not to say'
    GROUP BY edades, gender
),
UK_data AS (
    SELECT 
        CASE 
            WHEN age BETWEEN 18 AND 24 THEN 'Jóvenes 18-24'
            WHEN age BETWEEN 25 AND 34 THEN 'Adultos Jóvenes 25-34'
            WHEN age BETWEEN 35 AND 44 THEN 'Adultos 35-44'
            WHEN age BETWEEN 45 AND 54 THEN 'Mediana edad 45-54'
            WHEN age BETWEEN 55 AND 65 THEN 'Adultos mayores 55-65'
            ELSE '-18 o +65'
        END AS edades,
        gender,
        AVG(posts_created_per_week) as posts,
        AVG(reels_watched_per_day) as reels,
        AVG(stories_viewed_per_day) as stories,
        AVG(likes_given_per_day) as likes,
        AVG(comments_written_per_day) as comentarios,
        AVG(ads_viewed_per_day) as ads,
        AVG(daily_active_minutes_instagram) as mins_ig,
        AVG(time_on_feed_per_day) as t_feed,
        AVG(time_on_reels_per_day) as t_reels
    FROM tabla_ig
    WHERE country = 'UK' AND gender != 'Prefer not to say'
    GROUP BY edades, gender
)
SELECT 
    uk.edades,
    uk.gender,
    ROUND(uk.likes - usa.likes, 2) as diff_likes,
    ROUND(uk.posts - usa.posts, 2) as diff_posts,
    ROUND(uk.reels - usa.reels, 2) as diff_reels,
    ROUND(uk.mins_ig - usa.mins_ig, 2) as diff_minutos_totales,
    ROUND(uk.t_feed - usa.t_feed, 2) as diff_tiempo_feed,
    ROUND(uk.t_reels - usa.t_reels, 2) as diff_tiempo_reels,
    ROUND(usa.mins_ig, 2) as usa_avg_mins,
    ROUND(uk.mins_ig, 2) as uk_avg_mins
FROM UK_data uk
INNER JOIN USA_data usa ON uk.edades = usa.edades AND uk.gender = usa.gender
ORDER BY uk.edades, uk.gender;


-- H2 - Salud mental según país y género
WITH USA_mentaldata as (
	SELECT 
	CASE 
		WHEN age BETWEEN 18 and 24
		  THEN 'Jóvenes 18-24'
		WHEN age BETWEEN 25 and 34
		  THEN 'Adultos Jóvenes 25-34'
		WHEN age BETWEEN 35 and 44
		  THEN 'Adultos 35-44'
		WHEN age BETWEEN 45 and 54
		  THEN 'Mediana edad 45-54'
		WHEN age BETWEEN 55 and 65
		  THEN 'Adultos mayores 55-65'
		ELSE '-18 o +65'
		END AS edades,
        gender,
		
	ROUND(AVG (feeling_worthless), 2) as media_sentirse_insuficiente,
	ROUND(AVG (concentration_difficulty), 2) as media_dificultad_concentracion,
	ROUND(AVG (panic_attacks), 2) as media_ataques_panico,
	ROUND(AVG (mood_swings), 2) as media_cambios_humor,
	ROUND(AVG (obsessive_thoughts), 2) as media_pensamientos_obsesivos,
	ROUND(AVG (self_harm_thoughts), 2) as media_pensamientos_autolesiones,
    ROUND(AVG (suicidal_thoughts), 2) as media_pensamientos_suicidas,
	ROUND(AVG (social_support), 2) as media_soporte_social,
	ROUND(AVG (feel_understood), 2) as media_sentirse_comprendidos,
	ROUND(AVG (loneliness), 2) as media_sentirse_solos,
    ROUND(AVG (discuss_mental_health), 2) as media_hablar_salud_mental
	FROM tabla_mh
	WHERE country = 'USA'
	GROUP BY 
	country, 
	edades,
    gender
),
UK_mentaldata as (
SELECT 
	CASE
		WHEN age BETWEEN 18 and 24
		  THEN 'Jóvenes 18-24'
		WHEN age BETWEEN 25 and 34
		  THEN 'Adultos Jóvenes 25-34'
		WHEN age BETWEEN 35 and 44
		  THEN 'Adultos 35-44'
		WHEN age BETWEEN 45 and 54
		  THEN 'Mediana edad 45-54'
		WHEN age BETWEEN 55 and 65
		  THEN 'Adultos mayores 55-65'
		ELSE '-18 o +65'
		END AS edades,
        gender,
		ROUND(AVG (feeling_worthless), 2) as media_sentirse_insuficiente,
		ROUND(AVG (concentration_difficulty), 2) as media_dificultad_concentracion,
		ROUND(AVG (panic_attacks), 2) as media_ataques_panico,
		ROUND(AVG (mood_swings), 2) as media_cambios_humor,
		ROUND(AVG (obsessive_thoughts), 2) as media_pensamientos_obsesivos,
		ROUND(AVG (self_harm_thoughts), 2) as media_pensamientos_autolesiones,
		ROUND(AVG (suicidal_thoughts), 2) as media_pensamientos_suicidas,
		ROUND(AVG (social_support), 2) as media_soporte_social,
		ROUND(AVG (feel_understood), 2) as media_sentirse_comprendidos,
		ROUND(AVG (loneliness), 2) as media_sentirse_solos,
		ROUND(AVG (discuss_mental_health), 2) as media_hablar_salud_mental
	FROM tabla_mh
	WHERE country = 'UK'
	GROUP BY
	edades,
    gender
)
SELECT 
	uk.edades,
    uk.gender,
    uk.media_sentirse_insuficiente - usa.media_sentirse_insuficiente as diff_media_sentirse_insuficiente,
    usa.media_sentirse_insuficiente as usa_media_sentirse_insuficiente,
    uk.media_sentirse_insuficiente as uk_media_sentirse_insuficiente
FROM UK_mentaldata uk
INNER JOIN USA_mentaldata usa ON uk.edades = usa.edades AND uk.gender = usa.gender
WHERE uk.gender != 'Prefer not to say'
ORDER BY 
uk.gender;

/* Para consultas individuales */

-- 3:  ¿Existe correlación entre comportamiento digital y salud mental? 
WITH ig_agg_correlacion as (
    SELECT 
        country,
        gender,
        CASE 
            WHEN age BETWEEN 18 AND 24 THEN 'Jóvenes 18-24'
            WHEN age BETWEEN 25 AND 34 THEN 'Adultos Jóvenes 25-34'
            WHEN age BETWEEN 35 AND 44 THEN 'Adultos 35-44'
            WHEN age BETWEEN 45 AND 54 THEN 'Mediana edad 45-54'
            WHEN age BETWEEN 55 AND 65 THEN 'Adultos mayores 55-65'
            ELSE '-18 o +65'
        END AS edades,
        AVG(daily_active_minutes_instagram) as media_mins_ig,
        AVG(reels_watched_per_day) as media_reels,
        AVG(likes_given_per_day) as media_likes
    FROM tabla_ig
    WHERE gender != 'Prefer not to say'
    GROUP BY country, gender, edades
),
mh_agg_correlacion as (
    SELECT 
        country,
        gender,
        CASE 
            WHEN age BETWEEN 18 AND 24 THEN 'Jóvenes 18-24'
            WHEN age BETWEEN 25 AND 34 THEN 'Adultos Jóvenes 25-34'
            WHEN age BETWEEN 35 AND 44 THEN 'Adultos 35-44'
            WHEN age BETWEEN 45 AND 54 THEN 'Mediana edad 45-54'
            WHEN age BETWEEN 55 AND 65 THEN 'Adultos mayores 55-65'
            ELSE '-18 o +65'
        END AS edades,
        AVG(feeling_worthless) as media_insuficiencia,
        AVG(loneliness) as media_soledad,
        AVG(panic_attacks) as media_panico,
        AVG(suicidal_thoughts) as media_pensamientos_criticos
    FROM tabla_mh
    WHERE gender != 'Prefer not to say'
    GROUP BY country, gender, edades
)
SELECT 
    igco.country,
    igco.gender,
    igco.edades,
    ROUND(igco.media_mins_ig, 2) as mins_ig,
    ROUND(igco.media_reels, 2) as reels_vistos,
    ROUND(mhco.media_insuficiencia, 2) as nota_insuficiencia,
    ROUND(mhco.media_soledad, 2) as nota_soledad,
    ROUND(mhco.media_panico, 2) as media_panico
FROM ig_agg_correlacion igco
INNER JOIN mh_agg_correlacion mhco
    ON igco.country = mhco.country 
    AND igco.gender = mhco.gender 
    AND igco.edades = mhco.edades;

-- 3.1 Consumo pasivo vs. aislamiento: ¿A más contenido visto mayor sentimiento de soledad, comprensión y concentración?
WITH tabla_mh_agg as (
	SELECT
		CASE
				WHEN age BETWEEN 18 and 24
				  THEN 'Jóvenes 18-24'
				WHEN age BETWEEN 25 and 34
				  THEN 'Adultos Jóvenes 25-34'
				WHEN age BETWEEN 35 and 44
				  THEN 'Adultos 35-44'
				WHEN age BETWEEN 45 and 54
				  THEN 'Mediana edad 45-54'
				WHEN age BETWEEN 55 and 65
				  THEN 'Adultos mayores 55-65'
				ELSE '-18 o +65'
				END AS edades,
		gender, 
        ROUND(AVG(loneliness), 2) as soledad,
        ROUND(AVG(feel_understood), 2) as comprension,
        ROUND(AVG(concentration_difficulty), 2) as concentracion
	FROM tabla_mh
	GROUP BY 1,2
),
tabla_ig_agg as (
	SELECT
		CASE
				WHEN age BETWEEN 18 and 24
				  THEN 'Jóvenes 18-24'
				WHEN age BETWEEN 25 and 34
				  THEN 'Adultos Jóvenes 25-34'
				WHEN age BETWEEN 35 and 44
				  THEN 'Adultos 35-44'
				WHEN age BETWEEN 45 and 54
				  THEN 'Mediana edad 45-54'
				WHEN age BETWEEN 55 and 65
				  THEN 'Adultos mayores 55-65'
				ELSE '-18 o +65'
				END AS edades,
		gender, 
        AVG((reels_watched_per_day)+(stories_viewed_per_day)) as media_contenido_visto
	FROM tabla_ig
	GROUP BY 1,2
)
SELECT  
	mh.edades, 
	mh.gender, 
	mh.soledad,
    mh.comprension,
    mh.concentracion,
    ROUND(media_contenido_visto / 60, 2) as horas_vistas
FROM tabla_mh_agg mh
INNER JOIN tabla_ig_agg ig ON mh.edades = ig.edades AND mh.gender = ig.gender
WHERE mh.gender != 'Prefer not to say'
ORDER BY
gender
;


-- 4  Falsa conexión social: ¿Sentimos que tenemos pocos amigos o poco apoyo social según nuuestros índices de interacciones o seguidores?
WITH tabla_mh_agg2 as (
	SELECT
		CASE
				WHEN age BETWEEN 18 and 24
				  THEN 'Jóvenes 18-24'
				WHEN age BETWEEN 25 and 34
				  THEN 'Adultos Jóvenes 25-34'
				WHEN age BETWEEN 35 and 44
				  THEN 'Adultos 35-44'
				WHEN age BETWEEN 45 and 54
				  THEN 'Mediana edad 45-54'
				WHEN age BETWEEN 55 and 65
				  THEN 'Adultos mayores 55-65'
				ELSE '-18 o +65'
				END AS edades,
		gender, 
        ROUND(AVG(close_friends_count), 2) as amigos,
        ROUND(AVG(social_support), 2) as apoyo_social
	FROM tabla_mh
	GROUP BY 1,2
),
tabla_ig_agg2 as (
	SELECT
		CASE
				WHEN age BETWEEN 18 and 24
				  THEN 'Jóvenes 18-24'
				WHEN age BETWEEN 25 and 34
				  THEN 'Adultos Jóvenes 25-34'
				WHEN age BETWEEN 35 and 44
				  THEN 'Adultos 35-44'
				WHEN age BETWEEN 45 and 54
				  THEN 'Mediana edad 45-54'
				WHEN age BETWEEN 55 and 65
				  THEN 'Adultos mayores 55-65'
				ELSE '-18 o +65'
				END AS edades,
		gender, 
        AVG((likes_given_per_day)+(comments_written_per_day)) as media_interaccion,
        AVG((followers_count)+(following_count)) as media_amigos
	FROM tabla_ig
	GROUP BY 1,2
)
SELECT  
	mh.edades, 
	mh.gender, 
	mh.apoyo_social,
    mh.amigos,
    ROUND(media_interaccion, 2) as interacciones_medias,
    ROUND(media_amigos, 2) as following_media
FROM tabla_mh_agg2 mh
INNER JOIN tabla_ig_agg2 ig ON mh.edades = ig.edades AND mh.gender = ig.gender
WHERE mh.gender != 'Prefer not to say'
ORDER BY
gender
;



-- 5 ¿Cuál es la media por género de tiempo en pantalla y tiempo en redes sociales?
SELECT
		CASE
				WHEN age BETWEEN 18 and 24
				  THEN 'Jóvenes 18-24'
				WHEN age BETWEEN 25 and 34
				  THEN 'Adultos Jóvenes 25-34'
				WHEN age BETWEEN 35 and 44
				  THEN 'Adultos 35-44'
				WHEN age BETWEEN 45 and 54
				  THEN 'Mediana edad 45-54'
				WHEN age BETWEEN 55 and 65
				  THEN 'Adultos mayores 55-65'
				ELSE '-18 o +65'
				END AS edades,
		gender, 
        ROUND(AVG(social_media_hours_day), 2) as duracion_media
FROM tabla_mh
WHERE gender != 'Prefer not to say'
GROUP BY 
edades, 
gender
ORDER BY
gender
;

-- 6 ¿Hablamos de salud mental con nuestro entorno?  
SELECT 
	CASE
		WHEN age BETWEEN 18 and 24
		  THEN 'Jóvenes 18-24'
		WHEN age BETWEEN 25 and 34
          THEN 'Adultos Jóvenes 25-34'
        WHEN age BETWEEN 35 and 44
          THEN 'Adultos 35-44'
        WHEN age BETWEEN 45 and 54
          THEN 'Mediana edad 45-54'
        WHEN age BETWEEN 55 and 65
          THEN 'Adultos mayores 55-65'
        ELSE '-18 o +65'
        END AS edades,
	gender,
	ROUND(AVG(discuss_mental_health),2) as hablar_mental_health
FROM tabla_mh
WHERE gender != 'Prefer not to say'
GROUP BY 
edades, 
gender
ORDER BY
gender
;

-- 6 ¿Hablamos de salud mental en redes sociales? Overview

ALTER TABLE tabla_yt
RENAME COLUMN país TO country;

SELECT *
FROM tabla_yt
WHERE country = 'UK'
OR country= 'USA'
ORDER BY 
country
; 


-- */ 7 Los usuarios que consumen videos de YouTube con una duracion_media corta (tipo Shorts/clips) 
-- muestran una mayor media de concentration_difficulty. */

-- Desactiva el modo seguro
SET SQL_SAFE_UPDATES = 0;

UPDATE tabla_yt
SET country = 'USA'
WHERE country = 'US'; 

WITH concentracion_agg as (
SELECT 
    country,
    ROUND(AVG(concentration_difficulty), 2) as dificultad_concentrarse
FROM tabla_mh
GROUP BY 1
) -- SELECT * FROM concentracion_agg
,yt_agg as (
SELECT
	country,
    tema,
	duracion_media
FROM tabla_yt 
WHERE tema = 'loss of attention'
) -- SELECT * FROM yt_agg;
SELECT 
	ca.country,
	ca.dificultad_concentrarse,
    ya.duracion_media
FROM concentracion_agg ca
INNER JOIN yt_agg ya ON ca.country = ya.country
;


SELECT * 
FROM tabla_yt;


--  8 En países donde el sentimiento de soledad es más alto, los vídeos sobre soledad son más visitados

ALTER TABLE tabla_yt 
RENAME COLUMN `total_videos(estimado)` TO total_videos_estimado;

 
WITH soledad_agg as (
SELECT 
    country,
    ROUND(AVG(loneliness), 2) as sentimiento_soledad
FROM tabla_mh
GROUP BY 1
) 
,yt_agg as (
SELECT
	country,
    tema,
    total_videos_estimado,
	visitas_top50
FROM tabla_yt 
WHERE tema = 'loneliness'
) -- SELECT * FROM yt_agg;
SELECT 
	sa.country,
	sa.sentimiento_soledad,
    ya.total_videos_estimado,
    ya.visitas_top50
FROM soledad_agg sa
INNER JOIN yt_agg ya ON sa.country = ya.country
;


-- 9 Los usuarios de países con una duracion_media de video nacional 
-- más alta tienden a tener sesiones individuales más largas  pero 
-- una menor tasa de creación de contenido propio (posts_created_per_week).

WITH contenido_agg as (
SELECT 
    country,
	ROUND(AVG(average_session_length_minutes), 2) as media_sesion,
    ROUND(AVG(posts_created_per_week), 2) as post_x_semana
FROM tabla_ig
GROUP BY country
) 
, yt_agg_duracion as (
SELECT
	country,
    AVG(duracion_media) as duracion_media
FROM tabla_yt 
GROUP BY country
) -- SELECT * FROM yt_agg;
SELECT 
	co.country,
	co.media_sesion,
    co.post_x_semana,
    ROUND(yad.duracion_media, 2) AS duracion_video
FROM contenido_agg co
INNER JOIN yt_agg_duracion yad ON co.country = yad.country
;




