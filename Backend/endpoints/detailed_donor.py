from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql

donors_bp = Blueprint("donors", __name__)

@donors_bp.route("/donor")
def getDonor():
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

    donor["informacion general"] = {
        "tipoDonante": donor.pop("tipoDonante"),
        "clasificacion": donor.pop("idClasificacion"),
        "donanteEspecial": donor.pop("donanteEspecial"),
        "excluido": donor.pop("excluido"),
        "fechaExclusion": donor.pop("fechaExclusion"),
        "correo": donor.pop("correo")
    }

    donor["promesas"] = []

    for row in rows:
        if row["idPromesa"] is not None:
            donor["promesas"].append({
                "id": row["idPromesa"],
                "caso": row["nombreCaso"],
                "frecuencia": row["frecuencia"],
                "monto": row["monto"],
                "idEstado": row["idEstado"]
            })

    # Quitar campos de promesa que quedaron en donor
    donor.pop("idPromesa", None)
    donor.pop("nombreCaso", None)
    donor.pop("frecuencia", None)
    donor.pop("monto", None)
    donor.pop("idEstado", None)

    return jsonify(donor)