import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({Key? key}) : super(key: key);

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  TextEditingController textFieldController = TextEditingController();
  final Map<String, double> conversionFactors = {
    'Square Meters': 1.0,
    'Square Kilometers': 0.000001,
    'Square Feet': 10.7639,
  };

  String fromUnit = 'Square Meters';
  String toUnit = 'Square Feet';
  double inputValue = 0.0;
  double convertedValue = 0.0;

  void clearTextField() {
    textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Area Converter"),
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
              decoration: InputDecoration(labelText: 'Value (in $fromUnit)'),
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
                  convertedValue = convertArea(inputValue);
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

  double convertArea(double value) {
    double fromFactor = conversionFactors[fromUnit]!;
    double toFactor = conversionFactors[toUnit]!;
    return value * (fromFactor / toFactor);
  }
}
