import 'dart:convert';

import 'package:agri_espe/maquinaria/widgets/Datos_Maquinaria.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agri_espe/var_globals.dart' as globals;

import '../../main.dart';

class MostrarMaquinariaScreen extends StatefulWidget {
  const MostrarMaquinariaScreen({Key? key}) : super(key: key);

  @override
  State<MostrarMaquinariaScreen> createState() => MostrarMaquinariaScreenState();
}

class MostrarMaquinariaScreenState extends State<MostrarMaquinariaScreen> {

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
        globals.maquinarias.clear();
      });
      mostrarMaquinaria();
    }
  }


  Future<dynamic> mostrarMaquinaria() async {
    try {
      var url = Uri.parse('http://localhost:9093/maquinaria/get/employe/${globals.empleado_index}?src=mysql');
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
        final List<Datos_Maquinaria> resultados = [];
        final data = json.decode(response.body);
        final soli = data as List<dynamic>;
        for (var solis in soli) {
          resultados.add(Datos_Maquinaria.fromJson(solis));
        }

        print('aqui mi lista---- ' + resultados.toString());
        setState((() {
              globals.maquinarias.addAll(resultados);
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
        title: Text('Lista de Maquinarias'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment : MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>InsertPesticidasScreen()));
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30, top:20),
                  child: Text('Lista de Maquinarias', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      width: vwidth/6,
                      child: Text('Nombre', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: vwidth/6,
                      child: Text('Tipo', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: vwidth/6,
                      child: Text('Marca', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: vwidth/6,
                      child: Text('Estado', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          globals.maquinarias.isEmpty? SliverToBoxAdapter():SliverList(
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
                          child: Text('${globals.maquinarias[index].nombre}', style:TextStyle(fontSize: 18)),
                          ),
                          Container(
                            width: vwidth/6,
                            child: Text('${globals.maquinarias[index].tipo}', style:TextStyle(fontSize: 18)),
                          ),
                          Container(
                            width: vwidth/6,
                            child: Text('${globals.maquinarias[index].marca}', style:TextStyle(fontSize: 18)),
                          ),
                          Container(
                            width: vwidth/6,
                            child: Text('${globals.maquinarias[index].estado}', style:TextStyle(fontSize: 18)),
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
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>(EditarEmpleadosScreen())));
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
              childCount: globals.maquinarias.length,
              )
            )
        ],
      ),
    );
  }
}
