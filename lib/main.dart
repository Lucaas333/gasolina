import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //definiçao da pagina inicial do app
    home: Home(),
    //tirar o Debug
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alcool = TextEditingController();
  TextEditingController gasolina = TextEditingController();

  String _texto = "Informe o preço dos combustíveis!"; //texto inicial

  //GlobalKey para validar o formulário
  GlobalKey<FormState> _validacao = GlobalKey<FormState>();

  void _limparCampos() {
    //limpa os campos
    alcool.text = '';
    gasolina.text = '';

    //atualizar o estado para mostrar o texto inicial e recriar a chave global
    setState(() {
      _texto = "Informe o preço dos combustíveis!";
      _validacao = GlobalKey<FormState>();
    });
  }

  void calcularCombustivel() {
    double alcoolDigitado = double.parse(alcool.text);
    double gasolinaDigitada = double.parse(gasolina.text);
    double combustivel = alcoolDigitado / gasolinaDigitada;

    //Atualizar o estado e mostrar resultado
    setState(() {
      if (combustivel < 0.7) {
        _texto = "Abasteça em Alcool: (${combustivel.toStringAsPrecision(3)})";
      } else if (combustivel >= 0.7) {
        _texto = "Abasteça em Gasolina: (${combustivel.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Combustível"),
        backgroundColor: Colors.red, //cor de fundo do appbar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparCampos,
          )
        ],
      ),
      backgroundColor: Colors.white, //cor de fundo do app
      body: SingleChildScrollView(
        padding:
            EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0), //Espaçamento das barras
        child: Form(
          key: _validacao, //chave global do formulario
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, //preencher a largura
            children: <Widget>[
              Icon(Icons.local_gas_station, size: 120.0, color: Colors.red),
              TextFormField(
                keyboardType: TextInputType.number, //teclado numerico
                decoration: InputDecoration(
                    labelText: "Alcool RS",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 25.0),
                controller: alcool,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira o valor do Alcool!";
                  }
                },
              ),
              TextFormField(
                  keyboardType: TextInputType.number, //teclado numerico
                  decoration: InputDecoration(
                      labelText: "Gasolina RS",
                      labelStyle: TextStyle(color: Colors.red)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 25.0),
                  controller: gasolina,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira o valor da Gasolina";
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0, //altura do botao
                  child: ElevatedButton(
                    onPressed: () {
                      if (_validacao.currentState!.validate()) {
                        calcularCombustivel();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ),
              ),
              Text(
                _texto,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
