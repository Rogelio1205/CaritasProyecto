from flask import Blueprint, jsonify, make_response
import mssql_functions as MSSql

pagos_bp = Blueprint("pagos", __name__)

@pagos_bp.route("/pago/<int:idPago>", methods=['GET'])
def getPago(idPago):
    """
    Regresa el detalle de un pago
    ---
    parameters:
      - name: idPago
        in: path
        type: integer
        required: true
    responses:
        200:
            description: Detalles completos del pago incluyendo status
        404:
            description: Id invalido
    """
    pago = MSSql.getPagoById(idPago)
    if not pago:
        return jsonify({"error": "Pago no encontrado"}), 404

    return make_response(jsonify(pago))