from flask import Blueprint, jsonify
import mssql_functions as MSSql

DonantePotencial_bp = Blueprint("DonantePotencial", __name__)

@DonantePotencial_bp.route("/donantepotencial", methods=["GET"])
def getDonantesPotencial():
    return jsonify(MSSql.getDonantesPotencial())
