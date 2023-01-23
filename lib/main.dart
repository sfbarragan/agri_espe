import 'package:agri_espe/empleados/screens/mostrar_empleados_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => MostrarEmpleadosScreen())));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/empleados.png'), height: 150, width: 200,),
                      Text('Empleados', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            SizedBox(width: 30,),
            GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: ((context) => MostrarPlantasScreen())));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/maquinaria.png'), height: 150, width: 200,),
                      Text('Maquinaria', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 30,),
            GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: ((context) => MostrarPlantasScreen())));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/parcelas.png'), height: 150, width: 200,),
                      Text('Parselas', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 30,),
            ],),
            Container(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: ((context) => MostrarPlantasScreen())));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/cultivos.png'), height: 150, width: 200,),
                      Text('Cultivos', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 30,),
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: ((context) => MostrarPlantasScreen())));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/proveedor.png'), height: 150, width: 200,),
                      Text('Proveedor', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ],)
          ],)

        ),
      ),
    );
  }
}
