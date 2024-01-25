import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tareas integradora',
      home: MyHomePage(),
    );
  }
}

class Tarea {
  String descripcion;
  bool completada;

  Tarea({required this.descripcion, this.completada = false});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Tarea> tareas = [];
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tareas'),
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
            onDismissed: (direction) {
              tareas.removeAt(index);
              setState(() {});
            },
            key: Key(tareas[index].descripcion), 
            child: ListTile(
              title: Text(
                tareas[index].descripcion,
                style: TextStyle(
                  decoration: tareas[index].completada
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  marcarTareaComoCompletada(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmar tarea'),
                content: TextField(
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'Nueva tarea'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
                  ),
                  TextButton(
                    child: Text('Confirmar'),
                    onPressed: () {
                      agregarTarea();
                      Navigator.of(context).pop(); 
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Agregar tarea',
        child: Icon(Icons.add),
      ),
    );
  }

  void agregarTarea() {
    final nuevaTarea = _textController.text;
    if (nuevaTarea.isNotEmpty) {
      tareas.add(Tarea(descripcion: nuevaTarea));
      _textController.clear();
      setState(() {});
    }
  }

  void marcarTareaComoCompletada(int index) {
    setState(() {
      tareas[index].completada = !tareas[index].completada;
    });
  }
}
