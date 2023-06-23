import 'package:flutter/material.dart';
import 'jet_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    // Definir un estilo de texto para el título

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Inicio'),
              onTap: () {
                // Acción al hacer clic en 'Inicio'
                Navigator.pop(context); // Cerrar el menú deslizante
                // Agregar aquí la lógica para navegar a la página de inicio
              },
            ),
            ListTile(
              title: Text('Jets'),
              onTap: () {
                // Acción al hacer clic en 'Perfil'
                Navigator.pop(context); // Cerrar el menú deslizante
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JetListPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Configuración'),
              onTap: () {
                // Acción al hacer clic en 'Configuración'
                Navigator.pop(context); // Cerrar el menú deslizante
                // Agregar aquí la lógica para navegar a la página de configuración
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container( child:Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ext1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Legacy Aviation Group',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 40),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'We are more than a private aviation company',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Legacy’s most sought-after services are advisory based. Our strength lies in evaluating each client’s needs and designing tailor-fitted private travel solutions. Whether it’s full or fractional aircraft ownership, aircraft leasing, jet cards or on- demand charter, Legacy has you covered.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Asientos.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Select your Aircraft \nFind the jet that fits your needs.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 40),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Key Differences',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Through our focus on six key service areas, Legacy Aviation clients enjoy unrivaled value and benefits:',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    CardContainer(),
                  ],
                ),
              ),
            ),
            // Aquí puedes agregar más widgets debajo de la imagen de fondo
            // que se desplazarán si el contenido es más largo que la pantalla
          ],
        ),
      )),
    );
  }
}

class CardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CardWidget(
            imagePath: 'assets/icon1.png',
            title: 'We are Advisors',
            text: ' ',
          ),
          CardWidget(
            imagePath: 'assets/icon2.png',
            title: 'Safety & Quality Commitment',
            text: ' ',
          ),CardWidget(
            imagePath: 'assets/icon3.png',
            title: 'Complete Trip Management',
            text: ' ',
          ),
          CardWidget(
            imagePath: 'assets/icon4.png',
            title: 'Global Organization',
            text: ' ',
          ),CardWidget(
            imagePath: 'assets/icon5.png',
            title: 'Dedicated Concierge Team',
            text: ' ',
          ),
          CardWidget(
            imagePath: 'assets/icon6.png',
            title: 'New & Comprehensive Fleet',
            text: ' ',
          ),
          // Agrega más widgets CardWidget según sea necesario
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String text;

  CardWidget({
    required this.imagePath,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child:  Column(
        children: [Expanded(child:
          Image.asset(
            imagePath,
            height: 200,
            width: 150,
            fit: BoxFit.fill,
          )),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


