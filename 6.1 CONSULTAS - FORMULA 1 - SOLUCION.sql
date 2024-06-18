use bd_f1_sergio_ivan_raul;
go



SELECT id_motor, DATEDIFF(DAY, fecha_entrega, GETDATE()) AS DiasDesdeEntrega
FROM tb_motoristas
WHERE YEAR(fecha_entrega) <= YEAR(GETDATE())
    AND potencia_cv BETWEEN 750 AND 820
    AND num_componentes > 30;






SELECT  cod_direccion, tipo_via, nombre_via, numero_via, codigo_postal,municipio,ciudad,pais
FROM tb_direccion
WHERE nombre_via NOT LIKE 'R%' AND nombre_via NOT LIKE 'V%'
AND codigo_postal % 2 = 0
order by cod_direccion desc;






SELECT nombre_piloto, apellido1_piloto, peso, altura_cm, num_carreras, SUM(num_victorias) AS TotalVictorias
FROM tb_pilotos
WHERE nombre_piloto NOT LIKE 'R%' AND nombre_piloto NOT LIKE 'V%' AND nombre_piloto NOT LIKE 'P%' AND nombre_piloto NOT LIKE 'F%'
   AND num_carreras % 2 = 0 AND altura_cm BETWEEN 175 AND 183
GROUP BY  superlicencia,nombre_piloto, apellido1_piloto, peso, altura_cm, num_carreras
ORDER BY superlicencia DESC;




SELECT nombre_circuito, AVG(DATEDIFF(MILLISECOND, '00:00:00:000', vuelta_rapida)) AS AvgVueltaRapida
FROM tb_circuitos
WHERE nombre_circuito LIKE 'C%' OR nombre_circuito LIKE 'B%' OR nombre_circuito LIKE 'M%'
AND num_vueltas > 55
GROUP BY nombre_circuito;





SELECT SUM(num_vueltas) AS TotalVueltas, AVG(km_circuitos) AS AvgKmCircuitos, MAX(num_aforo) AS MaxAforo
FROM tb_circuitos;




SELECT 
    id_gp,
    DATEDIFF(YEAR, ano_creacion_gp, GETDATE()) AS 'Años Desde Creacion',
    MONTH(fecha_carrera) AS MesFechaCarrera,
    FORMAT(fecha_carrera, 'yyyy-MM-dd') AS FormatoFechaCarrera
FROM tb_gran_premio
WHERE YEAR(ano_creacion_gp) BETWEEN 2000 AND 2010;





SELECT 
 AVG(altura_cm ) AS AlturaMedia,
   AVG(peso ) AS PesoMedia
FROM tb_pilotos
WHERE superlicencia % 2 = 0;


SELECT marca, AVG(potencia_cv) AS MediaPotencia, AVG(num_componentes) AS MediaComponentes
FROM tb_motoristas
GROUP BY marca;





SELECT cod_direccion, tipo_via, nombre_via, numero_via, codigo_postal,municipio,ciudad,pais
FROM tb_direccion
WHERE tipo_via <> 'CALLE' AND numero_via % 2 <> 0;





SELECT cod_direccion, tipo_via, nombre_via, numero_via, codigo_postal,municipio,ciudad,pais
FROM tb_direccion
WHERE nombre_via LIKE 'F%' AND nombre_via LIKE '%A%' AND pais = 'USA' AND municipio LIKE '%n';




SELECT pais, COUNT(*) AS cantidad_direcciones
FROM tb_direccion
GROUP BY pais
HAVING COUNT(*) > 1;
