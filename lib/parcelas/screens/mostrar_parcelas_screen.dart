import 'dart:convert';

import 'package:agri_espe/parcelas/widgets/Datos_Parcelas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agri_espe/var_globals.dart' as globals;

class MostrarParcelasScreen extends StatefulWidget {
  const MostrarParcelasScreen({Key? key}) : super(key: key);

  @override
  State<MostrarParcelasScreen> createState() => MostrarParcelasScreenState();
}

class MostrarParcelasScreenState extends State<MostrarParcelasScreen> {

  @override
  void initState() {
    super.initState();
    _inition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _inition(){
    if(mounted){
      setState(() {
        globals.parcelas.clear();
      });
      mostrarParcelas();
    }
  }

  Future<dynamic> mostrarParcelas() async {
    try {
      var url = Uri.parse('http://localhost:9093/parcelas/get/?src=mysql');
      print(url);
      final headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      };
      final response = await http.get(url, headers: headers);
      print(response.statusCode);
      
      if (response.statusCode == 200) {
        print('aqui ${response.statusCode}');
        final List<Datos_Parcelas> resultados = [];
        final data = json.decode(response.body);
        final soli = data as List<dynamic>;
        for (var solis in soli) {
          resultados.add(Datos_Parcelas.fromJson(solis));
        }

        print('aqui mi lista---- ' + resultados.toString());
        setState((() {
              globals.parcelas.addAll(resultados);
        }));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
