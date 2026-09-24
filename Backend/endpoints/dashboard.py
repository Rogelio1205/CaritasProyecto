from flask import Blueprint, jsonify, request
import mssql_functions as MSSql

dashboard_bp = Blueprint("dashboard", __name__)

@dashboard_bp.route("/dashboard")
def getDashboard():
    idUsuario = request.args.get("idUsuario")
    if not idUsuario:
        return jsonify({"error": "idUsuario requerido"}), 400
    return jsonify(MSSql.getDashboard(idUsuario))
