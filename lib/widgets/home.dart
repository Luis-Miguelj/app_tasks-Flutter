import 'dart:io';
import 'package:appTasks/models/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../widgets/list_task.dart';
import './new_task.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final List<Tasks> _tasks = [
    Tasks('Estudo', 'Estudar flutter', false),
    Tasks('Arrumar o quarto', 'Organizar as roupas e a cama', false),
    Tasks('Trabalho', 'Ir trabalhar', false),
    Tasks(
        'Conselho de vida',
        'A vida é curta demais para ser desperdiçada com coisas que não nos fazem felizes. Valorize cada momento e faça o que realmente importa para você.',
        false)
  ];

  void _handleSwitch(int index, bool value) {
    setState(() {
      _tasks[index].completed = value;
    });
  }

  void _saveTasks(Tasks task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void _removeTasks(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    final _mediaQuery = MediaQuery.of(context);
    final _position = _mediaQuery.orientation == Orientation.portrait;
    final _landscapeHeight = _mediaQuery.size.height * 0.15;
    final _portraitHeight = _mediaQuery.size.height * 0.12;

    final _appBarHeight = _position ? _portraitHeight : _landscapeHeight;

    _handleAdd() {
      showDialog(
          context: context,
          builder: (_) {
            return NewTask(_saveTasks);
          });
    }

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('my Tasks'),
              trailing: TextButton(onPressed: _handleAdd, child: Text('ok')),
            ),
            child: Text('data'),
          )
        : Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(_appBarHeight),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                  child: Column(
                    children: [
                      Container(
                        child: const Row(
                          children: [
                            Text(
                              'My Tasks',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          child: Row(
                        children: <Widget>[
                          Text(
                              DateFormat.yMMMMEEEEd('pt_BR')
                                  .format(DateTime.now()),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 15,
                              ))
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              title: const Text(
                'My Tasks',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              actions: [
                IconButton(icon: Icon(Icons.add), onPressed: _handleAdd)
              ],
              flexibleSpace: const Image(
                image: AssetImage('assets/images/thumb2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _handleAdd,
              backgroundColor: Colors.black,
              hoverColor: Colors.white24,
              child: const Icon(Icons.add),
            ),
            body: ListTask(_tasks, _handleSwitch, _position, _removeTasks),
          );
  }
}
