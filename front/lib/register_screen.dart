
import 'package:dsm_p5_g04_2025_2/services/api_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cepController = TextEditingController();
  final _dataNascController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _cepController.dispose();
    _dataNascController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Função para converter a data do formato DD-MM-AAAA para AAAA-MM-DD
  String? _formatDateToApi(String? date) {
    if (date == null || date.length != 10) return null;
    try {
      final parts = date.split('-');
      if (parts.length != 3) return null;
      // Entrada: DD-MM-AAAA -> Saída: AAAA-MM-DD
      return '${parts[2]}-${parts[1]}-${parts[0]}';
    } catch (e) {
      return null;
    }
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Converte a data antes de enviar
      final formattedDate = _formatDateToApi(_dataNascController.text);

      try {
        await _apiService.register(
          nome: _nameController.text,
          cpf: _cpfController.text,
          email: _emailController.text,
          senha: _passwordController.text,
          cep: _cepController.text,
          dataNasc: formattedDate, // Usa a data formatada
        );

        Navigator.pop(context, {
          'email': _emailController.text,
          'password': _passwordController.text,
        });

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro no cadastro: ${e.toString().replaceAll("Exception: ", "")}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, bottom: 16, left: 24, right: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8D5A3C), Color(0xFFB88A6E)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/reduzir_estresse_icon.png',
                    height: 150,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'CRIAR CONTA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40),
                      _buildTextField(label: 'Nome', controller: _nameController),
                      SizedBox(height: 24),
                      _buildTextField(label: 'CPF', controller: _cpfController, keyboardType: TextInputType.number),
                      SizedBox(height: 24),
                      _buildTextField(label: 'CEP', controller: _cepController, keyboardType: TextInputType.number),
                      SizedBox(height: 24),
                      _buildTextField(label: 'Data de Nascimento', controller: _dataNascController, hintText: 'DD-MM-AAAA'),
                      SizedBox(height: 24),
                      _buildTextField(label: 'E-mail', controller: _emailController, keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 24),
                      _buildTextField(label: 'Senha', controller: _passwordController, isPassword: true),
                      SizedBox(height: 40),
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _register,
                                child: Text(
                                  'Criar Conta',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF16A66D),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 24),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Já tenho conta',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType? keyboardType,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hintText ?? (isPassword ? '••••••••' : ''),
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, preencha este campo';
            }
            if (label == 'CPF' && value.length != 11) {
              return 'CPF deve ter 11 dígitos';
            }
            if (label == 'CEP' && value.length != 8) {
              return 'CEP deve ter 8 dígitos';
            }
            // Validador para o formato de data DD-MM-AAAA
            if (label == 'Data de Nascimento') {
              final regex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
              if (!regex.hasMatch(value)) {
                return 'Use o formato DD-MM-AAAA';
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}