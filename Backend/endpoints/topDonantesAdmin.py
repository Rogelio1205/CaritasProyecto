from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql
from auth import token_required, role_required #<- Se agrego para wl jwt

topDonantesAdmin_bp = Blueprint("topDonantesAdmin", __name__)

@topDonantesAdmin_bp.route("/donantesTopRow", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getTopDiez(current_user):
    """
    Se obtiene la informacion de un caso activo
    ---
    description: Retorna una liste de informacion de los distintos casos activos para colocarlos en la lista de la pantalla
    responses:
       200:
        description: Regresa una lista JSONs con los casos activos
        shcema: 
          type: object
          properties:
            idCaso:
              type: string
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
        rowDonantesTop = MSSql.getDonantesTopDiez()
        return jsonify(rowDonantesTop), 200
    except Exception:
        return jsonify({"error": "Top donantes Row not found"}), 500

@topDonantesAdmin_bp.route("/promedioDonantes", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getPromedioDonante(current_user):
    try:
        monto = MSSql.getMontoPromedioDonante()
        return jsonify(monto), 200
    except Exception:
        return jsonify({"error": "Montos not found"}), 500


@topDonantesAdmin_bp.route("/aportacionesTotal", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getAportaciones(current_user):
    try:
        aportaciones = MSSql.getAportacioinTotal()
        return jsonify(aportaciones), 200
    except Exception:
        return jsonify({"error": "Aportaciones not found"}), 500

@topDonantesAdmin_bp.route("/widgetsTop", methods=['GET'])
@token_required # <- Se agrego para el jwt
@role_required('admin') # <- Se agrego para el jwt
def getWidgetsTop(current_user):
    try:
        widgetsTop = MSSql.getTopDiezWidgets()
        return jsonify(widgetsTop), 200
    except Exception:
        return jsonify({"error": "Widgets top not found"}), 500