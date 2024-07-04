import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Estadisticas extends StatefulWidget {
  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<Estadisticas> {
  List<Map<String, dynamic>> teams = [
    {'id': 30, 'name': 'Peru', 'logo': 'https://media.api-sports.io/football/teams/30.png'},
    {'id': 33, 'name': 'Brazil', 'logo': 'https://media.api-sports.io/football/teams/33.png'},
    {'id': 41, 'name': 'Argentina', 'logo': 'https://media.api-sports.io/football/teams/41.png'},
    {'id': 42, 'name': 'Chile', 'logo': 'https://media.api-sports.io/football/teams/42.png'},
    {'id': 46, 'name': 'France', 'logo': 'https://media.api-sports.io/football/teams/46.png'},
    {'id': 50, 'name': 'Germany', 'logo': 'https://media.api-sports.io/football/teams/50.png'},
    {'id': 52, 'name': 'Italy', 'logo': 'https://media.api-sports.io/football/teams/52.png'},
    {'id': 54, 'name': 'Spain', 'logo': 'https://media.api-sports.io/football/teams/54.png'},
    {'id': 57, 'name': 'England', 'logo': 'https://media.api-sports.io/football/teams/57.png'},
    {'id': 61, 'name': 'Netherlands', 'logo': 'https://media.api-sports.io/football/teams/61.png'},
    

  ];

  Map<String, dynamic>? selectedTeamStats;

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
       ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return Container(            
          margin: EdgeInsets.all(10), 
          decoration: BoxDecoration(
            color:  Color.fromARGB(255, 83, 87, 88).withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.0), 
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 96, 98, 114).withOpacity(0.5), 
                 blurRadius: 7, 
                offset: Offset(0, 5), 
              ),
            ],
          ),
                    child: ListTile(
            leading: Image.network(
              team['logo'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(team['name'],
            style: TextStyle( 
              color: Colors.white
            ),),
            onTap: () {
              fetchTeamStats(team['id'],
              );
                
            },
          ),);
        },
      ),
  ]),);
  }

  Future<void> fetchTeamStats(int teamId) async {
    final String apiUrl = 'https://api-football-v1.p.rapidapi.com/v3/teams/statistics?league=39&season=2020&team=$teamId';
    final headers = {
      'x-rapidapi-key': 'cbfe4addd6msh77bab7ee9f82bddp1bde33jsn5057d42a9029',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          selectedTeamStats = json.decode(response.body)['response'];
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamStatsPage(selectedTeamStats!),
          ),
        );
      } else {
        throw Exception('fallo al cargar datos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class TeamStatsPage extends StatelessWidget {
  final Map<String, dynamic> teamStats;

  TeamStatsPage(this.teamStats);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 83, 108, 131),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 15, 14, 14),
        title: Text('Estadísticas del Equipo',
        style: TextStyle( color: Colors.white),),
      ),
      body: Center(
        child: TeamStatsWidget(teamStats),
      ),
    );
  }
}

class TeamStatsWidget extends StatelessWidget {
  final Map<String, dynamic> teamStats;

  TeamStatsWidget(this.teamStats);

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
    Center(
      child: Container(
      height: 500,
      margin: EdgeInsets.all(20.0),      
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 15, 14, 14),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            teamStats['team']['logo'],
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            teamStats['team']['name'],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Estadísticas de la Temporada',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildStatsItem('Partidos Jugados', teamStats['fixtures']['played']['total'].toString()),
          _buildStatsItem('Victorias', teamStats['fixtures']['wins']['total'].toString()),
          _buildStatsItem('Empates', teamStats['fixtures']['draws']['total'].toString()),
          _buildStatsItem('Derrotas', teamStats['fixtures']['loses']['total'].toString()),
          SizedBox(height: 16),
            ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

  Widget _ItemEstado(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
