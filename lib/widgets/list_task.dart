import 'dart:io';

import 'package:appTasks/models/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTask extends StatelessWidget {
  final List<Tasks> _listTasks;
  final Function _handleSwitch;
  final bool _position;
  final Function _removeTasks;

  ListTask(this._listTasks, this._handleSwitch, this._position, this._removeTasks);

  @override
  Widget build(BuildContext context) {
    final _max = _position ? 65 : 150;

    _handleLongPress(String title, String desc) {
      showDialog(
          context: context,
          builder: (_) {
            return Platform.isIOS
                ? CupertinoAlertDialog(
                    title: Text(title),
                    content: Text(desc),
                  )
                : SimpleDialog(
                    title: Text(title),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(desc),
                      )
                    ],
                  );
          });
    }

    return Material(
        child: ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            _listTasks[index].title,
            style: _listTasks[index].completed
                ? TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
          subtitle: _listTasks[index].completed
              ? null
              : Text(_listTasks[index].desc.length > _max
                  ? "${_listTasks[index].desc.substring(0, _max)}..."
                  : _listTasks[index].desc),
          leading: Switch.adaptive(
            value: _listTasks[index].completed,
            onChanged: (value) => _handleSwitch(index, value),
          ),
          onLongPress: () =>
              _handleLongPress(_listTasks[index].title, _listTasks[index].desc),
              trailing: IconButton(icon: Icon(Icons.delete), onPressed: ()=> _removeTasks(index),),
        );
      },
      itemCount: _listTasks.length,
      separatorBuilder: (_, index) => Divider(),
    ));
  }
}
