import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); 
  // Punto de entrada de la aplicación. Ejecuta la aplicación Flutter iniciando con el widget MyApp.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Define la clase MyApp, que es un widget sin estado (StatelessWidget).

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Retorna un widget MaterialApp, que proporciona funcionalidades básicas de la aplicación.
      debugShowCheckedModeBanner: false,
      // Desactiva la etiqueta de "debug" en la esquina superior derecha.
      title: 'ConsultaYa',
      // Establece el título de la aplicación.
      theme: ThemeData(
        // Configura el tema general de la aplicación.
        primarySwatch: Colors.teal,
        // Define el color primario como teal.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Ajusta la densidad visual según la plataforma.
        elevatedButtonTheme: ElevatedButtonThemeData(
          // Configura el tema para los botones elevados.
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            // Establece el padding de los botones.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              // Da forma redondeada a los botones.
            ),
          ),
        ),
      ),
      home: const HomePage(),
      // Define la página de inicio de la aplicación.
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // Define la clase HomePage, que es un widget sin estado.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Crea la estructura básica de la página.
      appBar: AppBar(
        // Configura la barra superior de la aplicación.
        title: const Text('ConsultaYa',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        // Contenedor principal del cuerpo de la página.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Crea un fondo con gradiente.
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade100, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            // Organiza los elementos en una columna centrada.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                // Crea un avatar circular con un icono.
                radius: 50,
                backgroundColor: Colors.teal,
                child: Icon(Icons.healing, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 30),
              // Añade espacio vertical.
              _buildButton(context, 'Gestionar Citas Médicas',
                  Icons.calendar_today, const CitasMedicasPage()),
              _buildButton(context, 'Historia Clínica', Icons.folder_shared,
                  const HistoriaClinicaPage()),
              _buildButton(context, 'Chat', Icons.chat, const ChatPage()),
              _buildButton(context, 'Resultados de Exámenes', Icons.assessment,
                   ResultadosPage()),
              _buildButton(context, 'Autorización de Medicamentos',
                  Icons.local_pharmacy, const AutorizacionPage()),
              // Crea botones para diferentes funcionalidades de la aplicación.
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, IconData icon, Widget page) {
    // Método para construir botones personalizados.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(text),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => page)),
        // Al presionar, navega a la página correspondiente.
      ),
    );
  }
}



class CitasMedicasPage extends StatefulWidget {
  const CitasMedicasPage({super.key});
  // Define la clase CitasMedicasPage como un widget con estado (StatefulWidget).

  @override
  _CitasMedicasPageState createState() => _CitasMedicasPageState();
  // Crea el estado asociado a este widget.
}

class _CitasMedicasPageState extends State<CitasMedicasPage> {
  List<Map<String, String>> citas = [
    // Lista de citas médicas predefinidas.
    {
      'doctor': 'Dr. García',
      'especialidad': 'Cardiología',
      'fecha': '10 de Octubre, 2024',
      'hora': '10:00 AM'
    },
    {
      'doctor': 'Dra. Martínez',
      'especialidad': 'Dermatología',
      'fecha': '15 de Octubre, 2024',
      'hora': '2:00 PM'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Crea la estructura básica de la página.
      appBar: AppBar(title: const Text('Gestionar Citas Médicas')),
      // Configura la barra superior de la aplicación.
      body: ListView.builder(
        // Crea una lista desplazable de citas médicas.
        itemCount: citas.length,
        itemBuilder: (context, index) {
          return Card(
            // Cada cita se muestra en una tarjeta.
            margin: const EdgeInsets.all(8),
            child: ListTile(
              // Configura el contenido de cada tarjeta.
              leading: CircleAvatar(child: Text(citas[index]['doctor']![0])),
              // Muestra la primera letra del nombre del doctor en un avatar circular.
              title: Text(
                  '${citas[index]['doctor']} - ${citas[index]['especialidad']}'),
              // Muestra el nombre del doctor y su especialidad.
              subtitle:
                  Text('${citas[index]['fecha']} - ${citas[index]['hora']}'),
              // Muestra la fecha y hora de la cita.
              trailing: IconButton(
                // Agrega un botón para eliminar la cita.
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    citas.removeAt(index);
                    // Elimina la cita de la lista cuando se presiona el botón.
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Agrega un botón flotante para añadir nuevas citas.
        child: const Icon(Icons.add),
        onPressed: () => _showAddCitaDialog(),
        // Muestra un diálogo para añadir una nueva cita cuando se presiona.
      ),
    );
  }

  void _showAddCitaDialog() {
    // Función para mostrar el diálogo de añadir cita.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String doctor = '';
        String especialidad = '';
        String fecha = '';
        String hora = '';
        // Variables para almacenar la información de la nueva cita.

        return AlertDialog(
          // Crea un diálogo de alerta.
          title: const Text('Agregar Nueva Cita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Campos de texto para ingresar la información de la nueva cita.
              TextField(
                decoration: const InputDecoration(labelText: 'Doctor'),
                onChanged: (value) => doctor = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Especialidad'),
                onChanged: (value) => especialidad = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Fecha'),
                onChanged: (value) => fecha = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Hora'),
                onChanged: (value) => hora = value,
              ),
            ],
          ),
          actions: <Widget>[
            // Botones para cancelar o agregar la nueva cita.
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Agregar'),
              onPressed: () {
                setState(() {
                  citas.add({
                    'doctor': doctor,
                    'especialidad': especialidad,
                    'fecha': fecha,
                    'hora': hora,
                  });
                  // Agrega la nueva cita a la lista.
                });
                Navigator.of(context).pop();
                // Cierra el diálogo.
              },
            ),
          ],
        );
      },
    );
  }
}


class HistoriaClinicaPage extends StatelessWidget {
  const HistoriaClinicaPage({super.key});
  // Define la página de Historia Clínica como un widget sin estado.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Crea la estructura básica de la página.
      appBar: AppBar(title: const Text('Historia Clínica')),
      // Configura la barra superior de la aplicación.
      body: SingleChildScrollView(
        // Permite desplazarse si el contenido es más largo que la pantalla.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildInfoCard('Información Personal', [
              'Nombre: Juan Pérez',
              'Fecha de Nacimiento: 15/05/1980',
              'Grupo Sanguíneo: O+',
            ]),
            // Crea una tarjeta con información personal del paciente.
            const SizedBox(height: 20),
            // Añade espacio vertical entre las tarjetas.
            _buildInfoCard('Historial Médico', [
              'Hipertensión diagnosticada en 2015',
              'Fractura de brazo derecho en 2018',
            ]),
            // Crea una tarjeta con el historial médico del paciente.
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Añade un botón flotante para descargar la historia clínica.
        child: const Icon(Icons.download),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Descargando historia clínica...')),
          );
          // Muestra un mensaje de descarga al presionar el botón.
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, List<String> info) {
    // Función para construir las tarjetas de información.
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Muestra el título de la tarjeta.
            const SizedBox(height: 10),
            ...info.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(e),
                )),
            // Muestra cada elemento de información en la tarjeta.
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  // Define la página de Chat como un widget con estado.

  @override
  _ChatPageState createState() => _ChatPageState();
  // Crea el estado asociado a este widget.
}




class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [
    // Lista inicial de mensajes predefinidos para el chat.
    ChatMessage(message: '¿Hola, en qué puedo ayudarte?', isMe: false),
    ChatMessage(message: 'Tengo una duda sobre mi medicación', isMe: true),
    ChatMessage(message: 'Claro, cuéntame más sobre tu duda', isMe: false),
  ];

  final TextEditingController _textController = TextEditingController();
  // Controlador para el campo de texto donde se escriben los mensajes.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estructura básica de la página de chat.
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              // Lista desplazable que muestra los mensajes del chat.
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: _messages[index].message,
                  isMe: _messages[index].isMe,
                );
                // Crea una burbuja de chat para cada mensaje.
              },
            ),
          ),
          _buildMessageComposer(),
          // Añade el compositor de mensajes en la parte inferior.
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    // Función para construir el compositor de mensajes.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              // Campo de texto para escribir mensajes.
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          IconButton(
            // Botón para enviar mensajes.
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    // Función para manejar el envío de un mensaje.
    _textController.clear();
    setState(() {
      _messages.add(ChatMessage(message: text, isMe: true));
      // Añade el nuevo mensaje a la lista de mensajes.
    });
  }
}

class ChatMessage {
  // Clase para representar un mensaje de chat.
  final String message;
  final bool isMe;

  ChatMessage({required this.message, required this.isMe});
}

class ChatBubble extends StatelessWidget {
  // Widget para mostrar una burbuja de chat.
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      // Alinea los mensajes a la derecha o izquierda según quién los envió.
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.teal : Colors.grey[300],
          // Cambia el color de fondo según quién envió el mensaje.
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
          // Cambia el color del texto según quién envió el mensaje.
        ),
      ),
    );
  }
}



class ResultadosPage extends StatelessWidget {
  final List<Map<String, dynamic>> resultados = [
    // Lista de resultados de exámenes predefinidos
    {
      'tipo': 'Análisis de Sangre',
      'fecha': '05/10/2024',
      'icon': Icons.description
    },
    {
      'tipo': 'Radiografía de Tórax',
      'fecha': '20/09/2024',
      'icon': Icons.image
    },
    {
      'tipo': 'Electrocardiograma',
      'fecha': '15/09/2024',
      'icon': Icons.favorite
    },
  ];

   ResultadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estructura básica de la página
      appBar: AppBar(title: const Text('Resultados de Exámenes')),
      body: ListView.builder(
        // Crea una lista desplazable de resultados
        itemCount: resultados.length,
        itemBuilder: (context, index) {
          return Card(
            // Cada resultado se muestra en una tarjeta
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(resultados[index]['icon'] as IconData,
                  color: Colors.teal),
              // Icono del tipo de examen
              title: Text(resultados[index]['tipo'] as String),
              // Nombre del tipo de examen
              subtitle: Text('Fecha: ${resultados[index]['fecha']}'),
              // Fecha del examen
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Acción al tocar un resultado
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Abriendo resultados de ${resultados[index]['tipo']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AutorizacionPage extends StatefulWidget {
  const AutorizacionPage({super.key});

  @override
  _AutorizacionPageState createState() => _AutorizacionPageState();
}

class _AutorizacionPageState extends State<AutorizacionPage> {
  List<Map<String, dynamic>> medicamentos = [
    // Lista de medicamentos predefinidos
    {
      'nombre': 'Atorvastatina',
      'estado': 'En proceso',
      'icon': Icons.hourglass_empty
    },
    {
      'nombre': 'Metformina',
      'estado': 'Aprobado',
      'icon': Icons.check_circle,
      'color': Colors.green
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autorización de Medicamentos')),
      body: ListView.builder(
        // Crea una lista desplazable de medicamentos
        itemCount: medicamentos.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(medicamentos[index]['nombre']),
              // Nombre del medicamento
              subtitle: Text('Estado: ${medicamentos[index]['estado']}'),
              // Estado de autorización del medicamento
              trailing: Icon(
                medicamentos[index]['icon'],
                color: medicamentos[index]['color'] ?? Colors.grey,
              ),
              // Icono que representa el estado del medicamento
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddMedicamentoDialog(),
        // Botón para añadir un nuevo medicamento
      ),
    );
  }

  void _showAddMedicamentoDialog() {
    // Función para mostrar el diálogo de añadir medicamento
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nombre = '';
        return AlertDialog(
          title: const Text('Solicitar Medicamento'),
          content: TextField(
            decoration:
                const InputDecoration(labelText: 'Nombre del Medicamento'),
            onChanged: (value) => nombre = value,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Solicitar'),
              onPressed: () {
                setState(() {
                  medicamentos.add({
                    'nombre': nombre,
                    'estado': 'Solicitado',
                    'icon': Icons.watch_later,
                  });
                  // Añade el nuevo medicamento a la lista
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
