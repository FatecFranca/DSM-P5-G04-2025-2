from flask import request, jsonify
from models import db, Usuario

def init_routes(app):

    @app.route('/', methods=['GET'])
    def hello():
        return jsonify({"message": "Hello from CafeZen API!"})

    @app.route('/usuarios', methods=['POST'])
    def create_user():
        data = request.get_json()
        if not data or not all(k in data for k in ['Nome', 'CPF', 'E-mail', 'Senha', 'Cep', 'data_nasc']):
            return jsonify({'error': 'Missing data'}), 400

        if Usuario.query.filter_by(CPF=data['CPF']).first() or Usuario.query.filter_by(Email=data['E-mail']).first():
            return jsonify({'error': 'User with this CPF or E-mail already exists'}), 409

        new_user = Usuario(
            Nome=data['Nome'],
            CPF=data['CPF'],
            Email=data['E-mail'],
            Cep=data['Cep'],
            data_nasc=data['data_nasc']
        )
        new_user.set_password(data['Senha'])
        db.session.add(new_user)
        db.session.commit()

        return jsonify({'message': 'User created successfully', 'user_id': new_user.Id_usuario}), 201

    @app.route('/usuarios', methods=['GET'])
    def get_users():
        users = Usuario.query.all()
        return jsonify([{
            'Id_usuario': user.Id_usuario,
            'Nome': user.Nome,
            'CPF': user.CPF,
            'E-mail': user.Email,
            'Cep': user.Cep,
            'data_nasc': user.data_nasc.isoformat()
        } for user in users])
