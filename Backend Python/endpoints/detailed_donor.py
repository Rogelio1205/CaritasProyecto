from flask import Blueprint, Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql

donors_bp = Blueprint("donors", __name__)

@donors_bp.route("/donor")
def getDonor():
    donorId = request.args.get("id")
    donor = MSSql.getDetailedDonor(donorId)

    if donor:
        return jsonify(donor)

    return jsonify({"error": "Donor not found"}), 404