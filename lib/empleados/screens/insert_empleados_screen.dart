import 'dart:convert';

import 'package:agri_espe/empleados/screens/mostrar_empleados_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agri_espe/var_globals.dart' as globals;
class InsetEmpleadosScreen extends StatefulWidget {
  const InsetEmpleadosScreen({Key? key}) : super(key: key);

  @override
  State<InsetEmpleadosScreen> createState() => InsetEmpleadosScreenState();
}


class InsetEmpleadosScreenState extends State<InsetEmpleadosScreen> {
  TextEditingController  cedulaCtrl = new TextEditingController();
  TextEditingController  nombreCtrl = new TextEditingController();
  TextEditingController  edadCtrl = new TextEditingController();
  TextEditingController  sueldoCtrl = new TextEditingController();

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
      appBar: AppBar(title: Text('Ingreso de Empleados')),
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
                    controller: cedulaCtrl,
                    decoration: new InputDecoration(
                      errorText: _validate[0] ? 'Este campo es requerido' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                      labelText: 'Cedula',
                    ),
                      keyboardType: TextInputType.text,
                      onChanged:(cedulaCtrl){
                        _validate[0] = false;
                      } ,
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  width: vwidth*0.9,
                  child: TextField(
                    controller: nombreCtrl,
                    decoration: new InputDecoration(
                      errorText: _validate[1] ? 'Este campo es requerido' : null,
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
                        _validate[1] = false;
                      } ,
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  width: vwidth*0.9,
                  child: TextField(
                    controller: edadCtrl,
                    decoration: new InputDecoration(
                      errorText: _validate[2] ? 'Este campo es requerido' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                      labelText: 'Edad',
                    ),
                      keyboardType: TextInputType.text,
                      onChanged:(edadCtrl){
                        _validate[2] = false;
                      } ,
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  width: vwidth*0.9,
                  child: TextField(
                    controller: sueldoCtrl,
                    decoration: new InputDecoration(
                      errorText: _validate[3] ? 'Este campo es requerido' : null,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 0, 38, 87)),
                        ),
                      labelText: 'Sueldo',
                    ),
                      keyboardType: TextInputType.text,
                      onChanged:(sueldoCtrl){
                        _validate[3] = false;
                      } ,
                    ),
                ),

                SizedBox(
                    height: 50,
                  ),
                ElevatedButton(
                  onPressed: () async {
                    if(cedulaCtrl.text.isEmpty){
                      setState(() {
                        _validate[0] = true;
                      });
                    }
                    if(nombreCtrl.text.isEmpty){
                      setState(() {
                        _validate[1] = true;
                      });
                    }
                    if(edadCtrl.text.isEmpty){
                      setState(() {
                        _validate[2] = true;
                      });
                    }
                    if(sueldoCtrl.text.isEmpty){
                      setState(() {
                        _validate[3] = true;
                      });
                    }
                    if(_validate[0] == false && _validate[1] == false && _validate[2] == false && _validate[3] == false){
                      try {
                        var url = Uri.parse('http://localhost:9093/empleados/add?src=mysql');
                        print(url);
                        final headers = {
                          "Access-Control-Allow-Origin": "*",
                          'Content-Type': 'application/json',
                          'Accept': '*/*'
                        };
                        final body =  jsonEncode(<String, String>{
                          "cedula": "${cedulaCtrl.text}",
                          "nombre": "${nombreCtrl.text}",
                          "edad": "${edadCtrl.text}",
                          "sueldo": "${sueldoCtrl.text}"
                        });
                        final response = await http.post(url, headers: headers, body:body);
                        print(response.statusCode);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MostrarEmpleadosScreen()), (Route<dynamic> route) => false);

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
