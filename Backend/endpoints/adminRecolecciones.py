from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
from datetime import date
import mssql_functions as MSSql

adminRecolecciones_bp = Blueprint("adminRecolecciones", __name__)

@adminRecolecciones_bp.route("/adminRecDatos", methods=['GET'])
def getAdminRecDatos():
    mes = request.args.get('mes', default=date.today().month, type=int)
    if mes < 1 or mes > 12:
        return jsonify({"error": "mes debe estar entre 1 y 12"}), 400
    try:
        datos = MSSql.datosGeneralesRecolecciones(mes)
        return jsonify(datos), 200
    except Exception as e:
        print(f"Error en /adminRecDatos: {e}")
        return jsonify({"error": "Datos de recolecciones not found"}), 500

@adminRecolecciones_bp.route("/RecHoyStatus", methods=['GET'])
def getRecHoyStatus():
    try:
        datos = MSSql.statusHoyRec()
        return jsonify(datos), 200
    except Exception as e:
        print(f"Error en /statusHoyRec: {e}")
        return jsonify({"error": "Datos de recolecciones de hoy not found"}), 500

@adminRecolecciones_bp.route("/adminMainMontosRecaudacion", methods=['GET'])
def getMontosRecAdminMain():
    mes = request.args.get('mes', default=date.today().month, type=int)
    if mes < 1 or mes > 12:
        return jsonify({"error": "mes debe estar entre 1 y 12"}), 400
    try:
        datos = MSSql.adminMainRecMontos(mes)
        return jsonify(datos), 200
    except Exception as e:
        print(f"Error en /statusHoyRec: {e}")
        return jsonify({"error": "Datos de recolecciones de hoy not found"}), 500
    
@adminRecolecciones_bp.route("/adminMainWidgets", methods=['GET'])
def getAdminMainWidgets():
    try:
        datos = MSSql.widgetsAdmin()
        return jsonify(datos), 200
    except Exception as e:
        print(f"Error en /statusHoyRec: {e}")
        return jsonify({"error": "Datos de recolecciones de hoy not found"}), 500

@adminRecolecciones_bp.route("/graficasAdminMain", methods=['GET'])
def getAdminMainGraphs():
    mes = request.args.get('mes', default=date.today().month, type=int)
    if mes < 1 or mes > 12:
        return jsonify({"error": "mes debe estar entre 1 y 12"}), 400
    try:
        datos = MSSql.adminMainGraphs(mes)
        return jsonify(datos), 200
    except Exception as e:
        print(f"Error en /statusHoyRec: {e}")
        return jsonify({"error": "Datos de recolecciones de hoy not found"}), 500

@adminRecolecciones_bp.route("/adminMainCasosAct", methods=['GET'])
def getAdminMainCasosActivos():
    try:
        datos = MSSql.adminMainListaActCasos()
        return jsonify(datos), 200
    except Exception as e:
        print(f"Error en /statusHoyRec: {e}")
        return jsonify({"error": "Datos de recolecciones de hoy not found"}), 500
