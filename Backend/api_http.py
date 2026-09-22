from flask import Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql
from endpoints.detailed_donor import donors_bp

# Connect to mssql dB from start
mssql_params = {}
mssql_params['DB_HOST'] = '100.80.80.7'
mssql_params['DB_NAME'] = 'CaritasBD'
mssql_params['DB_USER'] = 'SA'
mssql_params['DB_PASSWORD'] = 'Shakira123.'

try:
    MSSql.cnx = MSSql.mssql_connect(mssql_params)
except Exception as e:
    print("Cannot connect to mssql server!: {}".format(e))
    sys.exit()

app = Flask(__name__)

app.register_blueprint(donors_bp)

@app.route("/hello")
def hello():
    """
    Returns 'Shakira rocks!' as a keepalive
    ---
    responses:
        200:
        description: A successful response is "Shakira rocks"
    """
    return "Shakira rocks!\n"

@app.route("/user")
def infoUser():
    usern = request.args.get("nombre")
    d_user = MSSql.read_user_data('Usuario', usern)
    return make_response(jsonify(d_user))

@app.route("/login", methods=['POST'])
def logIn(): 
    data = request.json

    usuario = data.get("userName")
    password = data.get("password_hash")

    validUser = MSSql.funcionLogin('Usuario',usuario,password)
    
    if validUser:
        return make_response(jsonify({"nombre": validUser["nombre"], "idRol": validUser["idRol"]}))
    else:
        return make_response(jsonify({"error": "Usuario Invalido"}))

if __name__ == '__main__':
    print ("Running API...")
    app.run(host='0.0.0.0', port=10206, debug=True)

