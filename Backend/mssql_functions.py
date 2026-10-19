import os
from dotenv import load_dotenv

cnx = None
mssql_params = {}

def mssql_connect(sql_creds):
    import pymssql
    cnx = pymssql.connect(
        server=sql_creds['DB_HOST'],
        user=sql_creds['DB_USER'],
        password=sql_creds['DB_PASSWORD'],
        database=sql_creds['DB_NAME'])
    return cnx

"""
def read_user_data(table_name, nombre):
    import pymssql
    global cnx, mssql_params
    read = "SELECT * FROM {} WHERE nombre = '{}'".format(table_name, nombre)
    print(read)
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("read_user_data: %s" % e)

def sql_read_all(table_name):
    import pymssql
    global cnx, mssql_params
    read = 'SELECT fecha FROM %s' % (table_name, table_name)
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)
"""

def getRecProximas():
    import pymssql
    global cnx, mssql_params
    read = 'SELECT Recoleccion.fecha, Promesa.monto, Donante.nombre, Donante.apellidoPaterno FROM Recoleccion INNER JOIN Promesa ON Recoleccion.idPromesa = Promesa.idPromesa INNER JOIN Donante ON Promesa.idDonante = Donante.idDonante WHERE Recoleccion.fecha >= CAST(GETDATE() AS DATE) AND Recoleccion.fecha < DATEADD(WEEK, 1, CAST(GETDATE() AS DATE))'
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def getRecProximasByMonto():
    import pymssql
    global cnx, mssql_params
    read = 'SELECT Recoleccion.fecha, Promesa.monto, Donante.nombre, Donante.apellidoPaterno FROM Recoleccion INNER JOIN Promesa ON Recoleccion.idPromesa = Promesa.idPromesa INNER JOIN Donante ON Promesa.idDonante = Donante.idDonante WHERE Recoleccion.fecha >= CAST(GETDATE() AS DATE) AND Recoleccion.fecha < DATEADD(WEEK, 1, CAST(GETDATE() AS DATE)) ORDER BY Promesa.monto DESC'
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def recMontoSum():
    import pymssql
    global cnx, mssql_params
    read = 'SELECT SUM(Promesa.monto) AS montoSemanal FROM Recoleccion INNER JOIN Promesa ON Recoleccion.idPromesa = Promesa.idPromesa INNER JOIN Donante ON Promesa.idDonante = Donante.idDonante WHERE Recoleccion.fecha >= DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0) AND Recoleccion.fecha < DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()) + 1, 0)'
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def numRecSemanal():
    import pymssql
    global cnx, mssql_params
    read = 'SELECT COUNT(*) AS recoleccionesSemanal FROM Recoleccion INNER JOIN Promesa ON Recoleccion.idPromesa = Promesa.idPromesa INNER JOIN Donante ON Promesa.idDonante = Donante.idDonante WHERE Recoleccion.fecha >= DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0) AND Recoleccion.fecha < DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()) + 1, 0)'
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def recoleccionPorDia():
    import pymssql
    global cnx, mssql_params
    read = 'WITH Dias AS (SELECT DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0) AS Dia UNION ALL SELECT DATEADD(DAY, 1, Dia) FROM Dias WHERE Dia < DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0) + 6) SELECT DATENAME(WEEKDAY, d.Dia) AS DiaSemana, COUNT(r.idRecoleccion) AS Total FROM Dias d LEFT JOIN Recoleccion r ON CAST(r.fecha AS DATE) = d.Dia GROUP BY d.Dia, DATENAME(WEEKDAY, d.Dia) ORDER BY d.Dia OPTION (MAXRECURSION 7)'
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def numRecHoy():
    import pymssql
    global cnx, mssql_params
    read = 'SELECT COUNT(*) AS recoleccionesHoy FROM Recoleccion INNER JOIN Promesa ON Recoleccion.idPromesa = Promesa.idPromesa INNER JOIN Donante ON Promesa.idDonante = Donante.idDonante WHERE Recoleccion.fecha >= CAST(GETDATE() AS DATE) AND Recoleccion.fecha < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))'
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

# ------------- Juan Pablo --------------
def datosGeneralesRecolecciones(mes):
    import pymssql
    global cnx, mssql_params
    read = """
           SET NOCOUNT ON;
DECLARE @mes    INT  = %s;
DECLARE @inicio DATE = DATEFROMPARTS(YEAR(GETDATE()), @mes, 1);
DECLARE @fin    DATE = DATEADD(MONTH, 1, @inicio);

SELECT
    ISNULL(SUM(CASE WHEN r.idEstado = 2      THEN 1 ELSE 0 END), 0) AS exitosas,
    ISNULL(SUM(CASE WHEN r.idEstado = 6      THEN 1 ELSE 0 END), 0) AS parciales,
    ISNULL(SUM(CASE WHEN r.idEstado IN (1,3) THEN 1 ELSE 0 END), 0) AS reprogramadas
FROM Promesa p
INNER JOIN Recoleccion r ON r.idPromesa = p.idPromesa
WHERE p.fecha >= @inicio
  AND p.fecha <  @fin;
            """
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read, (mes,))
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read, (mes,))
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def statusHoyRec():
    import pymssql
    global cnx, mssql_params
    read = """
            SELECT (SELECT COUNT(*) FROM Recoleccion WHERE Recoleccion.fecha >= CAST(GETDATE() AS DATE)
  AND Recoleccion.fecha < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
  ) AS programadasHoy,
(SELECT COUNT(*) FROM Recoleccion WHERE Recoleccion.fecha >= CAST(GETDATE() AS DATE)
  AND Recoleccion.fecha < DATEADD(DAY, 1, CAST(GETDATE() AS DATE)) AND Recoleccion.idEstado = 2
  ) AS Completadas,
(SELECT COUNT(*) FROM Recoleccion WHERE Recoleccion.fecha >= CAST(GETDATE() AS DATE)
  AND Recoleccion.fecha < DATEADD(DAY, 1, CAST(GETDATE() AS DATE)) AND Recoleccion.idEstado = 5
  ) AS Pendientes,
(SELECT COUNT(*) FROM Promesa INNER JOIN  Recoleccion ON Promesa.idPromesa = Recoleccion.idPromesa 
  WHERE Recoleccion.fecha >= CAST(GETDATE() AS DATE)
  AND Recoleccion.fecha < DATEADD(DAY, 1, CAST(GETDATE() AS DATE)) AND Recoleccion.idEstado = 6) AS parciales
           """
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def adminMainRecMontos(mes):
    import pymssql
    global cnx, mssql_params
    read = """
           SET NOCOUNT ON;
DECLARE @mes    INT  = %s;
DECLARE @inicio DATE = DATEFROMPARTS(YEAR(GETDATE()), @mes, 1);
DECLARE @fin    DATE = DATEADD(MONTH, 1, @inicio);

WITH Totales AS (
    SELECT
        ISNULL(SUM(CASE
            WHEN pg.fechaConfirmacion >= @inicio
             AND pg.fechaConfirmacion <  @fin
            THEN pg.importe END), 0) AS montoRecaudado,

        ISNULL(SUM(CASE
            WHEN COALESCE(pg.fechaReprogramacion, pg.fechaPago) >= @inicio
             AND COALESCE(pg.fechaReprogramacion, pg.fechaPago) <  @fin
            THEN pg.importe END), 0) AS montoPrevisto
    FROM pago pg
    WHERE ISNULL(pg.cancelado, 0) = 0
),
Redondeados AS (
    SELECT
        CAST(ROUND(montoRecaudado, 0) AS INT) AS montoRecaudado,
        CAST(ROUND(montoPrevisto, 0)  AS INT) AS montoPrevisto
    FROM Totales
)
SELECT
    montoRecaudado,
    montoPrevisto
FROM Redondeados;
           """
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read, (mes,))
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read, (mes,))
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def widgetsAdmin():
    import pymssql
    global cnx, mssql_params
    read = """
           WITH DonacionesMes AS (
    SELECT pr.idDonante, SUM(pg.importe) AS totalDonado
    FROM pago pg
    JOIN Promesa pr ON pr.idPromesa = pg.idPromesa
    WHERE ISNULL(pg.cancelado, 0) = 0
      AND pg.fechaConfirmacion >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
      AND pg.fechaConfirmacion <  DATEADD(MONTH, 1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
    GROUP BY pr.idDonante
),
Ranking AS (
    SELECT idDonante, NTILE(10) OVER (ORDER BY totalDonado DESC) AS decil
    FROM DonacionesMes
)
SELECT
    -- Llamadas del día
    (SELECT COUNT(*) FROM Llamada
      WHERE fecha >= CAST(GETDATE() AS DATE) AND fecha < DATEADD(DAY, 1, CAST(GETDATE() AS DATE)))               AS llamadasHoy,

    -- Promesas del día
    (SELECT COUNT(*) FROM Promesa
      WHERE fecha >= CAST(GETDATE() AS DATE) AND fecha < DATEADD(DAY, 1, CAST(GETDATE() AS DATE)))               AS promesasHoy,

    -- % de recolecciones completadas en el mes
    (SELECT CAST(ROUND(100.0 * SUM(CASE WHEN r.idEstado = 2 THEN 1 ELSE 0 END)
                   / NULLIF(COUNT(*), 0), 0) AS INT)
	   FROM Recoleccion r
	  WHERE r.fecha >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
	    AND r.fecha <  DATEADD(MONTH, 1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
	) AS porcentajeRecolecciones,

    -- Donantes dentro del 10% que más donó este mes
    (SELECT COUNT(*) FROM Ranking WHERE decil = 1) AS top10Donantes;
           """
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def adminMainGraphs(mes):
    import pymssql
    global cnx, mssql_params
    read = """
           SET NOCOUNT ON;
DECLARE @mes    INT  = %s;
DECLARE @inicio DATE = DATEFROMPARTS(YEAR(GETDATE()), @mes, 1);
DECLARE @fin    DATE = DATEADD(MONTH, 1, @inicio);

WITH Semanas AS (
    SELECT n AS semana FROM (VALUES (1), (2), (3), (4)) v(n)
),
Recaudado AS (
    SELECT
        CASE WHEN DAY(pg.fechaConfirmacion) > 21 THEN 4
             ELSE (DAY(pg.fechaConfirmacion) - 1) / 7 + 1 END AS semana,
        SUM(pg.importe) AS total
    FROM pago pg
    WHERE ISNULL(pg.cancelado, 0) = 0
      AND pg.fechaConfirmacion >= @inicio
      AND pg.fechaConfirmacion <  @fin
    GROUP BY CASE WHEN DAY(pg.fechaConfirmacion) > 21 THEN 4
                  ELSE (DAY(pg.fechaConfirmacion) - 1) / 7 + 1 END
),
PagosPrevistos AS (
    SELECT pg.importe, COALESCE(pg.fechaReprogramacion, pg.fechaPago) AS fechaEsperada
    FROM pago pg
    WHERE ISNULL(pg.cancelado, 0) = 0
),
Previsto AS (
    SELECT
        CASE WHEN DAY(fechaEsperada) > 21 THEN 4
             ELSE (DAY(fechaEsperada) - 1) / 7 + 1 END AS semana,
        SUM(importe) AS total
    FROM PagosPrevistos
    WHERE fechaEsperada >= @inicio
      AND fechaEsperada <  @fin
    GROUP BY CASE WHEN DAY(fechaEsperada) > 21 THEN 4
                  ELSE (DAY(fechaEsperada) - 1) / 7 + 1 END
)
SELECT
    s.semana,
    CAST(ROUND(ISNULL(r.total, 0), 0) AS INT) AS recaudacion,
    CAST(ROUND(ISNULL(p.total, 0), 0) AS INT) AS recPrevista
FROM Semanas s
LEFT JOIN Recaudado r ON r.semana = s.semana
LEFT JOIN Previsto  p ON p.semana = s.semana
ORDER BY s.semana;
           """
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read, (mes,))
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read, (mes,))
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def adminMainListaActCasos():
    import pymssql
    global cnx, mssql_params
    read = """
            SELECT
            c.nombre AS [nombreCampaña],
            c.descripcion AS descripcion,
            CAST(ROUND(ISNULL(SUM(pg.importe), 0), 0) AS INT) AS recaudado,
            CAST(ROUND(c.montoSolicitado, 0) AS INT) AS meta
        FROM Caso c
        LEFT JOIN Promesa pr
            ON pr.idCaso = c.idCaso
        LEFT JOIN pago pg
            ON pg.idPromesa = pr.idPromesa
            AND ISNULL(pg.cancelado, 0) = 0
            AND pg.fechaConfirmacion IS NOT NULL
        GROUP BY c.idCaso, c.nombre, c.descripcion, c.montoSolicitado
        HAVING ISNULL(SUM(pg.importe), 0) < c.montoSolicitado
        ORDER BY recaudado DESC;
           """
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

# -------------- Jaime -------------------
# Log in
def funcionLogin(userName, password):
    import pymssql
    import hashlib
    global cnx, mssql_params
    query = "SELECT idUsuario, nombre, idRol, [userName], password_hash FROM Usuario WHERE [userName] = %s"
    try:
        cursor = cnx.cursor(as_dict=True)
        cursor.execute(query, (userName, ))
    except pymssql._pymssql.InterfaceError:
            print("Reconnecting...")
            cnx.connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(query, (userName, ))
    except Exception as error:
        raise TypeError(f"funcionLogin: {error}")

    answer = cursor.fetchone()
    #cnx.close()

    contraHasehada = hashlib.sha256(password.encode('utf-8')).hexdigest()

    if answer and answer["userName"] == userName and answer["password_hash"].lower() == contraHasehada.lower():
        return answer 
    else:
        return None 

# Pantalla recaudacion por Areas
def getrowcasosActivos():
    import pymssql
    global cnx, mssql_params
    query = """
            select c.idCaso, c.nombre, c.descripcion, cast(pagos.totalPagado AS FLOAT) as totalPagado FROM Caso c
            cross APPLY(
                select ISNULL(SUM(pg.importe),0) as totalPagado from promesa p 
                inner join pago pg on pg.idPromesa =p.idPromesa
                where p.idCaso = c.idCaso and pg.cancelado = 0) as pagos
            where c.montoSolicitado > pagos.totalPagado
            order by pagos.totalPagado DESC
            """

    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query)

    answer = cursor.fetchall()
    cursor.close()
    return answer

def getGraficas():
    import pymssql
    global cnx, mssql_params

    query = """
            select TOP 5 c.idCaso, c.nombre, cast(pagos.totalPagado AS FLOAT) AS totalPagado, c.montoSolicitado from Caso c
            cross APPLY(
                select ISNULL(SUM(pg.importe),0) as totalPagado from promesa p 
                inner join pago pg on pg.idPromesa =p.idPromesa
                where p.idCaso = c.idCaso and pg.cancelado = 0) as pagos
            where c.montoSolicitado > pagos.totalPagado
            order by pagos.totalPagado DESC;
            """

    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query)

    answer = cursor.fetchall()
    cursor.close()
    return answer

def infoWidgets():
    import pymssql
    global cnx, mssql_params

    query = """
            SELECT
                (select COUNT(c.idCaso) from Caso c
                where c.montoSolicitado > (select isnull(SUM(pg.importe), 0)
                    from Promesa p
                    inner join pago pg ON pg.idPromesa = p.idPromesa
                    where p.idCaso = c.idCaso
                and pg.cancelado = 0) ) AS areasActivas, 
                        
                (select CAST(ISNULL(SUM(c.montoSolicitado - pagos.totalPagado), 0) AS float) from Caso c
                cross APPLY (
                    select ISNULL(SUM(pg.importe), 0) AS totalPagado
                    from Promesa p
                    inner join pago pg ON pg.idPromesa = p.idPromesa
                    where p.idCaso = c.idCaso AND pg.cancelado = 0
                    ) as pagos where c.montoSolicitado > pagos.totalPagado
                ) AS porRecaudar,
                        
                (select CAST(ISNULL(SUM(pg.importe),0) AS float) from pago pg 
                    where pg.cancelado != 1 ) AS totalRecaudado
            """
    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query)

    answer = cursor.fetchone()
    cursor.close()
    return answer

# Donantes TOP 10%
def getDonantesTopDiez ():
    import pymssql
    global cnx, mssql_params

    query = """
            select TOP (10) Percent d.idDonante, d.nombre, d.apellidoPaterno, CAST(SUM(pg.importe) as float) as totalDonado,COUNT(pg.idPago) as numDonaciones,
            CAST(AVG(pg.importe) as float) as montoPromedio
            from Donante d 
            inner join Promesa p on p.idDonante = d.idDonante 
            inner join pago pg on pg.idPromesa = p.idPromesa
            where pg.cancelado = 0
            group by d.idDonante, d.nombre, d.apellidoPaterno
            order by totalDonado DESC
            """
    cursor = cnx.cursor(as_dict = True)
    cursor.execute(query)
    
    answer = cursor.fetchall()
    cursor.close()
    return answer

def getMontoPromedioDonante(): 
    import pymssql
    global cnx, mssql_params

    query = """
            Select 
                (select CAST(AVG(topDiez.totalDonado) as float) from 
                    (select TOP (10) percent p.idDonante, SUM(pg.importe) as totalDonado from Promesa p 
                        inner join pago pg on pg.idPromesa = p.idPromesa 
                        where pg.cancelado = 0
                        group by p.idDonante 
                        order by totalDonado DESC
                    ) as topDiez
                ) as promedioTop,
                
                (select CAST(ISNULL(AVG(resto.totalDonado), 0) as float) FROM 
                    (select p.idDonante, SUM(pg.importe) as totalDonado from Promesa p
                        inner join pago pg on pg.idPromesa = p.idPromesa
                        where pg.cancelado = 0
                        and p.idDonante not in (select TOP (10) percent pp.idDonante from Promesa pp
                                                    inner join pago	ppg on ppg.idPromesa = pp.idPromesa 
                                                    where ppg.cancelado = 0
                                                    group by pp.idDonante 
                                                    order by SUM(ppg.importe) DESC) 
                        group by p.idDonante) as resto	
                ) as promedioResto
            """
    cursor = cnx.cursor(as_dict = True)
    cursor.execute(query)

    answer = cursor.fetchone()
    cursor.close()
    return answer

def getAportacioinTotal():
    import pymssql
    global cnx, mssql_params

    query = """
            select CAST(ISNULL((select SUM(total.totalDonado) from 
				(select TOP (10) percent p.idDonante, SUM(pg.importe) as totalDonado from Promesa p
					inner join pago pg on pg.idPromesa = p.idPromesa
					where pg.cancelado = 0
					group by p.idDonante
					order by totalDonado DESC) as total) * 100.0
					
				/NULLIF((select SUM(pg.importe) from Promesa p 
					inner join pago pg on pg.idPromesa = p.idPromesa
					where pg.cancelado = 0), 0)
			,0) as FLOAT) as porcentajeTop
            """
    cursor = cnx.cursor(as_dict = True)
    cursor.execute(query)

    answer = cursor.fetchone()
    cursor.close()
    return answer

def getTopDiezWidgets(): 
    import pymssql
    global cnx, mssql_params

    query = """
            Select 
                (select CAST(AVG(topDiez.totalDonado) as float) from 
                    (select TOP (10) percent p.idDonante, SUM(pg.importe) as totalDonado from Promesa p 
                        inner join pago pg on pg.idPromesa = p.idPromesa 
                        where pg.cancelado = 0
                        group by p.idDonante 
                        order by totalDonado DESC
                    ) as topDiez
                ) as promedioTop,
                
                (select CAST(ISNULL(AVG(resto.totalDonado), 0) as float) FROM 
                    (select p.idDonante, SUM(pg.importe) as totalDonado from Promesa p
                        inner join pago pg on pg.idPromesa = p.idPromesa
                        where pg.cancelado = 0
                        and p.idDonante not in (select TOP (10) percent pp.idDonante from Promesa pp
                                                    inner join pago	ppg on ppg.idPromesa = pp.idPromesa 
                                                    where ppg.cancelado = 0
                                                    group by pp.idDonante 
                                                    order by SUM(ppg.importe) DESC) 
                        group by p.idDonante) as resto	
                ) as promedioResto,
                
                (select COUNT(*) from 
                    (select TOP (10) percent p.idDonante, SUM(pg.importe) as totalDonado from Promesa p 
                        inner join pago pg on pg.idPromesa = p.idPromesa 
                        where pg.cancelado = 0
                        group by p.idDonante
                        order by totalDonado DESC
                    ) as TopDiez
                ) as numDonantesTop
            """
    cursor = cnx.cursor(as_dict = True)
    cursor.execute(query)

    answer = cursor.fetchone()
    cursor.close()
    return answer

#  -------------- Alex -------------------
def getDetailedDonor(donorId):
    global cnx

    query = """
        select 
            d.nombre, 
            d.apellidoPaterno,
            d.apellidoMaterno,
            d.telCasa,
            d.telTrabajo,
            d.telPersonal,
            d.telTmp,
            d.tipoDonante,
            c2.nombreClas ,
            d.donanteEspecial,
            d.excluido,
            d.fechaExclusion,
            d.correo,
            d.estado, 
            d.fechaNacimiento,
            d.direccion,
            p.idPromesa ,
            c.nombre as nombreCaso,
            p.frecuencia,
            p.monto,
            p.idEstado,
            pa.idPago,
            pa.fechaPago,
            pa.importe,
            sp.estado as estadoPago,
            MAX(pa.fechaPago) OVER (PARTITION BY d.idDonante) AS ultimaDonacion,
            dbo.calcularRiesgo(
                MAX(pa.fechaPago) OVER (PARTITION BY d.idDonante)
            ) AS nivelRiesgo,
            SUM(pa.importe) OVER (
                PARTITION BY d.idDonante
            ) AS totalDonado
        from donante d
        left join promesa p on d.idDonante = p.idDonante
        left join caso c on c.idCaso = p.idCaso
        left join pago pa on p.idPromesa = pa.idPromesa
        left join StatusPago sp on pa.idStatusPago = sp.idStatusPago  
        left join Clasificacion c2 on d.idClasificacion = c2.idClasificacion 
        where d.idDonante = %s;
    """

    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query, (donorId,))

    answer = cursor.fetchall()
    cursor.close()

    return answer

def getDetailedCollection(collectionId):
    global cnx

    query = """
        select
            r.idRecoleccion,
            d.nombre,
            d.apellidoPaterno,
            d.apellidoMaterno,
            er.nombre as estado,
            r.fecha,
            p.monto as montoARecolectar,
            r.direccion,
            p.idCaso,
            c.nombre as nombreCaso,
            r.formaPago,
            p.frecuencia
        from Recoleccion r
        inner join Promesa p on r.idPromesa = p.idPromesa
        inner join Donante d on p.idDonante = d.idDonante
        left join Caso c on p.idCaso = c.idCaso
        left join EstadosRecoleccion er on r.idEstado = er.idEstado
        where r.idRecoleccion = %s;
    """

    tagsQuery = """
        select t.nombreAreaTag
        from CasoAreaTag ct
        inner join AreaTag t on ct.idAreaTag = t.idAreaTag
        where ct.idCaso = %s;
    """

    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query, (collectionId,))
    collection = cursor.fetchone()

    if collection is None:
        cursor.close()
        return None

    tags = []
    if collection["idCaso"] is not None:
        cursor.execute(tagsQuery, (collection["idCaso"],))
        tags = [row["nombreAreaTag"] for row in cursor.fetchall()]

    cursor.close()

    collection["tags"] = tags
    return collection

def updateCollectionState(collectionId, newStateId):
    global cnx

    stateQuery = """
        select idEstado
        from EstadosRecoleccion
        where idEstado = %s;
    """

    updateQuery = """
        update Recoleccion
        set idEstado = %s
        where idRecoleccion = %s;
    """

    cursor = cnx.cursor(as_dict=True)

    try:
        cursor.execute(stateQuery, (newStateId,))
        if cursor.fetchone() is None:
            cursor.close()
            return "invalid_state"

        cursor.execute(updateQuery, (newStateId, collectionId))

        if cursor.rowcount == 0:
            cnx.rollback()
            cursor.close()
            return "not_found"

        cnx.commit()
        cursor.close()
        return "ok"
    
    except Exception:
        cnx.rollback()
        cursor.close()
        raise

ALLOWED_COLLECTION_STATES = (2, 3, 6)

def getCollectionStates():
    global cnx

    query = """
        select
            idEstado,
            nombre
        from EstadosRecoleccion
        where idEstado in (%s, %s, %s)
        order by idEstado;
    """

    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query, ALLOWED_COLLECTION_STATES)
    states = cursor.fetchall()
    cursor.close()

    return states

#  -------------- Cristhian -------------------
def getEstadosPromesa():
    global cnx
    query = "SELECT idEstado, nombre FROM EstadosPromesa"
    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query)
    answer = cursor.fetchall()
    cursor.close()
    return answer
 
def getPromesaById(idPromesa):
    global cnx
    query = """
        SELECT p.idPromesa, p.idUsuario, p.idDonante, p.idCaso, p.monto,
               p.idEstado, e.nombre AS estadoNombre, p.fecha, p.frecuencia, p.tipoFrecuencia, p.formaPago,
               c.nombre AS nombreCaso
        FROM Promesa p
        INNER JOIN EstadosPromesa e ON p.idEstado = e.idEstado
        INNER JOIN Caso c ON p.idCaso = c.idCaso
        WHERE p.idPromesa = %s
    """
    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query, (idPromesa,))
    answer = cursor.fetchone()
    cursor.close()
    return answer
 
def getAreaTagsByCaso(idCaso):
    """
    Un Caso puede tener varios AreaTag (relacion N a N via CasoAreaTag),
    por eso regresa una lista y no un solo valor.
    """
    global cnx
    query = """
        SELECT at.idAreaTag, at.nombreAreaTag
        FROM CasoAreaTag cat
        INNER JOIN AreaTag at ON cat.idAreaTag = at.idAreaTag
        WHERE cat.idCaso = %s
    """
    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query, (idCaso,))
    answer = cursor.fetchall()
    cursor.close()
    return answer

def getPagoById(idPago):
    global cnx
    query = """
        SELECT 
            pa.idPago,
            c.nombre AS nombreCampana,
            sp.estado AS estatusPago,
            pa.formaPago,
            pa.fechaConfirmacion,
            CASE WHEN pa.cancelado = 1 THEN 'Sí' ELSE 'No' END AS cancelado,
            CASE WHEN pa.reprogramado = 1 THEN 'Sí' ELSE 'No' END AS reprogramado,
            pa.fechaReprogramacion,
            pa.importe AS monto
        FROM pago pa
        INNER JOIN StatusPago sp ON pa.idStatusPago = sp.idStatusPago
        INNER JOIN Promesa p ON pa.idPromesa = p.idPromesa
        INNER JOIN Caso c ON p.idCaso = c.idCaso
        WHERE pa.idPago = %s
    """
    try:
        cursor = cnx.cursor(as_dict=True)
        cursor.execute(query, (idPago,))
        answer = cursor.fetchone()
        cursor.close()
        return answer
    except Exception as e:
        print(f"Error en getPagoById: {e}")
        return None


#Cristhian recoleccion

def getEstadosRecoleccion():
    global cnx
    query = "SELECT idEstado, nombre FROM EstadosRecoleccion"
    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query)
    answer = cursor.fetchall()
    cursor.close()
    return answer

def getRecoleccionById(idRecoleccion):
    """
    Detalle de una recoleccion para la pantalla de Reprogramar:
    nombre/direccion del donante, monto de la promesa, fecha y estado actuales.
    """
    global cnx
    query = """
        SELECT r.idRecoleccion, r.idPromesa, r.fecha AS fechaActual,
               r.idEstado, re.nombre AS estadoNombre,
               p.monto,
               d.idDonante, d.nombre, d.apellidoPaterno, d.apellidoMaterno, d.direccion
        FROM Recoleccion r
        INNER JOIN Promesa p ON r.idPromesa = p.idPromesa
        INNER JOIN Donante d ON p.idDonante = d.idDonante
        INNER JOIN EstadosRecoleccion re ON r.idEstado = re.idEstado
        WHERE r.idRecoleccion = %s
    """
    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query, (idRecoleccion,))
    answer = cursor.fetchone()
    cursor.close()
    return answer

def reprogramarRecoleccion(idRecoleccion, nuevaFecha, motivoRepro, idEstado):
    """
    Reprograma una recoleccion: actualiza la misma fila con la nueva fecha,
    el motivo de reprogramacion y el nuevo estado (p.ej. 'No recolectada').
    """
    global cnx
    query = """
        UPDATE Recoleccion
        SET fecha = %s, motivoRepro = %s, idEstado = %s
        WHERE idRecoleccion = %s
    """
    cursor = cnx.cursor(as_dict=True)
    cursor.execute(query, (nuevaFecha, motivoRepro, idEstado, idRecoleccion))
    filas = cursor.rowcount
    cnx.commit()
    cursor.close()
    return filas

""" def sql_read_where(table_name, d_where):
    import pymssql
    global cnx, mssql_params
    read = 'SELECT * FROM %s WHERE ' % table_name
    read += '('
    for k,v in d_where.items():
        if v is not None:
            if isinstance(v,bool):
                read += "%s = '%s' AND " % (k,int(v == True))
            else:
                read += "%s = '%s' AND " % (k,v)
        else:
            read += '%s is NULL AND ' % (k)
    # Remove last "AND "
    read = read[:-4]
    read += ')'
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(read)
        a = cursor.fetchall()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_read_where:%s" % e)

def sql_insert_row_into(table_name, d):
    import pymssql
    global cnx, mssql_params
    keys = ""
    values = ""
    data = []
    for k in d:
        keys += k + ','
        values += "%s,"
        if isinstance(d[k],bool):
            data.append(int(d[k] == True))
        else:
            data.append(d[k])
    keys = keys[:-1]
    values = values[:-1]
    insert = 'INSERT INTO %s (%s) VALUES (%s)'  % (table_name, keys, values)
    data = tuple(data)
    #print(insert)
    #print(data)
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(insert, data)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            cursor.execute(insert, data)
        cnx.commit()
        id_new = cursor.lastrowid
        cursor.close()
        return id_new
    except Exception as e:
        raise TypeError("sql_insert_row_into:%s" % e)

def sql_update_where(table_name, d_field, d_where):
    import pymssql
    global cnx, mssql_params
    update = 'UPDATE %s SET ' % table_name
    for k,v in d_field.items():
        if v is None:
            update +='%s = NULL, ' % (k)
        elif isinstance(v,bool):
            update +='%s = %s, ' % (k,int(v == True))
        elif isinstance(v,str):
            update +="%s = '%s', " % (k,v)
        else:
            update +='%s = %s, ' % (k,v)
    # Remove last ", "
    update = update[:-2]
    update += ' WHERE ( '
    for k,v in d_where.items():
        if v is not None:
            if isinstance(v,bool):
                update += "%s = '%s' AND " % (k,int(v == True))
            else:
                update += "%s = '%s' AND " % (k,v)
        else:
            update += '%s is NULL AND ' % (k)
    # Remove last "AND "
    update = update[:-4]
    update += ")"
    print(update)
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            a = cursor.execute(update)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            a = cursor.execute(update)
        cnx.commit()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_update_where:%s" % e)

def sql_delete_where(table_name, d_where):
    import pymssql
    global cnx, mssql_params
    delete = 'DELETE FROM %s ' % table_name
    delete += ' WHERE ( '
    for k,v in d_where.items():
        if v is not None:
            if isinstance(v,bool):
                delete += "%s = '%s' AND " % (k,int(v == True))
            else:
                delete += "%s = '%s' AND " % (k,v)
        else:
            delete += '%s is NULL AND ' % (k)
    # Remove last "AND "
    delete = delete[:-4]
    delete += ")"
    print(delete)
    try:
        try:
            cursor = cnx.cursor(as_dict=True)
            a = cursor.execute(delete)
        except pymssql._pymssql.InterfaceError:
            print("reconnecting...")
            cnx = mssql_connect(mssql_params)
            cursor = cnx.cursor(as_dict=True)
            a = cursor.execute(delete)
        cnx.commit()
        cursor.close()
        return a
    except Exception as e:
        raise TypeError("sql_delete_where:%s" % e) """


#Rogelio
RESUMEN = """
    select d.idDonante, d.nombre, d.apellidoPaterno,
           max(r.fecha) as ultimaDonacion,
           sum(r.montoRecibido) as totalDonado,
           datediff(month, max(r.fecha), getdate()) as mesesSinDonar
    from Donante d
    join Promesa p on p.idDonante = d.idDonante
    join Recoleccion r on r.idPromesa = p.idPromesa
    where r.montoRecibido > 0
      and isnull(d.excluido, 0) = 0
    group by d.idDonante, d.nombre, d.apellidoPaterno
"""
NIVEL = """
    case
        when mesesSinDonar >= 36 then 'inactivo'
        when mesesSinDonar >= 12 then 'alto'
        when mesesSinDonar >= 6  then 'medio'
        else 'bajo'
    end
"""

def _query(sql, params=()):
    global cnx
    cursor = cnx.cursor(as_dict=True)
    if params:
        cursor.execute(sql, params)
    else:
        cursor.execute(sql)
    rows = cursor.fetchall()
    cursor.close()
    return rows

def _nombre(r):
    return f"{r['nombre']} {r['apellidoPaterno'] or ''}".strip()

def getDashboard(idUsuario, metaDiaria=25):
    llamadas = _query(
        """select count(*) as total from Llamada
           where idUsuario = %s
             and fecha = cast(getdate() as date)""",
        (idUsuario,))[0]["total"]

    conteo = {r["nivel"]: r["total"] for r in _query(
        f"""select {NIVEL} as nivel, count(*) as total
            from ({RESUMEN}) x
            group by {NIVEL}""")} # nosec B608

    en_riesgo = _query(
        f"""select top 4 idDonante, nombre, apellidoPaterno,
                   mesesSinDonar,
                   datediff(day, ultimaDonacion, getdate()) as diasSinDonar,
                   {NIVEL} as nivel
            from ({RESUMEN}) x
            where mesesSinDonar >= 6 and mesesSinDonar < 36
            order by mesesSinDonar desc""") # nosec B608

    potenciales = _query("""
        SELECT TOP 3
            d.idDonante,
            d.nombre,
            d.apellidoPaterno,
            COUNT(r.idRecoleccion) AS cantidadDonaciones,
            CAST(AVG(r.montoRecibido) AS FLOAT) AS donacionPotencial
        FROM Donante d
        INNER JOIN Promesa p
            ON p.idDonante = d.idDonante
        INNER JOIN Recoleccion r
            ON r.idPromesa = p.idPromesa
        WHERE r.montoRecibido > 0
        GROUP BY
            d.idDonante,
            d.nombre,
            d.apellidoPaterno
        ORDER BY donacionPotencial DESC
    """)

    alto_valor = _query(
        f"""select top 4 idDonante, nombre, apellidoPaterno,
                   mesesSinDonar,
                   datediff(day, ultimaDonacion, getdate()) as diasSinDonar,
                   totalDonado
            from ({RESUMEN}) x
            order by totalDonado desc""") # nosec B608

    return {
        "meta": {"llamadasHoy": llamadas, "metaDiaria": metaDiaria},
        "riesgo": {
            "alto": conteo.get("alto", 0),
            "medio": conteo.get("medio", 0),
            "bajo": conteo.get("bajo", 0),
            "inactivos": conteo.get("inactivo", 0),
        },
        "donantesEnRiesgo": [
            {"idDonante": r["idDonante"], "nombre": _nombre(r),
             "mesesSinDonar": r["mesesSinDonar"],
             "diasSinDonar": r["diasSinDonar"],
             "nivel": r["nivel"]}
            for r in en_riesgo],
        "donantesPotenciales": [
            {"idDonante": r["idDonante"],
             "nombre": _nombre(r),
             "cantidadDonaciones": r["cantidadDonaciones"],
             "donacionPotencial": round(r["donacionPotencial"] or 0, 2)}
            for r in potenciales],
        "donantesAltoValor": [
            {"idDonante": r["idDonante"], "nombre": _nombre(r),
             "mesesSinDonar": r["mesesSinDonar"],
             "diasSinDonar": r["diasSinDonar"],
             "totalDonado": float(r["totalDonado"] or 0)}
            for r in alto_valor],
    }

#Endpoint 2

def getDonantesRiesgo():
    conteo = {r["nivel"]: r["total"] for r in _query(
            f"""select {NIVEL} as nivel, count(*) as total
                from ({RESUMEN}) x
                group by {NIVEL}""")} # nosec B608
    en_riesgo = _query(
            f"""select idDonante, nombre, apellidoPaterno,
                       mesesSinDonar, {NIVEL} as nivel
                from ({RESUMEN}) x
                where mesesSinDonar >= 1
                order by mesesSinDonar desc""") # nosec B608
    return {
        "riesgo": {
                    "alto": conteo.get("alto", 0),
                    "medio": conteo.get("medio", 0),
                    "bajo": conteo.get("bajo", 0),
                    "inactivos": conteo.get("inactivo", 0),
                },
        "donantesEnRiesgo": [
                    {"idDonante": r["idDonante"], "nombre": _nombre(r),
                     "mesesSinDonar": r["mesesSinDonar"], "nivel": r["nivel"]}
                    for r in en_riesgo]
    }
#Endpoint 3


def getDonantesPotencial():
    potenciales = _query("""
        SELECT
            d.idDonante,
            d.nombre,
            d.apellidoPaterno,
            COUNT(r.idRecoleccion) AS cantidadDonaciones,
            CAST(AVG(r.montoRecibido) AS FLOAT) AS donacionPotencial
        FROM Donante d
        INNER JOIN Promesa p
            ON p.idDonante = d.idDonante
        INNER JOIN Recoleccion r
            ON r.idPromesa = p.idPromesa
        WHERE r.montoRecibido > 0
        GROUP BY
            d.idDonante,
            d.nombre,
            d.apellidoPaterno
        ORDER BY donacionPotencial DESC
    """)

    totalDonantes = len(potenciales)

    prioritarios = sum(
        1 for r in potenciales
        if r["donacionPotencial"] >= 5000
    )

    potencialRecaudacion = sum(
        r["donacionPotencial"] or 0
        for r in potenciales
    )

    return {
        "resumen": {
            "donantesPotenciales": totalDonantes,
            "donantesPrioritarios": prioritarios,
            "potencialRecaudacion": round(
                potencialRecaudacion, 2
            )
        },

        "donantesPotenciales": [
            {
                "idDonante": r["idDonante"],
                "nombre": _nombre(r),
                "cantidadDonaciones": r["cantidadDonaciones"],
                "donacionPotencial": round(
                    r["donacionPotencial"] or 0, 2
                )
            }
            for r in potenciales
        ]
    }
#Endpoint 4
def getDonantesAltoValor():
    alto_valor = _query(
        f"""select idDonante, nombre, apellidoPaterno,
                mesesSinDonar,
                datediff(day, ultimaDonacion, getdate()) as diasSinDonar,
                totalDonado
            from (
                select x.*,
                    row_number() over (order by totalDonado desc) as rn,
                    count(*) over () as total
                from ({RESUMEN}) x
            ) y
            where rn <= 4 or rn <= ceiling(total * 0.10)
            order by totalDonado desc""") # nosec B608

    totalDonantes = len(alto_valor)

    totalRecaudado = sum(
        r["totalDonado"] or 0
        for r in alto_valor
    )

    ultimaActividad = min(
        (r["diasSinDonar"] for r in alto_valor),
        default=0
    )

    return {
        "resumen": {
            "donantesAltoValor": totalDonantes,
            "ultimaActividadDias": ultimaActividad,
            "totalRecaudado": round(totalRecaudado, 2)
        },

        "donantesAltoValor": [
            {
                "idDonante": r["idDonante"],
                "nombre": _nombre(r),
                "mesesSinDonar": r["mesesSinDonar"],
                "diasSinDonar": r["diasSinDonar"],
                "totalDonado": round(float(r["totalDonado"] or 0), 2)
            }
            for r in alto_valor
        ]
    }

#FIN ROGELIO

if __name__ == '__main__':
    import json
    mssql_params = {}
    mssql_params['DB_HOST'] = os.getenv('DB_HOST')
    mssql_params['DB_NAME'] = os.getenv('DB_NAME')
    mssql_params['DB_USER'] = os.getenv('DB_USER')
    mssql_params['DB_PASSWORD'] = os.getenv('DB_PASSWORD')
    cnx = mssql_connect(mssql_params)

    # Do your thing
    try:
        rx = sql_read_all('Usuario')
        print(json.dumps(rx, indent=4))
        input("press Enter to continue...")
        """ rx = read_user_data('users', 'hugo')
        print(rx)
        input("press Enter to continue...")
        print("Querying for user 'paco'...")
        d_where = {'username': 'paco'}
        rx = sql_read_where('users', d_where)
        print(rx)
        input("press Enter to continue...")
        print("Inserting user 'otro'...")
        rx = sql_insert_row_into('users',{'username': 'otro', 'password': 'otro123'})
        print("Inserted record", rx)
        rx = sql_read_all('users')
        print(json.dumps(rx, indent=4))
        input("press Enter to continue...")
        print("Modifying password for user 'otro'...")
        d_field = {'password': 'otro456'}
        d_where = {'username': 'otro'}
        sql_update_where('users', d_field, d_where)
        print("Record updated")
        rx = sql_read_all('users')
        print(json.dumps(rx, indent=4))
        input("press Enter to continue...")
        print("Deleting user 'otro'...")
        d_where = {'username': 'otro'}
        sql_delete_where('users', d_where)
        print("Record deleted")
        rx = sql_read_all('users')
        print(json.dumps(rx, indent=4)) """
    except Exception as e:
        print(e)
    cnx.close()

