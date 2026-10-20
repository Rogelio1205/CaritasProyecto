from flask import Blueprint, jsonify
import mssql_functions as MSSql

DonanteRiesgo_bp = Blueprint("DonanteRiesgo", __name__)
@DonanteRiesgo_bp.route("/donanteRiesgo")

def getDonanteRiesgo():
    return jsonify(MSSql.getDonantesRiesgo())
