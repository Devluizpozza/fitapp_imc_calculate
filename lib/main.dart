import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController weigthController = TextEditingController();
  final TextEditingController controllerheightController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = 'Informe seus dados!';

  void resetWeightHeight() {
    setState(() {
      weigthController.text = '';
      controllerheightController.text = '';
      _infoText = 'Informe seus dados!';
    });
  }

  void calculateIMC() {
    setState(() {
      double weight = double.parse(weigthController.text);
      double height = double.parse(controllerheightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(
            child: Text(
              'Calculadora de IMC',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: IconButton(
                icon: const Icon(
                  Icons.refresh,
                  size: 34,
                  color: Colors.white,
                ),
                onPressed: resetWeightHeight,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 150,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(
                      'Peso (kg)',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  controller: weigthController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor != null && valor.isEmpty) {
                      return 'Insira seu peso';
                    }
                    if (valor != null && valor.length < 3) {
                      return 'Insira um peso valido de pelo menos 3 digitos';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(
                      'Altura (cm)',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  controller: controllerheightController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor != null && valor.isEmpty) {
                      return 'Insira sua altura';
                    }
                    if (valor != null && valor.length < 3) {
                      return 'Insira uma altura valida de pelo menos 3 digitos';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            calculateIMC();
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const BeveledRectangleBorder(),
                        ),
                        child: const Text(
                          'Calcular',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _infoText,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
