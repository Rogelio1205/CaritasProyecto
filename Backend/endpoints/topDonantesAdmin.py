from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql
from auth import token_required, role_required #<- Se agrego para el jwt
from auth import logger #<- para el syslog

topDonantesAdmin_bp = Blueprint("topDonantesAdmin", __name__)

@topDonantesAdmin_bp.route("/donantesTopRow", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getTopDiez(current_user):
    """
    Se obtiene la informacion del top 10% de donantes
    ---
    description: Retorna una lista con los donantes que conforman el top 10%
    responses:
      200:
        description: Regresa una lista de JSONs con la informacion del top 10% de donantes
        schema:
          type: array
          items:
            type: object
            properties:
              idDonante:
                type: integer
              nombre:
                type: string
              apellidoPaterno:
                type: string
              totalDonado:
                type: number
              numDonaciones:
                type: integer
      500:
        description: No se pudo obtener la informacion del top 10% de donantes
        schema:
          type: object
          properties:
            error:
              type: string
    """
    try:
        rowDonantesTop = MSSql.getDonantesTopDiez()
        return jsonify(rowDonantesTop), 200
    except Exception as e:
        logger.error(f"/donantesTopRow: {e}")
        return jsonify({"error": "Top donantes Row not found"}), 500

@topDonantesAdmin_bp.route("/promedioDonantes", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getPromedioDonante(current_user):
    """
    Se obtiene el monto donado promedio por el top 10% de donantes y el resto
    ---
    description: Retorna los dos montos promedio de las dos categorias de donantes
    responses:
      200:
        description: Regresa un json con los dos montos promedio
        schema:
          type: object
          properties:
            promedioTop:
              type: number
            promedioResto:
              type: number
      500:
        description: No se pudieron obtener los montos promedio
        schema:
          type: object
          properties:
            error:
              type: string
    """
    try:
        monto = MSSql.getMontoPromedioDonante()
        return jsonify(monto), 200
    except Exception as e:
        logger.error(f"/promedioDonantes: {e}")
        return jsonify({"error": "Montos not found"}), 500

@topDonantesAdmin_bp.route("/aportacionesTotal", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getAportaciones(current_user):
    """
    Se obtiene el porcentaje de aportacion de los donantes top 10%
    ---
    description: Retorna el porcentaje
    responses:
      200:
        description: Regresa un json con el porcentaje
        schema:
          type: object
          properties:
            porcentajeTop:
              type: number
      500:
        description: No se pudo obtener el porcentaje
        schema:
          type: object
          properties:
            error:
              type: string
    """
    try:
        aportaciones = MSSql.getAportacioinTotal()
        return jsonify(aportaciones), 200
    except Exception as e:
        logger.error(f"/aportacionesTotal: {e}")
        return jsonify({"error": "Aportaciones not found"}), 500

@topDonantesAdmin_bp.route("/widgetsTop", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getWidgetsTop(current_user):
    """
    Se obtienen los datos de los widgets
    ---
    description: Retorna los valores de los widgets
    responses:
      200:
        description: Regresa un json con los valores de los widgets
        schema:
          type: object
          properties:
            promedioTop:
              type: number
            promedioResto:
              type: number
            numDonantesTop:
              type: integer
      500:
        description: No se pudo obtener la info de los widgets
        schema:
          type: object
          properties:
            error:
              type: string
    """
    try:
        widgetsTop = MSSql.getTopDiezWidgets()
        return jsonify(widgetsTop), 200
    except Exception as  e:
        logger.error(f"/widgetsTop: {e}")
        return jsonify({"error": "Widgets top not found"}), 500