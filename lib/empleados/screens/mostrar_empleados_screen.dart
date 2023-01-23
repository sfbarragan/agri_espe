import 'dart:convert';

import 'package:agri_espe/empleados/screens/editar_empleados_screen.dart';
import 'package:agri_espe/empleados/screens/insert_empleados_screen.dart';
import 'package:agri_espe/empleados/widgets/Datos_Empleados.dart';
import 'package:agri_espe/maquinaria/screens/mostrar_maquinaria_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agri_espe/var_globals.dart' as globals;

import '../../main.dart';

class MostrarEmpleadosScreen extends StatefulWidget {
  const MostrarEmpleadosScreen({Key? key}) : super(key: key);

  @override
  State<MostrarEmpleadosScreen> createState() => MostrarEmpleadosScreenState();
}

class MostrarEmpleadosScreenState extends State<MostrarEmpleadosScreen> {
  MostrarEmpleadosScreenState();

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
        globals.empleados.clear();
      });
      mostrarEmpleados();
    }
  }

  Future<dynamic> mostrarEmpleados() async {
    try {
      var url = Uri.parse('http://localhost:9093/empleados/get/?src=mysql');
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
        final List<Datos_Empleados> resultados = [];
        final data = json.decode(response.body);
        final soli = data as List<dynamic>;
        for (var solis in soli) {
          resultados.add(Datos_Empleados.fromJson(solis));
        }

        print('aqui mi lista---- ' + resultados.toString());
        setState((() {
              globals.empleados.addAll(resultados);
        }));
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Empleados'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment : MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>InsetEmpleadosScreen()));
          },
          heroTag: "",
          child: Text('+', style: TextStyle(fontSize:30),),),
          SizedBox(width: 20,),
          FloatingActionButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
          }, child: Icon(Icons.home),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body:CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30, top:20),
                  child: Text('Lista de Empleados', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      width: vwidth/6,
                      child: Text('Cédula', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: vwidth/6,
                      child: Text('Nombre', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: vwidth/6,
                      child: Text('Edad', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: vwidth/6,
                      child: Text('Sueldo', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: vwidth/5,
                      child: Text('Acciones', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            )
          ),
          globals.empleados.isEmpty? SliverToBoxAdapter():SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, index) {
                return Container(
                   decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(101, 71, 71, 71),
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 2.0,
                        
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: ListTile(
                    title: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                          margin: EdgeInsets.only(left: 15),
                          width: vwidth/6,
                          child: Text('${globals.empleados[index].cedula}', style:TextStyle(fontSize: 18)),
                          ),
                          Container(
                            width: vwidth/6,
                            child: Text('${globals.empleados[index].nombre}', style:TextStyle(fontSize: 18)),
                          ),
                          Container(
                            width: vwidth/6,
                            child: Text('${globals.empleados[index].edad}', style:TextStyle(fontSize: 18)),
                          ),
                          Container(
                            width: vwidth/6,
                            child: Text('${globals.empleados[index].sueldo}', style:TextStyle(fontSize: 18)),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: vwidth/8,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                  ),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Color.fromARGB(255, 255, 255, 255),
                                      padding: const EdgeInsets.all(16.0),
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        globals.empleado_index = globals.empleados[index].id;
                                      });
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>(MostrarMaquinariaScreen())));
                                    },
                                    child: Text("Maquinarias", style:TextStyle(fontSize: 18)),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  width: vwidth/8,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                  ),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Color.fromARGB(255, 255, 255, 255),
                                      padding: const EdgeInsets.all(16.0),
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        globals.empleado_index = globals.empleados[index].id;
                                      });
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>(EditarEmpleadosScreen())));
                                    },
                                    child: Text("Editar", style:TextStyle(fontSize: 18)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: globals.empleados.length,
              )
            )
        ],
      ),
    );
  }

}
