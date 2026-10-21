from flask import Blueprint, jsonify, make_response, request
import mssql_functions as MSSql

recolecciones_bp = Blueprint("recolecciones", __name__)


@recolecciones_bp.route("/recoleccion/<int:idRecoleccion>", methods=['GET'])
def getRecoleccion(idRecoleccion):
    """
    Regresa el detalle de una recoleccion (para la pantalla de Reprogramar)
    ---
    parameters:
      - name: idRecoleccion
        in: path
        type: integer
        required: true
    responses:
        200:
            description: nombre/direccion del donante, monto de la promesa, fecha y estado actuales de la recoleccion
        404:
            description: No existe una recoleccion con ese id
    """
    recoleccion = MSSql.getRecoleccionById(idRecoleccion)
    if not recoleccion:
        return jsonify({"error": "Recoleccion no encontrada"}), 404
    return make_response(jsonify(recoleccion))


@recolecciones_bp.route("/estadosRecoleccion", methods=['GET'])
def getEstadosRecoleccion():
    """
    Regresa el catalogo de estados posibles de una recoleccion
    ---
    responses:
        200:
            description: Lista de {idEstado, nombre}
    """
    estados = MSSql.getEstadosRecoleccion()
    return make_response(jsonify(estados))

@recolecciones_bp.route("/recoleccion/<int:idRecoleccion>/reprogramar", methods=['PATCH'])
def patchReprogramarRecoleccion(idRecoleccion):
    """
    Reprograma una recoleccion: guarda la nueva fecha, el motivo y el nuevo estado
    (la misma fila se actualiza, no se crea una recoleccion nueva)
    ---
    parameters:
      - name: idRecoleccion
        in: path
        type: integer
        required: true
      - name: body
        in: body
        required: true
        schema:
            type: object
            required: [nuevaFecha, motivo, idEstado]
            properties:
                nuevaFecha:
                    type: string
                    description: Fecha en formato YYYY-MM-DD
                motivo:
                    type: string
                    description: "Ej. 'No se encontraba', 'Sin fondos', 'Pidio otra fecha', 'Direccion incorrecta', 'Otro'"
                idEstado:
                    type: integer
                    description: idEstado de EstadosRecoleccion al que pasa la recoleccion (p.ej. 'No recolectada')
    responses:
        200:
            description: Recoleccion actualizada, se regresa el detalle completo
        400:
            description: Falta nuevaFecha, motivo o idEstado en el body
        404:
            description: No existe una recoleccion con ese id
    """
    data = request.json or {}
    nuevaFecha = data.get("nuevaFecha")
    motivo = data.get("motivo")
    idEstado = data.get("idEstado")

    if not nuevaFecha or not motivo or idEstado is None:
        return jsonify({"error": "nuevaFecha, motivo e idEstado son requeridos"}), 400

    filas = MSSql.reprogramarRecoleccion(idRecoleccion, nuevaFecha, motivo, idEstado)
    if filas == 0:
        return jsonify({"error": "Recoleccion no encontrada"}), 404

    return make_response(jsonify(MSSql.getRecoleccionById(idRecoleccion)))