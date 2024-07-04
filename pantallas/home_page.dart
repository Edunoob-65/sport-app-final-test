import 'dart:convert';

import 'package:deportesapp/pantallasdeApp/equipos.dart';
import 'package:deportesapp/pantallasdeApp/estadisticas.dart';
import 'package:deportesapp/pantallasdeApp/live.dart';
import 'package:deportesapp/pantallasdeApp/ligas.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 15, 14, 14), 
          title: Text('Futbol Mania',
          style: TextStyle( 
            color: Colors.white
          ),),
          bottom: TabBar(
            indicatorColor: Colors.blueGrey, 
            labelColor: Colors.white, 
            unselectedLabelColor: Colors.grey, 
            tabs: [
              Tab(text: 'Equipos'),
              Tab(text: 'Estadísticas'),
              Tab(text: 'Ligas'),
              Tab(text: '¡En vivo!'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Equipos(),
            Estadisticas(),
            ListaLigas(),
            ListaPartidosEnVivo(),
          ],
        ),
        backgroundColor: Colors.grey[900], 
      ),
    );
  }
}












