import 'package:flutter/material.dart';
import 'package:dsm_p5_g04_2025_2/profile_screen.dart';

// Usamos um enum para representar os 3 possíveis resultados de forma segura.
enum StressLevel { Baixo, Medio, Alto }

class ResultScreen extends StatelessWidget {
  // A tela recebe o nível de estresse que deve ser exibido.
  final StressLevel level;

  const ResultScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    // 1. Variáveis que mudam de acordo com o nível de estresse
    String emoji;
    String levelText;
    Color levelColor;
    String description;

    // 2. Lógica para definir o conteúdo com base no resultado recebido
    switch (level) {
      case StressLevel.Baixo:
        emoji = '😊'; // Emoji de rosto feliz
        levelText = 'Baixo';
        levelColor = Colors.green;
        description =
            'Seu estresse está em um nível baixo. Ótimo trabalho em manter o equilíbrio!';
        break;
      case StressLevel.Medio:
        emoji = '😐'; // Emoji de rosto neutro (como na imagem)
        levelText = 'Médio';
        levelColor = Colors.orange;
        description =
            'Seu estresse está em um nível moderado. Pequenos ajustes podem ajudar.';
        break;
      case StressLevel.Alto:
        emoji = '😟'; // Emoji de rosto preocupado
        levelText = 'Alto';
        levelColor = Colors.red;
        description =
            'Seu estresse está em um nível alto. É importante buscar maneiras de relaxar.';
        break;
    }

    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      // 3. AppBar personalizada, idêntica ao design
      appBar: AppBar(
        backgroundColor: Color(0xFFB88A6E),
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Resultado',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza o conteúdo verticalmente
          children: [
            Spacer(), // Empurra o card para o centro
            // 4. Card principal com o resultado
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(emoji, style: TextStyle(fontSize: 80)),
                    SizedBox(height: 24),
                    // Usamos RichText para ter cores diferentes na mesma linha
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 22, color: Colors.black87),
                        children: [
                          TextSpan(text: 'Nível de estresse: '),
                          TextSpan(
                            text: levelText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: levelColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(), // Cria espaço entre o card e o botão
            // 5. Botão "Seu perfil" estilizado
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: Text(
                  'Seu perfil',
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
            SizedBox(height: 20), // Espaço na parte inferior
          ],
        ),
      ),
    );
  }
}
