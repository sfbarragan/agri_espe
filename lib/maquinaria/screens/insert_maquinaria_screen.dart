import 'dart:convert';

import 'package:agri_espe/maquinaria/screens/mostrar_maquinaria_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agri_espe/var_globals.dart' as globals;

class InsertMaquinariaScreen extends StatefulWidget {
  const InsertMaquinariaScreen({Key? key}) : super(key: key);

  @override
  State<InsertMaquinariaScreen> createState() => InsertMaquinariaScreenState();
}

class InsertMaquinariaScreenState extends State<InsertMaquinariaScreen> {
  TextEditingController  tipoCtrl = new TextEditingController();
  TextEditingController  nombreCtrl = new TextEditingController();
  TextEditingController  marcaCtrl = new TextEditingController();
  TextEditingController  estadoCtrl = new TextEditingController();

  List<bool> _validate = [false, false, false, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Ingreso de Maquinarias')),
      body: Column(
        children: [
          Container(
            width: vwidth,
            child: Form(child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:20),
                  width: vwidth*0.9,
                  child: TextField(
                    controller: nombreCtrl,
                    decoration: new InputDecoration(
                      errorText: _validate[0] ? 'Este campo es requerido' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                      labelText: 'Nombre',
                    ),
                      keyboardType: TextInputType.text,
                      onChanged:(nombreCtrl){
                        _validate[0] = false;
                      } ,
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  width: vwidth*0.9,
                  child: TextField(
                    controller: tipoCtrl,
                    decoration: new InputDecoration(
                      errorText: _validate[1] ? 'Este campo es requerido' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                      labelText: 'Tipo',
                    ),
                      keyboardType: TextInputType.text,
                      onChanged:(tipoCtrl){
                        _validate[1] = false;
                      } ,
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  width: vwidth*0.9,
                  child: TextField(
                    controller: marcaCtrl,
                    decoration: new InputDecoration(
                      errorText: _validate[2] ? 'Este campo es requerido' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                      labelText: 'Marca',
                    ),
                      keyboardType: TextInputType.text,
                      onChanged:(marcaCtrl){
                        _validate[2] = false;
                      } ,
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  width: vwidth*0.9,
                  child: TextField(
                    controller: estadoCtrl,
                    decoration: new InputDecoration(
                      errorText: _validate[3] ? 'Este campo es requerido' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                      labelText: 'Estado',
                    ),
                      keyboardType: TextInputType.text,
                      onChanged:(estadoCtrl){
                        _validate[3] = false;
                      } ,
                    ),
                ),

                SizedBox(
                    height: 50,
                  ),
                ElevatedButton(
                  onPressed: () async {
                    if(nombreCtrl.text.isEmpty){
                      setState(() {
                        _validate[0] = true;
                      });
                    }
                    if(tipoCtrl.text.isEmpty){
                      setState(() {
                        _validate[1] = true;
                      });
                    }
                    if(marcaCtrl.text.isEmpty){
                      setState(() {
                        _validate[2] = true;
                      });
                    }
                    if(estadoCtrl.text.isEmpty){
                      setState(() {
                        _validate[3] = true;
                      });
                    }
                    if(_validate[0] == false && _validate[1] == false && _validate[2] == false && _validate[3] == false){
                      try {
                        var url = Uri.parse('http://localhost:9093/maquinaria/add?src=mysql');
                        print(url);
                        final headers = {
                          "Access-Control-Allow-Origin": "*",
                          'Content-Type': 'application/json',
                          'Accept': '*/*'
                        };
                        final body =  jsonEncode(<String, String>{
                          "nombre": "${nombreCtrl.text}",
                          "tipo": "${tipoCtrl.text}",
                          "marca": "${marcaCtrl.text}",
                          "estado": "${estadoCtrl.text}",
                          "id_empleado": "${globals.empleado_index}"
                        });
                        final response = await http.post(url, headers: headers, body:body);
                        print(response.statusCode);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MostrarMaquinariaScreen()), (Route<dynamic> route) => false);

                        if (response.statusCode == 200) {
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text(
                    'Registrar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    fixedSize: const Size(200, 40),
                    shape: const StadiumBorder(),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
