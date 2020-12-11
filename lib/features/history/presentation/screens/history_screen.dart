import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_filler/features/history/presentation/templates/history_template.dart';

import 'package:path_provider/path_provider.dart' as path;

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  static const String route = 'history';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _loading = true;
  Directory _appPath;
  List<FileSystemEntity> _filesInPath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initMembers();
  }

  void initMembers() async {
    _appPath = await path.getExternalStorageDirectory();
    var _documentsPath = Directory('${_appPath.path}/Documents/');
    _filesInPath = _documentsPath.listSync(
      recursive: false,
    );

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HistoryTemplate(
      loading: _loading,
      filesInPath: _filesInPath,
    );
  }
}
