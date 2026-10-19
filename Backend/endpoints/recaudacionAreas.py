from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql
from auth import token_required, role_required # <- Se agrego para el JWT
from auth import logger #<- para el syslog

recaudacionArea_bp = Blueprint("recaudacionArea", __name__)

@recaudacionArea_bp.route("/casosActivos", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getCasosActivos(current_user):
    """
    Se obtiene la informacion de los casos activos
    ---
    description: Retorna una lista con la informacion de los casos activos
    responses:
      200:
        description: Lista de JSONs con los casos activos
        schema:
          type: array
          items:
            type: object
            properties:
              idCaso:
                type: int
              nombre:
                type: string
              descripcion:
                type: string
              totalPagado:
                type: float
      500:
        description: No se pudo obtener la informacion de los casos activos
        schema:
          type: object
          properties:
            error:
              type: string
    """
    try:
        filaRecaudacionArea = MSSql.getrowcasosActivos()
        return jsonify(filaRecaudacionArea), 200
    except Exception as e:
        logger.error(f"/casosActivos: {e}")
        return jsonify({"error": "Casos activos not found"}), 500

    #return jsonify(filaRecaudacionArea), 200

@recaudacionArea_bp.route("/graficasInfo", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getInfoGraficas(current_user):
    """
     Se obtiene la informacion de las graficas
    ---
    description: Retorna una lista del top cinco de los casos que mas han recaudado
    responses:
      200:
        description: Regresa una lista JSONs con la informacion del top 5 de casps en los que mas se han recaudado
        schema:
          type: array
          items:
            type: object
            properties:
              idCaso:
                type: int
              nombre:
                type: string
              montoSolicitado:
                type: float
              totalPagado:
                type: float
      500:
        description: No se pudo obtener la informacion de los casosd e las graficas
        schema:
          type: object
          properties:
            error:
              type: string
    """
    try:
        infoGraficas = MSSql.getGraficas()
        return jsonify(infoGraficas), 200
    except Exception as e:
        logger.error(f"/graficasInfo: {e}") 
        return jsonify({"error": "Info Graphs not found"}), 500

@recaudacionArea_bp.route("/widgets", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getInfoWidgets(current_user):
    """
    Se obtiene la informacion de los widgets
    ---
    description: Retorna la informacion para los 3 widgets
    responses:
       200:
        description: Retorna un JSON con la informaicon de los tres widgets
        shcema: 
          type: object
          properties:
            areasActivas:
              type: int
            porRecaudar:
              type: float
            totalRecaudado: 
              type: float
        500:
        description: No se pudo obtener la informacion de los widgets
        schema: 
          type: object
          properties:
            error: 
              type: string
    """
    try:
        widgets = MSSql.infoWidgets()
        return jsonify(widgets), 200
    except Exception as e: 
        logger.error(f"/widgets: {e}")
        return jsonify({"error":"Info widgets not found"}), 500