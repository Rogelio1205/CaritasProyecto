import os
from dotenv import load_dotenv
import datetime
import logging
import logging.handlers
from functools import wraps

import jwt     
import pytz    
from flask import jsonify, request, make_response

load_dotenv()

# --- SysLog ---
logger = logging.getLogger('api_caritas')
logger.setLevel(logging.INFO)
if not logger.handlers:
    syslog_handler = logging.handlers.SysLogHandler(
        address=('localhost', 514),
        facility=logging.handlers.SysLogHandler.LOG_LOCAL5
    )
    syslog_handler.setFormatter(logging.Formatter('api_caritas: %(levelname)s %(message)s'))
    logger.addHandler(syslog_handler)


TOKENS_SECRET_KEY = os.getenv('TOKENS_SECRET_KEY')
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
