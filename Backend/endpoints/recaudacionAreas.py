from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql

recaudacionArea_bp = Blueprint("recaudacionArea", __name__)

@recaudacionArea_bp.route("/casosActivos", methods=['GET'])
def getCasosActivos():
    try:
        filaRecaudacionArea = MSSql.getrowcasosActivos()
        return jsonify(filaRecaudacionArea), 200
    except Exception:
        return jsonify({"error": "Casos activos not found"}), 500

    return jsonify(filaRecaudacionArea), 200

@recaudacionArea_bp.route("/graficasInfo", methods=['GET'])
def getInfoGraficas():
    try:
        infoGraficas = MSSql.getGraficas()
        return jsonify(infoGraficas), 200
    except Exception: 
        return jsonify({"error": "Info Graphs not found"}), 500

@recaudacionArea_bp.route("/widgets", methods=['GET'])
def getInfoWidgets():
    try:
        widgets = MSSql.infoWidgets()
        return jsonify(widgets), 200
    except Exception: 
        return jsonify({"error":"Info widgets not found"}), 500