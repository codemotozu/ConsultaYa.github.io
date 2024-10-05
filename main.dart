import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConsultaYa',
      theme: ThemeData(
        
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConsultaYa',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade100, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.teal,
                child: Icon(Icons.healing, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 30),
              _buildButton(context, 'Gestionar Citas Médicas',
                  Icons.calendar_today, const CitasMedicasPage()),
              _buildButton(context, 'Historia Clínica', Icons.folder_shared,
                  const HistoriaClinicaPage()),
              _buildButton(context, 'Chat', Icons.chat, const ChatPage()),
              _buildButton(context, 'Resultados de Exámenes', Icons.assessment,
                   ResultadosPage()),
              _buildButton(context, 'Autorización de Medicamentos',
                  Icons.local_pharmacy, const AutorizacionPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, IconData icon, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(text),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => page)),
      ),
    );
  }
}

class CitasMedicasPage extends StatefulWidget {
  const CitasMedicasPage({super.key});

  @override
  _CitasMedicasPageState createState() => _CitasMedicasPageState();
}

class _CitasMedicasPageState extends State<CitasMedicasPage> {
  List<Map<String, String>> citas = [
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
      appBar: AppBar(title: const Text('Gestionar Citas Médicas')),
      body: ListView.builder(
        itemCount: citas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(child: Text(citas[index]['doctor']![0])),
              title: Text(
                  '${citas[index]['doctor']} - ${citas[index]['especialidad']}'),
              subtitle:
                  Text('${citas[index]['fecha']} - ${citas[index]['hora']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    citas.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddCitaDialog(),
      ),
    );
  }

  void _showAddCitaDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String doctor = '';
        String especialidad = '';
        String fecha = '';
        String hora = '';

        return AlertDialog(
          title: const Text('Agregar Nueva Cita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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

class HistoriaClinicaPage extends StatelessWidget {
  const HistoriaClinicaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historia Clínica')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildInfoCard('Información Personal', [
              'Nombre: Juan Pérez',
              'Fecha de Nacimiento: 15/05/1980',
              'Grupo Sanguíneo: O+',
            ]),
            const SizedBox(height: 20),
            _buildInfoCard('Historial Médico', [
              'Hipertensión diagnosticada en 2015',
              'Fractura de brazo derecho en 2018',
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Descargando historia clínica...')),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, List<String> info) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...info.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(e),
                )),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(message: '¿Hola, en qué puedo ayudarte?', isMe: false),
    ChatMessage(message: 'Tengo una duda sobre mi medicación', isMe: true),
    ChatMessage(message: 'Claro, cuéntame más sobre tu duda', isMe: false),
  ];

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: _messages[index].message,
                  isMe: _messages[index].isMe,
                );
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
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
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.add(ChatMessage(message: text, isMe: true));
    });
  }
}

class ChatMessage {
  final String message;
  final bool isMe;

  ChatMessage({required this.message, required this.isMe});
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.teal : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class ResultadosPage extends StatelessWidget {
  final List<Map<String, dynamic>> resultados = [
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
      appBar: AppBar(title: const Text('Resultados de Exámenes')),
      body: ListView.builder(
        itemCount: resultados.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(resultados[index]['icon'] as IconData,
                  color: Colors.teal),
              title: Text(resultados[index]['tipo'] as String),
              subtitle: Text('Fecha: ${resultados[index]['fecha']}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
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
        itemCount: medicamentos.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(medicamentos[index]['nombre']),
              subtitle: Text('Estado: ${medicamentos[index]['estado']}'),
              trailing: Icon(
                medicamentos[index]['icon'],
                color: medicamentos[index]['color'] ?? Colors.grey,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddMedicamentoDialog(),
      ),
    );
  }

  void _showAddMedicamentoDialog() {
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
