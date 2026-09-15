from flask import Flask, jsonify, make_response, request, send_file
import json
import sys
import mssql_functions as MSSql

mssql_params = {}
mssql_params['DB_HOST'] = '10.14.255.41'
mssql_params['DB_NAME'] = 'caritasDB'
mssql_params['DB_USER'] = 'SA'
mssql_params['DB_PASSWORD'] = 'Shakira123.'

try:
    MSSql.cnx = MSSql.mssql_connect(mssql_params)
except Exception as e:
    print("Cannot connect to mssql server!: {}".format(e))
    sys.exit()

app = Flask(__name__)

@app.route("/hello")
def hello():
    return "Bark Psychosis rocks!\n"

@app.route("/user")
def user():
    username = request.args.get('username', None)
    #print(username)
    d_user = MSSql.read_user_data('users', username)
    return make_response(jsonify(d_user))

if __name__ == '__main__':
    print ("Running API...")
    app.run(host='0.0.0.0', port=10201, debug=True)