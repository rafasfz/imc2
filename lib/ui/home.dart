import 'package:flutter/material.dart';
import 'result.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _resetFields() {
    weightController = TextEditingController();
    heightController = TextEditingController();
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.blueAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.blueAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Insira seu peso!";
                  else
                    return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (m)",
                    labelStyle: TextStyle(color: Colors.blueAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Insira sua altura!";
                  else
                    return null;
                },
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcular();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  void _calcular() {
    String _text = "";
    String _image = "";

    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);

    double imc = weight / (height * height);
    if (imc < 18.6) {
      _text = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      _image = "images/thin.png";
    } else if (imc >= 18.6 && imc < 24.9) {
      _text = "Peso ideal (${imc.toStringAsPrecision(4)})";
      _image = "images/shape.png";
    } else if (imc >= 24.9 && imc < 29.9) {
      _text = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      _image = "images/fat.png";
    } else if (imc >= 29.9 && imc < 34.9) {
      _text = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      _image = "images/fat.png";
    } else if (imc >= 34.9 && imc < 40) {
      _text = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      _image = "images/fat.png";
    } else if (imc >= 40) {
      _text = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      _image = "images/fat.png";
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Result(_image, _text)));
  }
}