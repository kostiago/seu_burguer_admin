import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';
import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/colors_app.dart';
import '../../core/ui/styles/text_styles.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final ReactionDisposer statusReactionDisposer;
  final controller = Modular.get<LoginController>();

  @override
  void initState() {
    statusReactionDisposer = reaction((_) => controller.loginStatus, (status) {
      switch (status) {
        case LoginStateStatus.initial:
          break;
        case LoginStateStatus.loading:
          showLoader();
          break;
        case LoginStateStatus.sucess:
          hideLoader();
          Modular.to.navigate('/');
          break;
        case LoginStateStatus.error:
          hideLoader();
          showError(controller.errorMessage ?? 'Erro Desconhecido');
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    statusReactionDisposer();
    super.dispose();
  }

  void _formSubmit() {
    final formValidator = formKey.currentState?.validate() ?? false;
    if (formValidator) {
      controller.login(emailEC.text, passwordEC.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Scaffold(
      backgroundColor: context.colors.black,
      body: Form(
        key: formKey,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.percentWidth(
                  screenWidth < 1300 ? .7 : .5,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FractionallySizedBox(
                      widthFactor: .3,
                      child: Image.asset('assets/images/admin.png'),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'AdminExpress',
                        style: context.textStyles.textBold.copyWith(
                          color: context.colors.mainColor,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Login',
                        style: context.textStyles.textTitle.copyWith(
                          color: context.colors.mainColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailEC,
                      onFieldSubmitted: (_) => _formSubmit(),
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                      ),
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('E-mail Obrigtorio'),
                          Validatorless.email('E-mail Invalido')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordEC,
                      obscureText: true,
                      onFieldSubmitted: (_) => _formSubmit(),
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      validator: Validatorless.required('Senha Obrigatoria'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _formSubmit,
                        child: const Text(
                          'Entrar',
                        ),
                      ),
                    )
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
