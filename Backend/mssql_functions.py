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

# -------------- Jaime -------------------
# Log in
def funcionLogin(table_name, userName, password):
    import pymssql
    import hashlib
    global cnx, mssql_params
    query = f"SELECT idUsuario, nombre, idRol, [userName], password_hash FROM {table_name} WHERE [userName] = %s"
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
            select TOP (10) Percent d.nombre, d.apellidoPaterno, CAST(SUM(pg.importe) as float) as totalDonado,COUNT(pg.idPago) as numDonaciones,
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
            c.nombre AS nombreCampana, sp.estado AS estatusPago, pa.formaPago, pa.fechaConfirmacion,
            CASE WHEN pa.cancelado = 1 THEN 'Sí' ELSE 'No' END AS cancelado,
            CASE WHEN pa.reprogramado = 1 THEN 'Sí' ELSE 'No' END AS reprogramado,
            pa.fechaReprogramacion, pa.importe AS monto
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
            group by {NIVEL}""")}

    en_riesgo = _query(
        f"""select top 4 idDonante, nombre, apellidoPaterno,
                   mesesSinDonar, {NIVEL} as nivel
            from ({RESUMEN}) x
            where mesesSinDonar >= 6 and mesesSinDonar < 36
            order by mesesSinDonar desc""")

    potenciales = _query(
        f"""select top 3 x.idDonante, x.nombre, x.apellidoPaterno,
                   x.mesesSinDonar, s.casosSimilares
            from ({RESUMEN}) x
            outer apply (
                select top 1 p2.idCaso
                from Promesa p2
                join Recoleccion r2 on r2.idPromesa = p2.idPromesa
                where p2.idDonante = x.idDonante and r2.montoRecibido > 0
                order by r2.fecha desc
            ) ult
            outer apply (
                select count(distinct t2.idCaso) as casosSimilares
                from CasoAreaTag t2
                where t2.idCaso <> ult.idCaso
                  and t2.idAreaTag in (
                      select t1.idAreaTag from CasoAreaTag t1
                      where t1.idCaso = ult.idCaso)
            ) s
            where x.mesesSinDonar >= 18
            order by s.casosSimilares desc""")

    alto_valor = _query(
        f"""select top 4 idDonante, nombre, apellidoPaterno,
                   mesesSinDonar, totalDonado
            from ({RESUMEN}) x
            order by totalDonado desc""")

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
             "mesesSinDonar": r["mesesSinDonar"], "nivel": r["nivel"]}
            for r in en_riesgo],
        "donantesPotenciales": [
            {"idDonante": r["idDonante"], "nombre": _nombre(r),
             "mesesSinDonar": r["mesesSinDonar"],
             "casosSimilares": r["casosSimilares"] or 0}
            for r in potenciales],
        "donantesAltoValor": [
            {"idDonante": r["idDonante"], "nombre": _nombre(r),
             "mesesSinDonar": r["mesesSinDonar"],
             "totalDonado": float(r["totalDonado"] or 0)}
            for r in alto_valor],
    }

#Endpoint 2

def getDonantesRiesgo():
    conteo = {r["nivel"]: r["total"] for r in _query(
            f"""select {NIVEL} as nivel, count(*) as total
                from ({RESUMEN}) x
                group by {NIVEL}""")}
    en_riesgo = _query(
            f"""select idDonante, nombre, apellidoPaterno,
                       mesesSinDonar, {NIVEL} as nivel
                from ({RESUMEN}) x
                where mesesSinDonar >= 1
                order by mesesSinDonar desc""")
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

#FIN ROGELIO


if __name__ == '__main__':
    import json
    mssql_params = {}
    mssql_params['DB_HOST'] = '100.80.80.7'
    mssql_params['DB_NAME'] = 'CaritasBD'
    mssql_params['DB_USER'] = 'SA'
    mssql_params['DB_PASSWORD'] = 'Shakira123.'
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

