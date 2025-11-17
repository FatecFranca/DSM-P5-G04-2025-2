import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // <-- 1. Import da biblioteca de gráficos
import 'package:dsm_p5_g04_2025_2/habits_form_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFB88A6E),
        elevation: 4,
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          child: Column(
            children: [
              _buildProfileCard(),
              SizedBox(height: 16),
              _buildMetricsGrid(),
              SizedBox(height: 16),
              _buildRecommendationCard(),
              SizedBox(height: 16),
              // 2. Chamada para o novo método do gráfico de barras
              _buildBarChartCard(),
              SizedBox(height: 16),
              // 3. Chamada para o novo método do gráfico de linhas
              _buildLineChartCard(),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HabitsFormScreen()),
                    );
                  },
                  child: Text(
                    'Atualizar Hábitos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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

  // --- WIDGETS AUXILIARES PARA CADA SEÇÃO (Cards Estáticos) ---

  Widget _buildProfileCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Seu Perfil', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2A543D))),
            SizedBox(height: 8),
            Text('Membro desde setembro de 2025', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 12),
            Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black87),
                children: [
                  TextSpan(text: '3 dias usando '),
                  TextSpan(
                    text: 'CaféZen',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8D5A3C)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid() {
     return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildMetricItem(icon: Icons.trending_down, value: '7.5', label: 'Estresse médio', color: Color(0xFFB88A6E))),
        SizedBox(width: 16),
        Expanded(child: _buildMetricItem(icon: Icons.nights_stay_outlined, value: '8h', label: 'Sono médio')),
        SizedBox(width: 16),
        Expanded(child: _buildMetricItem(icon: Icons.coffee_outlined, value: '0.9', label: 'Café\nconsumo médio', color: Color(0xFF16A66D))),
        SizedBox(width: 16),
        Expanded(child: _buildMetricItem(icon: Icons.fitness_center_outlined, value: '1h/dia', label: 'Exercício médio')),
      ],
    );
  }

  Widget _buildMetricItem({required IconData icon, required String value, required String label, Color color = Colors.black}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(backgroundColor: Colors.black, radius: 30, child: Icon(Icons.coffee, color: Colors.white, size: 30)),
            SizedBox(height: 12),
            Text('Recomendação', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '1 xícara/dia', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFB88A6E))),
                ]
              )
            ),
            SizedBox(height: 8),
            Text('Parabéns!!!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF16A66D))),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFF8E9DE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Sua média de consumo diário de café é 0,9 xícaras por dia, você está dentro do que é recomendado para o seu perfil',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFC78D6F)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- NOVOS WIDGETS AUXILIARES PARA OS GRÁFICOS ---

  // 4. Novo método para o gráfico de barras
  Widget _buildBarChartCard() {
    final List<double> weeklyConsumption = [2, 4, 2, 2, 2, 0, 1];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor: Colors.grey[800], radius: 15, child: Icon(Icons.coffee_outlined, color: Colors.white, size: 15)),
                SizedBox(width: 8),
                Text('Consumo de café (7 dias)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 120,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 5,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(weeklyConsumption.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: weeklyConsumption[index],
                          color: Color(0xFFB88A6E),
                          width: 15,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text('01/09 - 07/09/2025', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 16),
            Text('0.9', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFB88A6E))),
            Text('Xícaras por dia (média)', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  // 5. Novo método para o gráfico de linhas
  Widget _buildLineChartCard() {
    final List<FlSpot> stressData = [
      FlSpot(0, 3), FlSpot(1, 3), FlSpot(2, 3), FlSpot(3, 3),
      FlSpot(4, 4), FlSpot(5, 4), FlSpot(6, 3.5),
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.show_chart, color: Colors.green),
                SizedBox(width: 8),
                Text('Variação de estresse', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 120,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0, maxX: 6,
                  minY: 0, maxY: 10,
                  lineBarsData: [
                    LineChartBarData(
                      spots: stressData,
                      isCurved: true,
                      color: Color(0xFFB88A6E),
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(radius: 5, color: Color(0xFFB88A6E), strokeWidth: 0);
                        },
                      ),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Text('01/09 - 07/09/2025', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}