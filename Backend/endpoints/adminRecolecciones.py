from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql

adminRecolecciones_bp = Blueprint("adminRecolecciones", __name__)

@adminRecolecciones_bp.route("/adminRecDatos", methods=['GET'])
def getAdminRecDatos():
    try:
        datos = MSSql.datosGeneralesRecolecciones()
        return jsonify(datos), 200
    except Exception as e:
        print(f"Error en /adminRecDatos: {e}")
        return jsonify({"error": "Datos de recolecciones not found"}), 500

@adminRecolecciones_bp.route("/RecHoyStatus", methods=['GET'])
def getRecHoyStatus():
    try:
        datos = MSSql.statusHoyRec
        return jsonify(datos), 200
    except Exception as e:
        print(f"Error en /statusHoyRec: {e}")
        return jsonify({"error": "Datos de recolecciones de hoy not found"}), 500
