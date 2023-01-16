import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/viewmodel/user_view_model.dart';
import 'package:flutter_chat_proje_app/widgets/social_sing_in_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late TextEditingController controllerUsername;
  File? profilImg;

  void _cameraImgUpload() async {
    var newImg = await ImagePicker().pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    setState(() {
      profilImg = (File(newImg!.path));
    });
  }

  void _galeriaImgUpload() async {
    var newImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    setState(() {
      profilImg = (File(newImg!.path));
    });
  }

  @override
  void initState() {
    controllerUsername = TextEditingController();
  }

  @override
  void dispose() {
    controllerUsername.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserViewModel>(context);
    controllerUsername.text = _user.user!.userName ?? '';
    debugPrint(_user.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          TextButton(
              onPressed: () => _cikisYap(context),
              child: const Text(
                'Çıkış Yap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 160,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text('Kamera'),
                                onTap: () {
                                  _cameraImgUpload();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text('Galeri'),
                                onTap: () {
                                  _galeriaImgUpload();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: profilImg == null
                        ? NetworkImage(_user.user!.profilImgURL!)
                        : FileImage(profilImg!) as ImageProvider,
                    radius: 70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: _user.user!.email,
                  readOnly: true,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: controllerUsername,
                  decoration: const InputDecoration(
                      labelText: 'UserName',
                      hintText: 'UserName',
                      border: OutlineInputBorder()),
                ),
              ),
              SocialSingInWidget(
                buttonText: 'Değişiklikleri Kayıt Et',
                buttonIcon: const Icon(Icons.data_saver_on_sharp),
                onPress: () async {
                  _userNameUpdate(context);
                  _profilImgUpdate(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cikisYap(BuildContext context) async {
    final _usermodel = Provider.of<UserViewModel>(context, listen: false);
    _usermodel.singOut();
  }

  void _userNameUpdate(
    BuildContext context,
  ) async {
    final _user = Provider.of<UserViewModel>(context, listen: false);
    if (_user.user?.userName != controllerUsername.text) {
      bool updateResalt = await _user.updateUserName(
          _user.user!.userID!, controllerUsername.text);
      if (updateResalt == true) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Başarılı'),
              content: const Text('Username de Degişiklik Yapıldı'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Kapat')),
              ],
            );
          },
        );
      } else {
        _user.user?.userName = controllerUsername.text;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(' Hata'),
              content: const Text('Username zaten kullanımda'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Kapat')),
              ],
            );
          },
        );
      }
    }
  }

  void _profilImgUpdate(BuildContext context) async {
    final _user = Provider.of<UserViewModel>(context, listen: false);
    if (profilImg != null) {
      var url = await _user.uploadFile(
          _user.user!.userID.toString(), 'profil-foto', profilImg!);
      debugPrint('gelen indirme linki $url');
      var sonuc = await _user.updateProfilImgURL(_user.user!.userID, url);
      if (sonuc) {
        debugPrint(
            '********************* Profilurl başarılı bir sekilde güncellendi');
      }
    }
  }
}
