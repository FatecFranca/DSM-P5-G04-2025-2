import 'package:dsm_p5_g04_2025_2/login_screen.dart';
import 'package:dsm_p5_g04_2025_2/profile_screen.dart';
import 'package:dsm_p5_g04_2025_2/services/api_service.dart';
import 'package:flutter/material.dart';

class HabitsFormScreen extends StatefulWidget {
  @override
  _HabitsFormScreenState createState() => _HabitsFormScreenState();
}

class _HabitsFormScreenState extends State<HabitsFormScreen> {
  // Chave para o formulário
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  bool _isLoading = false;

  // Controladores para os campos de texto
  final _ageController = TextEditingController();
  final _coffeeConsumptionController = TextEditingController();
  final _sleepHoursController = TextEditingController();
  final _heightController = TextEditingController(); // Novo
  final _weightController = TextEditingController(); // Novo
  final _heartRateController = TextEditingController();
  final _activityController = TextEditingController();

  // Variáveis para os dropdowns e switches
  String? _selectedGender;
  String? _selectedCountry;
  String? _selectedSleepQuality;
  String? _selectedHealthProblem;
  String? _selectedOccupation;
  bool _smokes = false;
  bool _drinksAlcohol = false;

  @override
  void dispose() {
    _ageController.dispose();
    _coffeeConsumptionController.dispose();
    _sleepHoursController.dispose();
    _heightController.dispose(); // Novo
    _weightController.dispose(); // Novo
    _heartRateController.dispose();
    _activityController.dispose();
    super.dispose();
  }

  // Função para enviar o formulário
  void _submitForm() async {
    // Primeiro, valida o formulário
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Calcula o IMC: peso / (altura * altura)
      final double height = double.tryParse(_heightController.text) ?? 0.0;
      final double weight = double.tryParse(_weightController.text) ?? 0.0;
      final double imc = (height > 0 && weight > 0) ? weight / (height * height) : 0.0;

      // Monta o corpo da requisição com base nos campos do controller
      final formData = {
        "Idade": int.tryParse(_ageController.text) ?? 0,
        "Genero": _selectedGender,
        "Pais": _selectedCountry,
        "xicarasDiaCafe": int.tryParse(_coffeeConsumptionController.text) ?? 0,
        "horasSono": double.tryParse(_sleepHoursController.text) ?? 0.0,
        "qualidadeDeSono": _selectedSleepQuality,
        "IMC": imc, // Envia o IMC calculado
        "frequenciaCardio": int.tryParse(_heartRateController.text) ?? 0,
        "problemasDeSaude": _selectedHealthProblem,
        "atvFisicaSemanalHrs": int.tryParse(_activityController.text) ?? 0,
        "Ocupacao": _selectedOccupation,
        "Fuma": _smokes.toString(),
        "Alcool": _drinksAlcohol.toString(),
      };

      try {
        // Verifica se o token existe
        if (authToken == null) {
          throw Exception("Usuário não autenticado. Faça o login novamente.");
        }

        // Chama o serviço da API
        await _apiService.submitHabitsForm(
          token: authToken!,
          formData: formData,
        );

        // Feedback de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Formulário enviado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navega para a tela de perfil após o sucesso
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
          (Route<dynamic> route) => false,
        );

      } catch (e) {
        // Feedback de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar: ${e.toString().replaceAll("Exception: ", "")}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Se a validação falhar, mostra uma mensagem
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, preencha todos os campos obrigatórios.'),
            backgroundColor: Colors.orangeAccent,
          ),
        );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFFB88A6E),
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
            child: Image.asset('assets/images/cafezen_icon.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Adiciona o widget Form com a chave
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildFormCard(
                  icon: Icons.person,
                  iconColor: Colors.green,
                  title: 'Perfil Pessoal',
                  children: [
                    _buildTextField(
                      label: 'Idade',
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    _buildDropdownField(
                      label: 'Gênero',
                      hint: 'Selecione o seu gênero',
                      value: _selectedGender,
                      items: ['Masculino', 'Feminino', 'Outro'],
                      onChanged: (value) => setState(() => _selectedGender = value),
                      validator: (value) => value == null ? 'Campo obrigatório' : null,
                    ),
                    _buildDropdownField(
                      label: 'País',
                      hint: 'Selecione o seu país',
                      value: _selectedCountry,
                      items: ['Brasil', 'Portugal', 'Estados Unidos', 'Outro'],
                      onChanged: (value) => setState(() => _selectedCountry = value),
                       validator: (value) => value == null ? 'Campo obrigatório' : null,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                _buildFormCard(
                  icon: Icons.coffee,
                  iconColor: Colors.lightGreen,
                  title: 'Hábitos com Café',
                  children: [
                    _buildTextField(
                      label: 'Consumo diário de café (xícaras)',
                      controller: _coffeeConsumptionController,
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                _buildFormCard(
                  icon: Icons.nightlight_round,
                  iconColor: Colors.black,
                  title: 'Qualidade do Sono',
                  children: [
                    _buildTextField(
                      label: 'Horas de sono',
                      controller: _sleepHoursController,
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    _buildDropdownField(
                      label: 'Qualidade do sono',
                      hint: 'Como avalia seu sono',
                      value: _selectedSleepQuality,
                      items: ['Muito bom', 'Bom', 'Regular', 'Ruim', 'Muito ruim'],
                      onChanged: (value) => setState(() => _selectedSleepQuality = value),
                      validator: (value) => value == null ? 'Campo obrigatório' : null,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                _buildFormCard(
                  icon: Icons.favorite,
                  iconColor: Colors.lightGreen.shade300,
                  title: 'Saúde Física',
                  children: [
                    _buildTextField(
                      label: 'Altura (m)',
                      controller: _heightController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    _buildTextField(
                      label: 'Peso (kg)',
                      controller: _weightController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    _buildTextField(
                      label: 'Frequência cardíaca em repouso',
                      controller: _heartRateController,
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    _buildDropdownField(
                      label: 'Problemas de saúde',
                      hint: 'Como está sua saúde',
                      value: _selectedHealthProblem,
                      items: ['Excelente', 'Boa', 'Com problemas crônicos', 'Em tratamento'],
                      onChanged: (value) => setState(() => _selectedHealthProblem = value),
                      validator: (value) => value == null ? 'Campo obrigatório' : null,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                _buildFormCard(
                  icon: Icons.fitness_center,
                  iconColor: Colors.green.shade800,
                  title: 'Atividade Física',
                  children: [
                    _buildTextField(
                      label: 'Atividade física semanal (horas)',
                      controller: _activityController,
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                    ),
                  ],
                ),
                SizedBox(height: 16),

                _buildFormCard(
                  icon: Icons.work,
                  iconColor: Colors.blueGrey,
                  title: 'Ocupação',
                  children: [
                    _buildDropdownField(
                      label: 'Área de trabalho',
                      hint: 'Qual a sua área de trabalho',
                      value: _selectedOccupation,
                      items: ['Escritório', 'Trabalho manual', 'Estudante', 'Autônomo'],
                      onChanged: (value) => setState(() => _selectedOccupation = value),
                      validator: (value) => value == null ? 'Campo obrigatório' : null,
                    ),
                  ],
                ),
                SizedBox(height: 16),

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
                      onChanged: (value) => setState(() => _drinksAlcohol = value),
                    ),
                  ],
                ),
                SizedBox(height: 32),

                // Botão que agora mostra o loading e chama _submitForm
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text(
                            'Enviar',
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
      ),
    );
  }

  // --- WIDGETS AUXILIARES COM VALIDAÇÃO ---

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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
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
          validator: validator,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
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
          validator: validator,
        ),
        SizedBox(height: 16),
      ],
    );
  }

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