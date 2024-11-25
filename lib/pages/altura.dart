import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Altura extends StatefulWidget {
  const Altura({super.key});

  @override
  State<Altura> createState() => _AlturaState();
}

class _AlturaState extends State<Altura> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();

  double totalAlturaHombres = 0;
  double totalAlturaMujeres = 0;
  int totalHombres = 0;
  int totalMujeres = 0;
  int totalEdadHombres = 0;
  int totalEdadMujeres = 0;
  int totalParticipantes = 0;

  void _agregarParticipante() {
    final double altura = double.tryParse(_alturaController.text) ?? 0.0;
    if (altura < 0) {
      _calcularPromedios();
      return;
    }

    final int edad = int.tryParse(_edadController.text) ?? 0;
    final int sexo = int.tryParse(_sexoController.text) ?? 0;

    setState(() {
      if (sexo == 1) {
        totalHombres++;
        totalAlturaHombres += altura;
        totalEdadHombres += edad;
      } else if (sexo == 2) {
        totalMujeres++;
        totalAlturaMujeres += altura;
        totalEdadMujeres += edad;
      } else {
        print("Sexo inválido. Usa '1' para hombres o '2' para mujeres.");
      }

      totalParticipantes++;
      _alturaController.clear();
      _edadController.clear();
      _sexoController.clear();
    });
  }

  void _calcularPromedios() {
    final double promedioAlturaHombres = totalHombres > 0 ? totalAlturaHombres / totalHombres : 0;
    final double promedioAlturaMujeres = totalMujeres > 0 ? totalAlturaMujeres / totalMujeres : 0;
    final double promedioEdad = totalParticipantes > 0 ? (totalEdadHombres + totalEdadMujeres) / totalParticipantes : 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Promedios'),
          content: Text(
            'Promedio de altura de los hombres: ${promedioAlturaHombres.toStringAsFixed(2)} cm\n'
            'Promedio de altura de las mujeres: ${promedioAlturaMujeres.toStringAsFixed(2)} cm\n'
            'Promedio de edad de los participantes: ${promedioEdad.toStringAsFixed(2)} años',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _mostrarPromedios() {
    _calcularPromedios();
  }

  void _borrarDatos() {
    setState(() {
      totalAlturaHombres = 0;
      totalAlturaMujeres = 0;
      totalHombres = 0;
      totalMujeres = 0;
      totalEdadHombres = 0;
      totalEdadMujeres = 0;
      totalParticipantes = 0;
      _alturaController.clear();
      _edadController.clear();
      _sexoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de Participantes'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _alturaController,
              decoration: const InputDecoration(labelText: 'Altura'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _edadController,
              decoration: const InputDecoration(labelText: 'Edad'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _sexoController,
              decoration: const InputDecoration(labelText: 'Sexo (1=Hombres, 2=Mujeres)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarParticipante,
              child: const Text('Agregar Participante'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _mostrarPromedios,
              child: const Text('Mostrar Promedios'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _borrarDatos,
              child: const Text('Borrar Datos'),
            ),
          ],
        ),
      ),
    );
  }
}