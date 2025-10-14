import 'package:dsm_p5_g04_2025_2/habits_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:dsm_p5_g04_2025_2/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Variáveis para guardar o último usuário cadastrado (solução temporária)
  String? _lastRegisteredEmail;
  String? _lastRegisteredPassword;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(Duration(seconds: 1)); // Simula verificação

      // --- LÓGICA DE LOGIN CORRIGIDA ---
      String email = _emailController.text;
      String password = _passwordController.text;

      // Condição 1: Verifica o usuário de teste padrão
      bool isTestUser = (email == 'teste@cafezen.com' && password == '123456');

      // Condição 2: Verifica se é o usuário que acabou de ser cadastrado
      bool isLastRegisteredUser = (email == _lastRegisteredEmail && password == _lastRegisteredPassword);

      if (isTestUser || isLastRegisteredUser) {
        // --- NAVEGAÇÃO CORRIGIDA ---
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HabitsFormScreen()), // Vai para a tela de formulário
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('E-mail ou senha inválidos'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- FUNÇÃO PARA NAVEGAR E RECEBER DADOS DO CADASTRO ---
  void _navigateToRegisterScreen() async {
    // Usa 'await' para esperar a tela de cadastro fechar e devolver os dados
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );

    // Se a tela de cadastro devolveu dados...
    if (result != null && result is Map) {
      // Preenche os campos de login automaticamente
      _emailController.text = result['email'];
      _passwordController.text = result['password'];

      // Guarda os dados para a função _login() poder verificar
      _lastRegisteredEmail = result['email'];
      _lastRegisteredPassword = result['password'];
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadastro realizado! Faça o login para continuar.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // O seu código da interface (build) já estava ótimo, então foi mantido.
    // A única mudança foi no onPressed do botão "Criar conta".
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60),
                  Center(
                    child: Image.asset(
                      'assets/images/cafezen_icon.png',
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 60),
                  Text(
                    'E-mail',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Seu@email.com',
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
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Por favor, insira um e-mail válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Senha',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: '••••••••',
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
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
                      // --- CHAMADA DA FUNÇÃO CORRIGIDA ---
                      onPressed: _navigateToRegisterScreen, // Chama a nova função que espera os dados
                      child: Text(
                        'Criar conta',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}