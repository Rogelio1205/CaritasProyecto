from flask import Blueprint, jsonify
import mssql_functions as MSSql

DonanteRiesgo_bp = Blueprint("DonanteRiesgo", __name__)

@DonanteRiesgo_bp.route("/donanteRiesgo")
def getDonantesRiesgo():

    return jsonify(MSSql.getDonanteRiesgo())
