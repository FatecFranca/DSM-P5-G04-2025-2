
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // URL base da sua API na nuvem
  static const String _baseUrl = 'http://20.150.192.36';

  // Endpoint de login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'E-mail': email,
        'Senha': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Lança uma exceção com a mensagem de erro da API ou uma padrão
      throw Exception(jsonDecode(response.body)['error'] ?? 'Falha no login');
    }
  }

  // Endpoint de cadastro de usuário
  Future<Map<String, dynamic>> register({
    required String nome,
    required String cpf,
    required String email,
    required String senha,
    String? cep, // Opcional
    String? dataNasc, // Opcional
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'Nome': nome,
        'CPF': cpf,
        'E-mail': email,
        'Senha': senha,
        'Cep': cep,
        'data_nasc': dataNasc,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      // Lança uma exceção com a mensagem de erro da API ou uma padrão
      throw Exception(jsonDecode(response.body)['error'] ?? 'Falha no cadastro');
    }
  }
}
