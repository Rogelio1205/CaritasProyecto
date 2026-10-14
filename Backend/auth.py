import datetime
from functools import wraps

import jwt     
import pytz    
from flask import jsonify, request, make_response

TOKENS_SECRET_KEY = 'mi_llave_secretaEquipo4'
ROLES = {1: 'admin', 2: 'telefonista', 3: 'recolector'}

# Funcion para generar el token
def generar_token(usuario):
    utc_now = datetime.datetime.now(pytz.utc)
    return jwt.encode(
        {
            'username': usuario['userName'],
            'idUsuario': usuario['idUsuario'],
            'roles': [ROLES.get(usuario['idRol'])],
            'exp': utc_now + datetime.timedelta(minutes=60)
        },

        TOKENS_SECRET_KEY, algorithm='HS256'
    )

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get('x-access-token')
        if not token: 
            return jsonify({'message': 'Token es requerido'}), 401
        try:
            data = jwt.decode(token, TOKENS_SECRET_KEY, algorithms=['HS256'])
            current_user = data['username']
            roles = data['roles']

        except jwt.ExpiredSignatureError:
            return jsonify({'message': 'El token ha expirado'}), 401

        except jwt.InvalidTokenError:
            return jsonify({'message': 'Token invalido'}), 401  
        
        return f(current_user, roles, *args, **kwargs)
    return decorated

def role_required(requiredRole):
    def decorator(f):
        @wraps(f)
        def decorated(current_user,roles, *args, **kwargs):
            if requiredRole not in roles:
                return jsonify({'message': f'Access denied ({requiredRole} only)'}), 403
            return f(current_user, *args, **kwargs)
        return decorated
    return decorator
