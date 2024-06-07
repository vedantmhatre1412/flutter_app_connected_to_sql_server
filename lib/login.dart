import 'dart:convert';



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitledtravel/friend_list.dart';
import 'package:untitledtravel/registration.dart';
import 'package:untitledtravel/main.dart';

class login extends StatefulWidget {

  login({Key? key}) :super(key: key);

  @override
  State<login> createState() => _login();
}

class _login extends State<login> {

  String _email = '';
  String _name= '';
  String _numb='';
  String _numbd='';
  String _token='';


  @override
  void initState() {
    super.initState();
    _loadCounter();}


  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signup(BuildContext context) async {

    try{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      _email = result.user!.email!;
      _name=result.user!.displayName!;



      insertrecord1();




    // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }catch(e){

      Fluttertoast.showToast(
          msg: "Please check your internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 255, 221, 0),
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
      if(_email!=""){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>registration()));}


    });
  }

  @override
  void dispose(){
    name.dispose();
    email.dispose();
    super.dispose();
  }




  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = email.text;
      _name=name.text;
      _numb=_numbd;

    });
    prefs.setString('email', _email);
    prefs.setString('name', _name);
    prefs.setString('number', _numb);
  //  prefs.setString('token', _token);
  }


  _incrementCounter1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', _email);
    prefs.setString('name', _name);
    prefs.setString('number', _numbd);
   // prefs.setString('token', _token);
  }








  // This widget is the root of your application.
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  Future<void> insertrecord()async{
if(name.text!="" && email.text!=""){
  final fcmToken = await FirebaseMessaging.instance.getToken();
      try{
        String uri=url+"/insert_record.php";
        print("this is${name.text}");
        var res=await http.post(Uri.parse(uri),body: {

        "name":name.text,
        "email":email.text,
          "token":fcmToken

        });
        var response =jsonDecode(res.body);
        if(response["success"]=="true"){

          print("record inserted");
          _incrementCounter();
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>registration()));

        }
        print(response["success"]);
        if(response["success"]=="exists"){
          _numbd=response["getnumber"];


          _incrementCounter();
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const friend_list()));

        }
        else{print("no");}


      }catch(e){

        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 255, 221, 0),
            textColor: Colors.white,
            fontSize: 16.0
        );

      }}
else{
  if(name.text==""){

    Fluttertoast.showToast(
        msg: "Please enter name",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 255, 221, 0),
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
  if(email.text==""){
    Fluttertoast.showToast(
        msg: "Please enter email address",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 255, 221, 0),
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
}
    }



  Future<void> insertrecord1()async{


      try{
        String uri=url+"/insert_record.php";
        final fcmToken = await FirebaseMessaging.instance.getToken();
  //      print("this is"+_name);
        var res1=await http.post(Uri.parse(uri),body: {

          "name":_name,
          "email":_email,
          "token":fcmToken.toString()

        });
        var response1 =jsonDecode(res1.body);
        if(response1["success"]=="true"){

          print("record inserted");
          _incrementCounter1();
          Fluttertoast.showToast(
              msg: "Logged in as $_name",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>registration()));

        }
        if(response1["success"]=="exists"){
          _numbd=response1["getnumber"];


          print("userexists");


          Fluttertoast.showToast(
              msg: "Logged in as $_name",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              textColor: Colors.white,
              fontSize: 16.0
          );
          print("userexists"+ response1["getnumber"]);
          _incrementCounter1();
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const friend_list()));

        }
        else{print("no");}


      }catch(e){
        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 255, 221, 0),
            textColor: Colors.white,
            fontSize: 16.0
        );

      }}









  ValueNotifier userCredential = ValueNotifier('');

  @override
  Widget build(BuildContext context) {


    return Material(
      child:Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(image:AssetImage('assets/2.jpg'),fit: BoxFit.cover)
      ),child :Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),

        const SizedBox(height: 30,),
        GlassContainer(
            margin: const EdgeInsets.only(top: 50),
            height:500,
            width:300,

            blur: 10,
            alignment: Alignment.center,
            border: 1,
            linearGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white38.withOpacity(0.2)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderGradient: LinearGradient(colors: [
              Colors.white24.withOpacity(0.2),
              Colors.white70.withOpacity(0.2)
            ]),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(

                    margin: const EdgeInsets.only(
                        top:45

                    ),
                    child:Text("Welcome",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight:FontWeight.lerp(FontWeight.bold, FontWeight.w100, 1)



                        ))
                ),Container(
                  width: 250,
                  child: TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      suffixIcon: Icon(Icons.perm_identity_rounded,size: 20),








                    ),
                  ),
                ),
                Container(
                  width: 250,
                  child: TextField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      suffixIcon: Icon(Icons.email_rounded,size: 20,),


                    ),
                  ),
                ),
          Container(
            margin: const EdgeInsets.only(top: 50,bottom: 20),
            height: 45,
            width:250,
            child: ElevatedButton(onPressed: (){
              insertrecord();



            },child: const Text("Sign Up",style: (TextStyle(color: Colors.black)),),)


      ),const Divider(),


          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 45,
            width:250,

            child: ElevatedButton(
              onPressed: (){


              signup(context);



            }, style: ElevatedButton.styleFrom(

              backgroundColor: Colors.black,

            ),
              child: const Wrap(
            children: <Widget>[
            Icon(
             Bootstrap.google,
              color: Colors.white,
              size: 22.0,
            ),
            SizedBox(
              width:10,
            ),
            Text("Sign Up with Google", style:TextStyle(color: Colors.white)),
            ],
          ),
            ),


          )],
          ))])));
        }


}