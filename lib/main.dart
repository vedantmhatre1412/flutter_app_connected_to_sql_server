
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitledtravel/login.dart';
import 'package:untitledtravel/registration.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart' as ap;
import 'firebase_options.dart';
import 'friend_list.dart';
String url="";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  ap.Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  // runApp(MyApp());
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'App',
    home: splashscrn(),
  ));
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  url="https://evolved-jolly-hippo.ngrok-free.app/travelsign_up";
  print("FCMToken $fcmToken");

  //await Firebase.initializeApp();
}

class splashscrn extends StatefulWidget{
  const splashscrn({super.key}) ;




  @override
  _splashscrn createState() => _splashscrn();
  }



  class _splashscrn extends State<splashscrn>{
    String _email = '';
    String _numb= '';

    @override
    void initState() {

      super.initState();
      _loadCounter();

      _controller=VideoPlayerController.asset('assets/34.mp4') ..initialize().then((_){

        setState(() {


        });
      }).. setVolume(0.0);
      _playvideo();


    }



    _loadCounter() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _email = (prefs.getString('email') ?? '');
        _numb = (prefs.getString('number') ?? '');





      }


      );
    }


  late VideoPlayerController _controller;

  void _playvideo() async{
    _controller.play();
    await Future.delayed(const Duration(seconds: 4));
    if(_email!="" && _numb!=""){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>friend_list()));}



    if(_email!="" && _numb==""){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>registration()));}

    if(_email=="" && _numb==""){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>login()));}


    //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>friend_list()));

  }


@override
void dispose(){
    _controller.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body:Center(
        widthFactor: 25,
        heightFactor: 25,
        child: _controller.value.isInitialized
        ?AspectRatio(aspectRatio: _controller.value.aspectRatio,child: VideoPlayer(
          _controller,

        ),):Container(),
      ));



  }
  
  }