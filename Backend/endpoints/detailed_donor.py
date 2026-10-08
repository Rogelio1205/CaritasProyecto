from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql

donors_bp = Blueprint("donors", __name__)

@donors_bp.route("/donor", methods=['GET'])
def getDonor():
    """
    Obtener Detalle Completo de un Donante
    ---
    description: |
      **Nombre del End-Point:** /donor
      **Descripción:** Consulta la información detallada de un donante específico, incluyendo sus datos generales, teléfonos organizados por categoría, así como el historial de sus promesas de aportación y los pagos asociados. 
      **Uso en la App:** Se utiliza en la sección de donante detallado.
      **Tipo:** GET
    parameters:
      - in: query
        name: id
        required: true
        description: Identificador único del donante (idDonante)
        type: integer
    responses:
      200:
        description: Datos detallados del donante con sus listas de promesas y pagos.
        schema:
          type: object
          properties:
            nombre:
              type: string
            apellidoPaterno:
              type: string
            apellidoMaterno:
              type: string
            ultimaDonacion:
              type: string
            nivelRiesgo:
              type: string
            totalDonado:
              type: number
            telefonos:
              type: object
            informacionGeneral:
              type: object
            promesas:
              type: array
              items:
                type: object
            pagos:
              type: array
              items:
                type: object
      404:
        description: Error devuelto cuando el donante no es encontrado en la base de datos.
        schema:
          type: object
          properties:
            error:
              type: string
              example: "Donor not found"
    """
    donorId = request.args.get("id")
    rows = MSSql.getDetailedDonor(donorId)

    if not rows:
        return jsonify({"error": "Donor not found"}), 404

    donor = rows[0]

    donor["telefonos"] = {
        "casa": donor.pop("telCasa"),
        "movil": donor.pop("telPersonal"),
        "trabajo": donor.pop("telTrabajo"),
        "temporal": donor.pop("telTmp")
    }

    donor["informacionGeneral"] = {
        "tipoDonante": donor.pop("tipoDonante"),
        "clasificacion": donor.pop("nombreClas"),
        "donanteEspecial": donor.pop("donanteEspecial"),
        "excluido": donor.pop("excluido"),
        "fechaExclusion": donor.pop("fechaExclusion"),
        "correo": donor.pop("correo"),
        "estado": donor.pop("estado"),
        "fechaNacimiento": donor.pop("fechaNacimiento"),
        "direccion": donor.pop("direccion"),
    }

    donor["promesas"] = []
    donor["pagos"] = []

    for row in rows:

        if row["idPromesa"] is not None:
            donor["promesas"].append({
                "id": row["idPromesa"],
                "caso": row["nombreCaso"],
                "frecuencia": row["frecuencia"],
                "monto": row["monto"],
                "idEstado": row["idEstado"]
            })

        if row["idPago"] is not None:
            donor["pagos"].append({
                "id": row["idPago"],
                "idPromesa": row["idPromesa"],
                "fecha": row["fechaPago"],
                "importe": row["importe"],
                "estadoPago": row["estadoPago"]
            })

    donor.pop("idPromesa", None)
    donor.pop("nombreCaso", None)
    donor.pop("frecuencia", None)
    donor.pop("monto", None)
    donor.pop("idEstado", None)
    donor.pop("idPago", None)
    donor.pop("fechaPago", None)
    donor.pop("importe", None)
    donor.pop("estadoPago", None)

    return jsonify(donor)