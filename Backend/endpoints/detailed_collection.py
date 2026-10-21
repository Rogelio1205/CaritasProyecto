from flask import Blueprint, jsonify, request
import mssql_functions as MSSql
from auth import token_required, role_required

collections_bp = Blueprint("collections", __name__)

@collections_bp.route("/collection", methods=['GET'])
#@token_required
#@role_required('recolector')
def getCollection():
    """
    Obtener Detalle de una Recolección
    ---
    description: |
      **Nombre del End-Point:** /collection
      **Descripción:** Consulta el detalle de una recolección específica: donante, estado, fecha, monto a recolectar, dirección, campaña (caso) con sus tags, método de pago y frecuencia de la promesa.
      **Uso en la App:** Se utiliza en la sección de recolección detallada.
      **Tipo:** GET
    parameters:
      - in: query
        name: id
        required: true
        description: Identificador único de la recolección (idRecoleccion)
        type: integer
    responses:
      200:
        description: Datos detallados de la recolección.
        schema:
          type: object
          properties:
            idRecoleccion:
              type: integer
            donante:
              type: string
            estado:
              type: string
            fecha:
              type: string
            montoARecolectar:
              type: number
            direccion:
              type: string
            campana:
              type: string
            tags:
              type: array
              items:
                type: string
            metodoPago:
              type: string
            frecuencia:
              type: string
      404:
        description: Recolección no encontrada.
        schema:
          type: object
          properties:
            error:
              type: string
              example: "Collection not found"
    """
    collectionId = request.args.get("id")
    row = MSSql.getDetailedCollection(collectionId)

    if not row:
        return jsonify({"error": "Collection not found"}), 404

    nombreCompleto = " ".join(
        part for part in (
            row["nombre"],
            row["apellidoPaterno"],
            row["apellidoMaterno"]
        ) if part
    )


    return jsonify({
        "idRecoleccion": row["idRecoleccion"],
        "donante": nombreCompleto,
        "estado": row["estado"],
        "fecha": row["fecha"],
        "montoARecolectar": row["montoARecolectar"],
        "direccion": row["direccion"],
        "campana": row["nombreCaso"],
        "tags": row["tags"],
        "metodoPago": row["formaPago"],
        "frecuencia": row["frecuencia"],
    })

@collections_bp.route("/collection/state", methods=['PUT'])
#@token_required
#@role_required('recolector')
def updateCollectionState():
    """
    Actualizar Estado de una Recolección
    ---
    description: |
      **Nombre del End-Point:** /collection/state
      **Descripción:** Cambia el estado de una recolección al estado indicado (idEstado).
      **Tipo:** PUT
    parameters:
      - in: body
        name: body
        required: true
        schema:
          type: object
          required:
            - idRecoleccion
            - idEstado
          properties:
            idRecoleccion:
              type: integer
            idEstado:
              type: integer
    responses:
      200:
        description: Estado actualizado correctamente.
        schema:
          type: object
          properties:
            message:
              type: string
              example: "Collection state updated"
      400:
        description: Datos inválidos o estado inexistente.
      404:
        description: Recolección no encontrada.
    """
    data = request.get_json(silent=True) or {}
    collectionId = data.get("idRecoleccion")
    newStateId = data.get("idEstado")

    if collectionId is None or newStateId is None:
        return jsonify({"error": "idRecoleccion and idEstado are required"}), 400

    result = MSSql.updateCollectionState(collectionId, newStateId)

    if result == "invalid_state":
        return jsonify({"error": "Invalid state id"}), 400
    if result == "not_found":
        return jsonify({"error": "Collection not found"}), 404

    return jsonify({"message": "Collection state updated"}), 200

@collections_bp.route("/collection/states", methods=['GET'])
#@token_required
#@role_required('recolector')
def getCollectionStates():
    """
    Obtener Estados de Recolección
    ---
    description: |
      **Nombre del End-Point:** /collection/states
      **Descripción:** Devuelve el catálogo de estados de recolección disponibles (ids 2, 3, 4 y 6) con su nombre.
      **Uso en la App:** Se utiliza para mostrar las opciones al cambiar el estado de una recolección (se combina con PUT /collection/state).
      **Tipo:** GET
    responses:
      200:
        description: Lista de estados de recolección.
        schema:
          type: array
          items:
            type: object
            properties:
              idEstado:
                type: integer
                example: 2
              nombre:
                type: string
                example: "Completada"
    """
    states = MSSql.getCollectionStates()

    return jsonify([
        {
            "idEstado": row["idEstado"],
            "nombre": row["nombre"],
        }
        for row in states
    ]), 200