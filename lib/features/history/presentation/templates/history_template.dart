import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_filler/core/presentation/atoms/primary_button_label.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class HistoryTemplate extends StatelessWidget {
  const HistoryTemplate({
    Key key,
    @required this.loading,
    this.filesInPath = const [],
  }) : super(key: key);

  final bool loading;
  final List<FileSystemEntity> filesInPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: PrimaryButtonLabel(
        text: 'Historial',
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (loading) {
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            ),
            Text(
              '...cargando archivos',
            ),
          ],
        ),
      );
    }

    var counter = 0;
    return ListView(
      children: [
        if (filesInPath.isEmpty)
          Center(
            child: Text(
              'No tienes archivos.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        if (filesInPath.isNotEmpty)
          ...filesInPath.map((file) {
            if (extension(file.path) != '.xls') return SizedBox();
            final fileName = basename(file.path);
            counter++;

            final fileNamePieces = fileName.split('.');
            var displayName = '';
            var codename = '';
            var period = '';

            if (fileNamePieces.length > 3) ;
            {
              displayName = fileNamePieces[0];
              codename = fileNamePieces[2];
              final periodPieces = fileNamePieces[3].split('-');

              period = '${periodPieces[0]}/${periodPieces[1]}  ';
            }

            return Card(
              child: ListTile(
                tileColor: Colors.grey.withOpacity(.3),
                title: Text(
                  '$counter- ${displayName}' ?? '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '$codename - $period',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isThreeLine: true,
              ),
            );
          }).toList(),
      ],
    );
  }
}
