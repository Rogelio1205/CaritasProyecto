from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql

topDonantesAdmin_bp = Blueprint("topDonantesAdmin", __name__)

@topDonantesAdmin_bp.route("/donantesTopRow", methods=['GET'])
def getTopDiez():
    try:
        rowDonantesTop = MSSql.getDonantesTopDiez()
        return jsonify(rowDonantesTop), 200
    except Exception:
        return jsonify({"error": "Top donantes Row not found"}), 500

@topDonantesAdmin_bp.route("/promedioDonantes", methods=['GET'])
def getPromedioDonante():
    try:
        monto = MSSql.getMontoPromedioDonante()
        return jsonify(monto), 200
    except Exception:
        return jsonify({"error": "Montos not found"}), 500


@topDonantesAdmin_bp.route("/aportacionesTotal", methods=['GET'])
def getAportaciones():
    try:
        aportaciones = MSSql.getAportacioinTotal()
        return jsonify(aportaciones), 200
    except Exception:
        return jsonify({"error": "Aportaciones not found"}), 500

@topDonantesAdmin_bp.route("/widgetsTop", methods=['GET'])
def getWidgetsTop():
    try:
        widgetsTop = MSSql.getTopDiezWidgets()
        return jsonify(widgetsTop), 200
    except Exception:
        return jsonify({"error": "Widgets top not found"}), 500