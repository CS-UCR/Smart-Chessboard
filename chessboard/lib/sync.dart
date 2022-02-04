import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'altgame.dart';
import 'Classes/Assists.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class syncgame extends StatefulWidget {
  syncgame({Key? key, required this.assists, required this.time}) : super(key: key);
  Assists assists;
  int time;

  @override
  _syncgameState createState() => _syncgameState(assists, time);
}

class _syncgameState extends State<syncgame> {
    final _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8765'),
  );
  var start;
  List<String> moves=[];
  Assists inf = Assists(false, false, 0, false);
  int time = 0;

  _syncgameState(Assists assists, int t) {
    inf = assists;
    time = t;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String json = jsonEncode(inf.toJson());
    _channel.sink.add(json);
    print(json);
    return altgame(assists: inf, time: time);
  }
}