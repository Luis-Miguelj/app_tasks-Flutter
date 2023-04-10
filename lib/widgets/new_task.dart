import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/tasks.dart';

class NewTask extends StatelessWidget {
  final Function _saveTask;

  NewTask(this._saveTask);

  static final _titleController = TextEditingController();
  static final _descController = TextEditingController();

  final Widget _title = Platform.isIOS
      ? CupertinoTextField(
          placeholder: 'Título',
          controller: _titleController,
        )
      : TextField(
          decoration: InputDecoration(labelText: 'Título'),
          controller: _titleController,
        );

  final Widget _descricao = Platform.isIOS
      ? CupertinoTextField(
          placeholder: 'Descrição',
          controller: _descController,
        )
      : TextFormField(
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(labelText: 'Descrição'),
          controller: _descController,
        );

  @override
  Widget build(BuildContext context) {
    void _handleSave() {
      final Tasks task =
          Tasks(_titleController.text, _descController.text, false);
      _saveTask(task);

      //Jeito que eu fiz -
      // if (_titleController.text != null && _descController.text != null) {
      //   _titleController.text = '';
      //   _descController.text = '';
      // }

      //Jeito do Curso
      //Limpa os campos do input
      _titleController.clear();
      _descController.clear();

      Navigator.of(context).pop();
    }

    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text('Adicionar tarefa'),
            content: Column(
              children: <Widget>[_title, _descricao],
            ),
            actions: const <Widget>[
              CupertinoDialogAction(
                child: Text('Salvar'),
                onPressed: null,
              )
            ],
          )
        : AlertDialog(
            title: const Text('Adicionar tarefa'),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[_title, _descricao]),
            actions: <Widget>[
                Container(
                    // color: Colors.blue,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: _handleSave,
                        child: const Text(
                          'Salvar',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )))
              ]);
  }
}
