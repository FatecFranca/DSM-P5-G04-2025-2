import 'package:flutter/material.dart';
import 'dart:math'; // Para a lógica de simulação
import 'package:dsm_p5_g04_2025_2/result_screen.dart'; // Para a nova tela

class HabitsFormScreen extends StatefulWidget {
  @override
  _HabitsFormScreenState createState() => _HabitsFormScreenState();
}

class _HabitsFormScreenState extends State<HabitsFormScreen> {
  // Controladores para os campos de texto
  final _ageController = TextEditingController(text: '25');
  final _coffeeConsumptionController = TextEditingController(text: '3');
  final _caffeineController = TextEditingController(text: '200');
  final _sleepHoursController = TextEditingController(text: '8');
  final _imcController = TextEditingController(text: '22.5');
  final _heartRateController = TextEditingController(text: '50');
  final _activityController = TextEditingController(text: '5');

  // Variáveis para os dropdowns e switches
  String? _selectedGender;
  String? _selectedCountry;
  String? _selectedSleepQuality;
  String? _selectedHealthProblem;
  String? _selectedOccupation;
  bool _smokes = false;
  bool _drinksAlcohol = true;

  @override
  void dispose() {
    _ageController.dispose();
    _coffeeConsumptionController.dispose();
    _caffeineController.dispose();
    _sleepHoursController.dispose();
    _imcController.dispose();
    _heartRateController.dispose();
    _activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0), // Cor de fundo cinza claro
      // 1. AppBar personalizada
      appBar: AppBar(
        backgroundColor: Color(0xFFB88A6E), // Tom de marrom/laranja
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'SEUS HÁBITOS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/cafezen_icon.png', // Verifique o nome do seu ícone
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 2. Card: Perfil Pessoal
              _buildFormCard(
                icon: Icons.person,
                iconColor: Colors.green,
                title: 'Perfil Pessoal',
                children: [
                  _buildTextField(
                    label: 'Idade',
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildDropdownField(
                    label: 'Gênero',
                    hint: 'Selecione o seu gênero',
                    value: _selectedGender,
                    items: ['Masculino', 'Feminino', 'Outro'],
                    onChanged: (value) =>
                        setState(() => _selectedGender = value),
                  ),
                  _buildDropdownField(
                    label: 'País',
                    hint: 'Selecione o seu país',
                    value: _selectedCountry,
                    items: ['Brasil', 'Portugal', 'Estados Unidos', 'Outro'],
                    onChanged: (value) =>
                        setState(() => _selectedCountry = value),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // 3. Card: Hábitos com Café
              _buildFormCard(
                icon: Icons.coffee,
                iconColor: Colors.lightGreen,
                title: 'Hábitos com Café',
                children: [
                  _buildTextField(
                    label: 'Consumo diário de café (xícaras)',
                    controller: _coffeeConsumptionController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    label: 'Cafeína estimada',
                    controller: _caffeineController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              SizedBox(height: 16),

              // 4. Card: Qualidade do Sono
              _buildFormCard(
                icon: Icons.nightlight_round,
                iconColor: Colors.black,
                title: 'Qualidade do Sono',
                children: [
                  _buildTextField(
                    label: 'Horas de sono',
                    controller: _sleepHoursController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildDropdownField(
                    label: 'Qualidade do sono',
                    hint: 'Como avalia seu sono',
                    value: _selectedSleepQuality,
                    items: [
                      'Muito bom',
                      'Bom',
                      'Regular',
                      'Ruim',
                      'Muito ruim',
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedSleepQuality = value),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // 5. Card: Saúde Física
              _buildFormCard(
                icon: Icons.favorite,
                iconColor: Colors.lightGreen.shade300,
                title: 'Saúde Física',
                children: [
                  _buildTextField(
                    label: 'IMC',
                    controller: _imcController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Não sei meu IMC'),
                    ),
                  ),
                  _buildTextField(
                    label: 'Frequência cardíaca em repouso',
                    controller: _heartRateController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildDropdownField(
                    label: 'Problemas de saúde',
                    hint: 'Como está sua saúde',
                    value: _selectedHealthProblem,
                    items: [
                      'Excelente',
                      'Boa',
                      'Com problemas crônicos',
                      'Em tratamento',
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedHealthProblem = value),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // 6. Card: Atividade Física
              _buildFormCard(
                icon: Icons.fitness_center,
                iconColor: Colors.green.shade800,
                title: 'Atividade Física',
                children: [
                  _buildTextField(
                    label: 'Atividade física semanal (horas)',
                    controller: _activityController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              SizedBox(height: 16),

              // 7. Card: Ocupação
              _buildFormCard(
                icon: Icons.work,
                iconColor: Colors.blueGrey,
                title: 'Ocupação',
                children: [
                  _buildDropdownField(
                    label: 'Área de trabalho',
                    hint: 'Qual a sua área de trabalho',
                    value: _selectedOccupation,
                    items: [
                      'Escritório',
                      'Trabalho manual',
                      'Estudante',
                      'Autônomo',
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedOccupation = value),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // 8. Card: Outros Hábitos
              _buildFormCard(
                title: 'Outros Hábitos',
                children: [
                  _buildSwitchField(
                    label: 'Fuma?',
                    value: _smokes,
                    onChanged: (value) => setState(() => _smokes = value),
                  ),
                  _buildSwitchField(
                    label: 'Consome álcool?',
                    value: _drinksAlcohol,
                    onChanged: (value) =>
                        setState(() => _drinksAlcohol = value),
                  ),
                ],
              ),
              SizedBox(height: 32),

              // 9. Botão Final
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // --- LÓGICA DE CÁLCULO (SIMULAÇÃO) ---
                    // No futuro, você usará os valores dos controllers para uma lógica real.
                    // Por agora, vamos escolher um resultado aleatório para testar a tela.
                    final random = Random();
                    final stressLevels =
                        StressLevel.values; // Pega a lista [Baixo, Medio, Alto]
                    final randomLevel =
                        stressLevels[random.nextInt(stressLevels.length)];

                    // Navega para a tela de resultado, enviando o nível calculado
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(level: randomLevel),
                      ),
                    );
                  },
                  child: Text(
                    'Calcular estresse',
                    // ...
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
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES PARA EVITAR REPETIÇÃO ---

  // Constrói um Card customizado para cada seção do formulário
  Widget _buildFormCard({
    IconData? icon,
    Color? iconColor,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  CircleAvatar(
                    backgroundColor: iconColor?.withOpacity(0.1),
                    child: Icon(icon, color: iconColor),
                  ),
                  SizedBox(width: 12),
                ],
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  // Constrói um campo de texto com label
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // Constrói um campo de dropdown com label
  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint, style: TextStyle(color: Colors.grey[600])),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // Constrói um campo de switch com label
  Widget _buildSwitchField({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Switch(value: value, onChanged: onChanged, activeColor: Colors.green),
      ],
    );
  }
}
