from flask import Flask, jsonify, make_response, request, send_file
from endpoints.dashboard import dashboard_bp
import json
import sys
import mssql_functions as MSSql
from endpoints.detailed_donor import donors_bp
from endpoints.promesas import promesas_bp
from endpoints.pagos import pagos_bp
from flasgger import Swagger

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

swagger = Swagger(app, template= {
    "info": {
        "title": "API TC2007B",
        "description": "REST API para la materia TC2007B",
        "version": "1.0.0"
    } 
})

app.register_blueprint(donors_bp)
app.register_blueprint(promesas_bp)
app.register_blueprint(pagos_bp)
app.register_blueprint(dashboard_bp)

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

@app.route("/recolecciones", methods=['GET'])
def getRecolecciones():
    recArr = MSSql.getRecProximas()
    return make_response(jsonify(recArr))

@app.route("/recoleccionesMonto", methods=['GET'])
def getRecoleccionesMonto():
    recArr = MSSql.getRecProximasByMonto()
    return make_response(jsonify(recArr))

@app.route("/recoleccionesMontoSum", methods=['GET'])
def getRecoleccionesMontoSum():
    suma = MSSql.recMontoSum()
    return make_response(jsonify(suma))

@app.route("/numRecolecciones", methods=['GET'])
def getNumRecolecciones():
    num = MSSql.numRecSemanal()
    return make_response(jsonify(num))

@app.route("/login", methods=['POST'])
def logIn():
    """
    Validacion del usuario al entrar a la app (Endpoint log in)
    ---
    summary: Verifica que el correo y la contraseña de un usuario coincidan con la informacion de la BD
    description: Recibe un JSON con el usuario y contraseña. Regresa un JSOn con el nombre del usuario y su rol
    parameters:
    - name: body
      in: body
      required: true
      description: JSON con el correo del usuario y su contraseña
      schema: 
        type: object
        required: 
           - userName
           - password_hash
        properties: 
            userName: 
                type: string
            password_hash: 
                type: string

    responses:
      200:
        description: Si es un usuario valido regresa un JSON con el nombre del usuario y su idRol
        schema: 
          type: object
          properties:
            nombre: 
              type: string
            idRol: 
              type: integer
      400:
        description: El usuario no es valido, regresa un mensaje de error
        schema: 
          type: object
          properties:
            error: 
              type: string
    """
    data = request.json

    usuario = data.get("userName")
    password = data.get("password_hash")

    validUser = MSSql.funcionLogin('Usuario',usuario,password)

    if validUser:
        return make_response(jsonify({"nombre": validUser["nombre"], "idRol": validUser["idRol"]}),200)
    else:
        return make_response(jsonify({"error": "Usuario Invalido"}), 401)

if __name__ == '__main__':
    print ("Running API...")
    app.run(host='0.0.0.0', port=10206, debug=True)
