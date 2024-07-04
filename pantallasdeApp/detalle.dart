import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class DetallePantalla extends StatefulWidget {
  final Map<String, dynamic> team;

  DetallePantalla({required this.team});

  @override
  _DetallePantallaState createState() => _DetallePantallaState();
}

class _DetallePantallaState extends State<DetallePantalla> {
  final translator = GoogleTranslator();
  String descripcionTraduccion = "";

  @override
  void initState() {
    super.initState();
    translateDescription();
  }

  translateDescription() async {
    final translation = await translator.translate(
      widget.team['strDescriptionEN'] ?? 'sin descripcion disponible',
      from: 'en',
      to: 'es',
    );
    setState(() {
      descripcionTraduccion = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('imagenes/pantalla.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
      
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(200, 3, 39, 122),
                  Color.fromARGB(150, 0, 0, 0),
                ],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.0), 
                    Text(
                      'Equipo: ${widget.team['strTeam']}',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    widget.team['strFanart1'] != null
                        ? Image.network(widget.team['strFanart1'])
                        : SizedBox(height: 100),
                    SizedBox(height: 16.0),
                    Text(
                      'Estadio: ${widget.team['strStadium']}',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    descripcionTraduccion.isEmpty
                        ? CircularProgressIndicator()
                        : Text(
                            'Descripción: $descripcionTraduccion',
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                    SizedBox(height: 40.0), // Ajusta el espacio inferior según sea necesario
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
