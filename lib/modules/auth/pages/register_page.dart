import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:login_app/api/models/user.model.dart';
import 'package:login_app/api/users/users_registered.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _showCountdownModal(BuildContext context) {
    int countdown = 3;
    late Timer timer;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              if (countdown > 1) {
                if (mounted) {
                  setModalState(() {
                    countdown--;
                  });
                }
              } else {
                timer.cancel();
                if (mounted) {
                  Navigator.of(context).pop();
                  context.go('/');
                }
              }
            });

            return AlertDialog(
              backgroundColor: Colors.blue.shade800,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, size: 50, color: Colors.white),
                  const SizedBox(height: 20),
                  Text(
                    'Redirigiendo en $countdown...',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      if (timer.isActive) timer.cancel();
    });
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      final isEmailTaken = usersRegistered.any(
        (user) => user.email == _emailController.text.trim(),
      );

      if (isEmailTaken) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El correo ya está registrado. Intente con otro, por favor.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final User newUser = User(
          id: const Uuid().v4(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneController.text.trim(),
          name: _nameController.text.trim(),
          profile: "assets/new_user.jpg");

      setState(() {
        usersRegistered.add(newUser);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado con éxito')),
      );

      _showCountdownModal(context);

      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    }
  }

  InputDecoration _inputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      hintText: labelText,
      hintStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white),
      ),
      prefixIcon: Icon(icon, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_add,
                        size: 100, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text(
                      'Crea tu cuenta',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration('Nombre', Icons.person),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El nombre es obligatorio';
                        } else if (value.length < 3) {
                          return 'Debe tener al menos 3 caracteres';
                        } else if (value.length > 10) {
                          return 'No puede tener más de 10 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration:
                          _inputDecoration('Correo Electrónico', Icons.email),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El correo es obligatorio';
                        }
                        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@unah(\.edu)?\.hn$')
                            .hasMatch(value.trim())) {
                          return 'Debe terminar en unah.edu.hn o unah.hn';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      decoration: _inputDecoration('Teléfono', Icons.phone),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El teléfono es obligatorio';
                        }
                        if (!RegExp(r'^[39]\d{7}$').hasMatch(value)) {
                          return 'Debe iniciar con 3 o 9 y tener 8 dígitos';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: _inputDecoration(
                        'Contraseña',
                        Icons.lock,
                      ).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La contraseña es obligatoria';
                        } else if (!RegExp(
                                r'^(?=.*[A-Z])(?=.*[!@#\$&*~]).{8,}$')
                            .hasMatch(value)) {
                          return 'Debe tener 8 caracteres, una mayúscula y un caracter especial';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: _inputDecoration(
                        'Confirmar Contraseña',
                        Icons.lock,
                      ).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isConfirmPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
