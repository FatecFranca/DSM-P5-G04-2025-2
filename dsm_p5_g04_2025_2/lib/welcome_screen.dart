import 'package:flutter/material.dart';
import 'package:dsm_p5_g04_2025_2/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos a cor de fundo do seu design
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Espaçamento superior para centralizar melhor o conteúdo
                SizedBox(height: 60),

                // 1. Ícone dos grãos de café
                Image.asset(
                  'assets/images/Graos.png', // <-- MUDE AQUI
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 32),

                // 2. Texto de boas-vindas genérico
                Text(
                  'Bem vindo ao CaféZen!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A543D), // Verde escuro do design
                  ),
                ),
                SizedBox(height: 16),

                // 3. Texto de descrição
                Text(
                  'O CaféZen foi criado para ajudar você a encontrar equilíbrio entre sua rotina, o estresse e o consumo de café. Aqui, você poderá monitorar seus hábitos e descobrir qual é a quantidade ideal de café para manter energia e bem-estar de forma saudável.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5, // Melhora a legibilidade do parágrafo
                  ),
                ),
                SizedBox(height: 48),

                // 4. Grid de funcionalidades (2x2)
                // Usamos duas Rows, cada uma com dois itens
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFeatureItem(
                        iconPath: 'assets/images/monitor_cafe_icon.png', // <-- MUDE AQUI
                        label: 'Monitorar café'),
                    _buildFeatureItem(
                        iconPath: 'assets/images/reduzir_estresse_icon.png', // <-- MUDE AQUI
                        label: 'Reduzir estresse'),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFeatureItem(
                        iconPath: 'assets/images/progresso_icon.png', // <-- MUDE AQUI
                        label: 'Acompanhar progresso'),
                    _buildFeatureItem(
                        iconPath: 'assets/images/ia_icon.png', // <-- MUDE AQUI
                        label: 'Análise feita com IA'),
                  ],
                ),
                SizedBox(height: 48),

                // 5. Botão "Começar"
                SizedBox(
                  width: double.infinity, // Ocupa toda a largura
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Começar',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF16A66D), // Verde do botão
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // 6. Botão secundário
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione a navegação ou ação para este botão
                    },
                    child: Text(
                      'Sua jornada para o equilíbrio começa agora',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFC78D6F), // Cor do texto do botão
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF8E9DE), // Cor de fundo do botão
                      elevation: 0, // Sem sombra
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
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
    );
  }

  // Widget auxiliar para criar os itens de funcionalidades e evitar repetição de código
  Widget _buildFeatureItem({required String iconPath, required String label}) {
    return Column(
      children: [
        Image.asset(iconPath, width: 48, height: 48),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}