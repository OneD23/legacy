import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Jet.dart';
import 'rental.dart';

class JetListPage extends StatefulWidget {
  @override
  _JetListPageState createState() => _JetListPageState();
}

class _JetListPageState extends State<JetListPage> {
  List<Jet> jets = [];

  @override
  void initState() {
    super.initState();
    fetchJets();
  }

  Future<void> fetchJets() async {
    final response = await http.get(Uri.parse(
        'https://properties-production.up.railway.app/Jet/')); // Reemplaza 'TU_URL_DEL_BACKEND' con la URL real de tu backend
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        jets = jsonData.map<Jet>((item) => Jet.fromJson(item)).toList();
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jets'),
      ),
      body: ListView.builder(
        itemCount: jets.length,
        itemBuilder: (context, index) {
          final jet = jets[index];
          return ListTile(
            leading: jet.imageUrl.isNotEmpty
                ? Image.network(
              jet.imageUrl,
              width: 200,
              height: 400,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                );
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Icon(Icons
                    .error); // Muestra un ícono de error si no se puede cargar la imagen
              },
            )
                : Container(),
            title: Text(jet.name),
            subtitle: Text(
                jet.speed + '\n' + jet.cabinDimensions + '\n' + jet.passengers),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JetDetailPage(jet: jet,),
                ),
              );

            },
          );
        },
      ),
    );
  }
}

class JetDetailPage extends StatelessWidget {
  final Jet jet;

  JetDetailPage({required this.jet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jet.name),

      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(jet.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.black.withOpacity(0.4), // Color semitransparente
              ),
              Positioned(
                top: 120,
                left: 16,
                right: 16,
                child: Text(
                  jet.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          // Mostrar los detalles del jet
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Description: ${jet.description}',
              textAlign: TextAlign.justify,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Passengers: ${jet.passengers}', textAlign: TextAlign.justify),
              Text('Cabin Dimensions: ${jet.cabinDimensions}', textAlign: TextAlign.justify),
              Text('Range: ${jet.range}', textAlign: TextAlign.justify),
              Text('Speed: ${jet.speed}', textAlign: TextAlign.justify),
              Text('Cargo Capacity: ${jet.cargoCapacity}', textAlign: TextAlign.justify),
            ],
          ),
          // Agregar un botón de "Rentar"
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Rentar Jet'),
                    content: RentalDateSelector(jetCostPerWeek: 900),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cerrar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Rentar'),
          ),
        ],
      ),
    );
  }
}
