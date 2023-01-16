import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_proje_app/Pages/videoplayer.dart';
import 'package:flutter_chat_proje_app/models/message_model.dart';
import 'package:flutter_chat_proje_app/models/user_model.dart';
import 'package:flutter_chat_proje_app/viewmodel/user_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class chatPage extends StatefulWidget {
  final UserModel currentUser;
  final UserModel chatUser;
  chatPage({super.key, required this.currentUser, required this.chatUser});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  TextEditingController mesajController = TextEditingController();

  File? imgData;
  File? videoData;

  void _cameraImgUpload() async {
    var newImg = await ImagePicker().pickImage(source: ImageSource.camera);
    imgData = (File(newImg!.path));
    imgDateUpdate(context);
    imgData = null;
    Navigator.of(context).pop();
  }

  void _galeriaImgUpload() async {
    var newImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    imgData = (File(newImg!.path));
    debugPrint('imgdata:$imgData');
    debugPrint('imgdata:$videoData');

    imgDateUpdate(context);
    imgData = null;
    Navigator.of(context).pop();
  }

  void _galeriaVideoUpload() async {
    var newVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    videoData = (File(newVideo!.path));
    imgDateUpdate(context);
    videoData = null;
    Navigator.of(context).pop();
  }

  void _cameraVideoUpload() async {
    var newVideo = await ImagePicker().pickVideo(source: ImageSource.camera);
    videoData = (File(newVideo!.path));
    imgDateUpdate(context);
    videoData = null;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          elevation: 40,
          title: Text(
            widget.chatUser.userName!,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.chatUser.profilImgURL!),
            ),
            const SizedBox(
              width: 20,
            ),
          ]),
      body: Center(
          child: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<Message>>(
            stream: _user.getMessages(
                widget.currentUser.userID!, widget.chatUser.userID!),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Message> allMessage = snapshot.data!;
              return ListView.builder(
                itemCount: allMessage.length,
                itemBuilder: (context, index) {
                  return _chatWidgetCreate(allMessage[index]);
                },
              );
            },
          )),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: mesajController,
                  cursorColor: Colors.blueGrey,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Mesajınızı Yazın",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Container(
                  child: IconButton(
                      iconSize: 30,
                      onPressed: (() {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 250,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera),
                                    title: const Text('Kamera'),
                                    onTap: () {
                                      _cameraImgUpload();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text('Galeri'),
                                    onTap: () {
                                      _galeriaImgUpload();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.video_call),
                                    title: const Text('Video Çek'),
                                    onTap: () {
                                      _cameraVideoUpload();
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        const Icon(Icons.video_camera_front),
                                    title: const Text('Video Yükle'),
                                    onTap: () {
                                      _galeriaVideoUpload();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                      icon: const Icon(CupertinoIcons.paperclip))),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.navigate_next,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (mesajController.text.trim().isNotEmpty) {
                        Message saveMessage = Message(
                            kimden: widget.currentUser.userID,
                            kime: widget.chatUser.userID,
                            bendenMi: true,
                            mesaj: mesajController.text);
                        mesajController.clear();
                        await _user.saveMessage(saveMessage);
                      }
                    }),
              ),
            ],
          )
        ],
      )),
    );
  }

  Widget _chatWidgetCreate(Message allMessage) {
    var sendMessageColor = Colors.grey.shade300; //giden mesaj
    var takeMessageColor = Colors.deepOrange.shade200;
    var myIsmessage = allMessage.bendenMi;
    if (myIsmessage!) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: sendMessageColor,
                ),
                child: _chatWidgetCreateTo(allMessage)),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: takeMessageColor,
                ),
                child: _chatWidgetCreateTo(allMessage))
          ],
        ),
      );
    }
  }

  Widget _chatWidgetCreateTo(Message message) {
    if (message.img != null) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Image(
                  width: 300,
                  height: 400,
                  image: NetworkImage(message.img!),
                ),
              );
            },
          );
        },
        child: Image(
          width: 150,
          height: 150,
          image: NetworkImage(message.img!),
        ),
      );
    }
    if (message.video != null) {
      return TextButton.icon(
          style: ButtonStyle(),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoApp(message.video!),
            ));
          },
          icon: Icon(Icons.plus_one_rounded),
          label: Text('Video'));
    } else {
      return Text(message.mesaj!);
    }
  }

  void imgDateUpdate(BuildContext context) async {
    final _user = Provider.of<UserViewModel>(context, listen: false);
    if (imgData != null) {
      var url = await _user.uploadImgDateFile(
          _user.user!.userID.toString(), 'img-data', imgData!);
      debugPrint('-------------------gelen indirme linki $url');
      Message saveMessage = Message(
          kimden: widget.currentUser.userID,
          kime: widget.chatUser.userID,
          bendenMi: true,
          img: url);
      mesajController.clear();
      await _user.saveMessage(saveMessage);
    }
    if (videoData != null) {
      var url = await _user.uploadImgDateFile(
          _user.user!.userID.toString(), 'img-data', videoData!);
      debugPrint('-------------------gelen indirme linki $url');
      Message saveMessage = Message(
          kimden: widget.currentUser.userID,
          kime: widget.chatUser.userID,
          bendenMi: true,
          video: url);
      mesajController.clear();
      await _user.saveMessage(saveMessage);
    }
  }
}
