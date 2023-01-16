import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/Pages/chat_page.dart';
import 'package:flutter_chat_proje_app/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class KullanicilarPage extends StatelessWidget {
  const KullanicilarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanicilar'),
      ),
      body: FutureBuilder(
        future: _user.getAllUser(),
        builder: (context, user) {
          if (user.hasData) {
            var allUser = user.data;
            if (allUser!.length - 1 > 0) {
              return ListView.builder(
                itemCount: allUser.length,
                itemBuilder: (context, index) {
                  if (user.data![index].userID != _user.user!.userID) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) => chatPage(
                            currentUser: _user.user!,
                            chatUser: user.data![index],
                          ),
                        ));
                      },
                      child: Card(
                        color: Colors.grey.shade200,
                        shadowColor: Colors.deepOrange,
                        margin: const EdgeInsets.all(7),
                        child: ListTile(
                          title: Text(user.data![index].userName!),
                          subtitle: Text(user.data![index].email!),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(user.data![index].profilImgURL!),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return const Center(
                child: Text('Kayıtlı Kullanıcı Bulunamadı'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
