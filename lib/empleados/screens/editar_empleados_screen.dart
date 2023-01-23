import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agri_espe/var_globals.dart' as globals;

import 'mostrar_empleados_screen.dart';

class EditarEmpleadosScreen extends StatefulWidget {
  const EditarEmpleadosScreen({Key? key}) : super(key: key);

  @override
  State<EditarEmpleadosScreen> createState() => EditarEmpleadosScreenState();
}

class EditarEmpleadosScreenState extends State<EditarEmpleadosScreen> {
  TextEditingController  cedulaCtrl = new TextEditingController();
  TextEditingController  nombreCtrl = new TextEditingController();
  TextEditingController  edadCtrl = new TextEditingController();
  TextEditingController  sueldoCtrl = new TextEditingController();
  List<bool> _validate = [false, false, false, false];

  _inition(){
    setState(() {
      cedulaCtrl.text = globals.empleados[globals.empleado_index].cedula ;
      nombreCtrl.text = globals.empleados[globals.empleado_index].nombre;
      edadCtrl.text = globals.empleados[globals.empleado_index].edad.toString();
      sueldoCtrl.text = globals.empleados[globals.empleado_index].sueldo.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _inition();
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
       appBar: AppBar(
        title: Text('Editar Empleado'),
      ),
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
                        var url = Uri.parse('http://localhost:9093/empleados/update/${globals.empleados[globals.empleado_index].id}?src=mysql');
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
                        final response = await http.put(url, headers: headers, body:body);
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
                    'Actualizar',
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
