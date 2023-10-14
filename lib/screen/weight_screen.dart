import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  TextEditingController textFieldController = TextEditingController();
  final Map<String, double> conversionFactors = {
    'Kilograms': 1.0,
    'Grams': 1000,
    'Pounds': 2.20462,
  };

  String fromUnit = 'Kilograms';
  String toUnit = 'Grams';
  double inputValue = 0.0;
  double convertedValue = 0.0;
  void clearTextField() {
    textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unit Converter"),
        backgroundColor: Color.fromARGB(255, 9, 108, 95),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('From'),
                DropdownButton(
                  value: fromUnit,
                  items: conversionFactors.keys.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (selectedUnit) {
                    setState(() {
                      fromUnit = selectedUnit!;
                      clearTextField();
                      convertedValue = 0.0;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('To'),
                DropdownButton(
                  value: toUnit,
                  items: conversionFactors.keys.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (selectedUnit) {
                    setState(() {
                      toUnit = selectedUnit!;
                      clearTextField();
                      convertedValue = 0.0;
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: textFieldController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,}')),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Value(in $fromUnit)'),
              onChanged: (value) {
                setState(() {
                  inputValue = double.parse(value);
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  convertedValue = convertWeight(inputValue);
                });
              },
              child: Text("Convert"),
            ),
            SizedBox(height: 20.0),
            Text('Converted Value: $convertedValue $toUnit'),
          ],
        ),
      ),
    );
  }

  double convertWeight(double value) {
    double fromFactor = conversionFactors[fromUnit]!;
    double toFactor = conversionFactors[toUnit]!;
    return value * (fromFactor / toFactor);
  }
}
