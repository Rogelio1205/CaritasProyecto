from flask import Blueprint, jsonify, make_response, request
import mssql_functions as MSSql

promesas_bp = Blueprint("promesas", __name__)


@promesas_bp.route("/promesa/<int:idPromesa>", methods=['GET'])
def getPromesa(idPromesa):
    """
    Regresa el detalle de una promesa
    ---
    parameters:
      - name: idPromesa
        in: path
        type: integer
        required: true
    responses:
        200:
            description: monto, estado, fecha, frecuencia, tipoFrecuencia, formaPago, idCaso, nombreCaso y categorias (lista) de la promesa
        404:
            description: No existe una promesa con ese id
    """
    promesa = MSSql.getPromesaById(idPromesa)
    if not promesa:
        return jsonify({"error": "Promesa no encontrada"}), 404

    areaTags = MSSql.getAreaTagsByCaso(promesa["idCaso"])
    promesa["categorias"] = [tag["nombreAreaTag"] for tag in areaTags]

    return make_response(jsonify(promesa))


@promesas_bp.route("/estadosPromesa", methods=['GET'])
def getEstadosPromesa():
    """
    Regresa el catalogo de estados posibles de una promesa (Activa/Inactiva/etc)
    ---
    responses:
        200:
            description: Lista de {idEstado, nombre}
    """
    estados = MSSql.getEstadosPromesa()
    return make_response(jsonify(estados))