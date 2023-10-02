import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime? _birthdate;
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  PickedFile? _selectedImage;

  String _selectedInterest = 'Não Especificado';
  String _selectedLanguage = 'Não Especificado';
  String _selectedEmailNotification = 'Sim';

  final List<String> interests = [
    'Java',
    'Javascript',
    'Python',
    'Não Especificado'
  ];
  final List<String> languages = [
    'Inglês',
    'Português',
    'Espanhol',
    'Não Especificado'
  ];
  final List<String> emailNotifications = ['Sim', 'Não'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Simples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () async {
                      final image = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          _selectedImage = image;
                        });
                      }
                    }),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome Completo'),
              ),
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      setState(() {
                        _birthdate = selectedDate;
                      });
                    }
                  });
                },
                child: Text(
                  _birthdate != null
                      ? 'Data de Nascimento: ${_birthdate!.day.toString().padLeft(2, '0')}-${_birthdate!.month.toString().padLeft(2, '0')}-${_birthdate!.year}'
                      : 'Selecione a Data de Nascimento',
                ),
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Cidade'),
              ),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'País'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tópico de Interesse'),
                  DropdownButtonFormField(
                    value: _selectedInterest,
                    hint: Text('Selecione o Tópico de Interesse'),
                    items: interests.map((interest) {
                      return DropdownMenuItem(
                        value: interest,
                        child: Text(interest),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedInterest = value!;
                      });
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Idioma Preferido'),
                  DropdownButtonFormField(
                    value: _selectedLanguage,
                    hint: Text('Selecione o Idioma Preferido'),
                    items: languages.map((language) {
                      return DropdownMenuItem(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notificação por E-mail'),
                  DropdownButtonFormField(
                    value: _selectedEmailNotification,
                    hint: Text('Selecione Notificação por E-mail'),
                    items: emailNotifications.map((notification) {
                      return DropdownMenuItem(
                        value: notification,
                        child: Text(notification),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedEmailNotification = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text;
                  final city = _cityController.text;
                  final country = _countryController.text;

                  if (name.isEmpty) {
                    // Nome Completo está em branco
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Erro"),
                          content: Text(
                              "O campo Nome Completo não pode estar em branco."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (_birthdate == null) {
                    // Data de Nascimento não foi selecionada
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Erro"),
                          content: Text("Selecione a Data de Nascimento."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (city.isEmpty) {
                    // Cidade está em branco
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Erro"),
                          content:
                              Text("O campo Cidade não pode estar em branco."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (country.isEmpty) {
                    // País está em branco
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Erro"),
                          content:
                              Text("O campo País não pode estar em branco."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Todos os campos estão preenchidos, você pode processar os dados aqui
                    final data = {
                      'Nome': name,
                      'Data de Nascimento':
                          '${_birthdate!.day.toString().padLeft(2, '0')}-${_birthdate!.month.toString().padLeft(2, '0')}-${_birthdate!.year}',
                      'Cidade': city,
                      'País': country,
                      'Tópico de Interesse': _selectedInterest,
                      'Idioma Preferido': _selectedLanguage,
                      'Notificação por E-mail': _selectedEmailNotification,
                    };

                    // Exemplo de exibição dos dados no console
                    print(data);
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
