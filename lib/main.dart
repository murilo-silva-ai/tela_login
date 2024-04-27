import 'package:flutter/material.dart';

void main() {
  runApp(const TelaLogin());
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveForm = GlobalKey<FormState>();
  var _modoLogin = true;
  var _emailInserido = '';
  var _senhaInserida = '';
  var _nomeUsuarioInserido = '';

  void _enviar() async {
    if (!_chaveForm.currentState!.validate()) {
      return;
    }

    _chaveForm.currentState!.save();

    try {
      if (_modoLogin) {
        //logar usuario
        print('Usuário logado! Email: $_emailInserido, Senha: $_senhaInserida');
      } else {
        //criar usuario
        print(
            'Usuário criado! Email: $_emailInserido, Senha: $_senhaInserida, Nome de usuário: $_nomeUsuarioInserido');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: _modoLogin
              ? const Text('Falha no login')
              : const Text('Falha no registro de novo usuário'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 30, bottom: 20, left: 20, right: 20),
                  width: 200,
                  child: Image.network(
                      'https://unicv.edu.br/wp-content/uploads/2020/12/logo-verde-280X100.png',
                      width: 200,
                      height: 200),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _chaveForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_modoLogin)
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Nome de usuário'),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 4) {
                                    return 'Por favor, insira pelo menos 4 caracteres.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _nomeUsuarioInserido = value!;
                                },
                              ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Endereço de email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Por favor, insira um endereço de email válido.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailInserido = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'A senha deve conter ao menos 6 caracteres.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _senhaInserida = value!;
                              },
                            ),
                            const SizedBox(height: 12),
                            Row(
                              // <-- Novo Row para os botões
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // <-- Centralizar o Row
                              children: [
                                ElevatedButton(
                                  onPressed: _enviar,
                                  child:
                                      Text(_modoLogin ? 'Entrar' : 'Cadastrar'),
                                ),
                                const SizedBox(
                                    width: 16), // <-- Espaço entre os botões
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _modoLogin = !_modoLogin;
                                    });
                                  },
                                  child: Text(_modoLogin
                                      ? 'Criar uma conta'
                                      : 'Já tenho uma conta'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
