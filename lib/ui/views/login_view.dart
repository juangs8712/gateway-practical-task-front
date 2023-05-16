import 'package:flutter/material.dart';

import 'package:gateway/ui/inputs/custom_inputs_decorations.dart';
import 'package:gateway/ui/buttons/custom_outlined_button.dart';


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: formKey,
              child: Column(children: <Widget>[

                // Name
                TextFormField(
                  controller: nameCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: CustomInputDecorations.loginInputDecoration(
                      hint: 'Nombre de usuario',
                      label: 'Usuario',
                      icon: Icons.person ),
                  validator: (value) {
                    if ( value?.isEmpty ?? true ) {
                      return 'Nombre de usuario no válido';
                    }
                    return null;
                  },
                ),

                // Password
                const SizedBox(height: 20),
                TextFormField(
                  controller: passCtrl,
                  decoration: CustomInputDecorations.loginInputDecoration(
                    hint: '*******',
                    label: 'Contraseña',
                    icon: Icons.lock_outline_rounded ),
                  obscureText: true,
                  // onFieldSubmitted: (value) => _onLogin( context ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) => ( value?.length ?? 0 ) < 7 
                    ? 'La contraseña debe tener al menos 6 caracteres.' : null,
                ),

                const SizedBox(height: 20),
                CustomOutlinedButton(
                  text: 'Ingresar',
                  isLoading: isLoading,
                  onPressed: (){},
                  // color: Colors.red,
                  // isFilled: true,
                ),
              ])),
        ),
      )
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

