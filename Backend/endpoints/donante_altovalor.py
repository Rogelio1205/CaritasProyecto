from flask import Blueprint, jsonify
import mssql_functions as MSSql

DonanteAltoValor_bp = Blueprint("DonanteAltoValor", __name__)

@DonanteAltoValor_bp.route("/donantealtovalor", methods=["GET"])
def getDonantesAltoValor():
    return jsonify(MSSql.getDonantesAltoValor())
