import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/Pages/hata_exception.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';
import 'package:flutter_chat_proje_app/viewmodel/user_view_model.dart';
import 'package:flutter_chat_proje_app/widgets/social_sing_in_button.dart';
import 'package:provider/provider.dart';

enum FormType { Register, Login }

class SingInEmailPassPage extends StatefulWidget {
  const SingInEmailPassPage({super.key});

  @override
  State<SingInEmailPassPage> createState() => _SingInEmailPassPageState();
}

class _SingInEmailPassPageState extends State<SingInEmailPassPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _pass;
  String? linkText, buttonText;
  var _formType = FormType.Login;

  @override
  Widget build(BuildContext context) {
    buttonText = _formType == FormType.Login ? 'Giriş Yap' : 'Kayıt ol';
    linkText = _formType == FormType.Login
        ? 'Hesabın Yokmu? Kayıt Ol'
        : 'Hesabın Varmı? Giriş Yap';
    var _userModel = Provider.of<UserViewModel>(context);
    if (_userModel.user != null) {
      Future.delayed(const Duration(milliseconds: 200), (() {
        Navigator.of(context).pop();
      }));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Email İle giriş'),
        ),
        body: _userModel.state == ViewState.Idle
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorText: _userModel.emailErrorText != null
                                ? _userModel.emailErrorText
                                : null,
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'email',
                            labelText: 'email',
                            border: const OutlineInputBorder(),
                          ),
                          onSaved: (newValue) {
                            _email = newValue;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: _userModel.passErrorText != null
                                ? _userModel.passErrorText
                                : null,
                            prefixIcon: const Icon(Icons.password_sharp),
                            hintText: 'Şifre',
                            labelText: 'Şifre',
                            border: const OutlineInputBorder(),
                          ),
                          onSaved: (newValue) {
                            _pass = newValue;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SocialSingInWidget(
                          buttonText: buttonText!,
                          buttonIcon: const Icon(Icons.login),
                          buttonColor: Theme.of(context).primaryColor,
                          onPress: () {
                            _formSubmit(context);
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextButton(
                            onPressed: (() => _typeChange()),
                            child: Text(
                              linkText!,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blue.shade300),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  _formSubmit(BuildContext context) async {
    _formKey.currentState!.save();
    var _userModel = Provider.of<UserViewModel>(context, listen: false);
    if (_formType == FormType.Login) {
      try {
        final UserModel user =
            await _userModel.singInWithEmailAndPass(_email!, _pass!);
      } catch (e) {
        debugPrint(
            'email-pass-sing-in dosyasında giriş yapma bölümü hata çıktı${e.hashCode}');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Giriş Yapma Hatası'),
              content: Text(
                ExceptionHata.hatalar(e.toString()),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Kapat')),
                TextButton(
                    onPressed: () {
                      _typeChange();
                      Navigator.pop(context);
                    },
                    child: const Text('Kayıt Ol')),
              ],
            );
          },
        );
      }
    } else {
      try {
        final UserModel user =
            await _userModel.createWithUserEmailAndPass(_email!, _pass!);
      } catch (e) {
        debugPrint(
            'email-pass-sing-in dosyasında kullanıcı oluşturma  bölümü hata çıktı${e.toString()}');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Kullanici Oluştuma Hatası'),
              content: Text(
                ExceptionHata.hatalar(e.toString()),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Kapat'))
              ],
            );
          },
        );
      }
    }
  }

  void _typeChange() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }
}
