import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController(); // Adicionado campo CPF
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Lembre-se de fazer o dispose dos novos controllers
    _nameController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    // Valida o formulário antes de prosseguir
    if (_formKey.currentState!.validate()) {
      // Aqui você implementará a lógica de cadastro no futuro.
      // Por exemplo, enviar os dados para uma API.
      print('Cadastro válido!');
      print('Nome: ${_nameController.text}');
      print('CPF: ${_cpfController.text}');
      print('Email: ${_emailController.text}');
      
      // Após o cadastro, você pode navegar para a tela de login ou home.
      // Navigator.pop(context); // Exemplo para voltar à tela de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Usamos um Column como corpo principal para criar o cabeçalho customizado
      body: Column(
        children: [
          // 1. Cabeçalho customizado para corresponder ao design
          Container(
            padding: const EdgeInsets.only(top: 40, bottom: 16, left: 24, right: 24),
            decoration: BoxDecoration(
              // Gradiente de cor do design
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
              bottom: false, // SafeArea apenas no topo dentro do container
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 2. Ícone no cabeçalho
                  Image.asset(
                    'assets/images/reduzir_estresse_icon.png', 
                    height: 150,
                  ),
                  SizedBox(width: 16),
                  // 3. Título no cabeçalho
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
          // 4. Conteúdo do formulário com rolagem
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
                      // Campos do formulário estilizados
                      _buildTextField(label: 'Nome', controller: _nameController),
                      SizedBox(height: 24),
                      _buildTextField(label: 'CPF', controller: _cpfController, keyboardType: TextInputType.number),
                      SizedBox(height: 24),
                      _buildTextField(label: 'E-mail', controller: _emailController, keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 24),
                      _buildTextField(label: 'Senha', controller: _passwordController, isPassword: true),
                      SizedBox(height: 40),

                      // 5. Botão principal estilizado
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _register,
                          child: Text(
                            'Criar Conta', // Alterado de "Entrar" para algo mais apropriado
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF16A66D), // Verde do design
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // 6. Botão secundário para voltar ao login
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Volta para a tela anterior (LoginScreen)
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

  // Widget auxiliar para construir os campos de texto e evitar repetição
  Widget _buildTextField({required String label, required TextEditingController controller, bool isPassword = false, TextInputType? keyboardType}) {
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
            hintText: isPassword ? '••••••••' : '',
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
              // Validador simples de CPF, pode ser melhorado
              return 'CPF deve ter 11 dígitos';
            }
            return null;
          },
        ),
      ],
    );
  }
}