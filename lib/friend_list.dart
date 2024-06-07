
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitledtravel/addfrnd.dart';
import 'package:untitledtravel/forwardfrnd.dart';
import 'package:untitledtravel/main.dart';
String indexd="";
class friend_list extends StatefulWidget {
  const friend_list({Key? key}) :super(key: key);


  @override
  State<friend_list> createState() => _friend_list();

}

class _friend_list extends State<friend_list>{
  List userdata=[];
  String? mailval;
  String? nameval;
  String removeemail="";

  @override
  void initState(){
    super.initState();

    getMail();


  }

  Future<void>removerec()async{
    try{
      String uri=url+"/remove_friend.php";
      var res=await http.post(Uri.parse(uri),body: {

        "email":mailval,
        "num":removeemail,




      }); var response =jsonDecode(res.body);
      if(response["success"]=="done") {
        setState(() {  Fluttertoast.showToast(
            msg: "User Removed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 0, 225, 0),
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const friend_list()));

        });


      }


    }catch(e){
      print(e);

        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 255, 221, 0),
            textColor: Colors.white,
            fontSize: 16.0
        );


      }}





  Future<void>getrec()async{
    try{
      String uri=url+"/friends.php";

      final fcmToken = await FirebaseMessaging.instance.getToken();
      var res=await http.post(Uri.parse(uri),body: {

        "email":mailval,

        "token":fcmToken.toString()



      });
      setState(() {
        userdata=jsonDecode(res.body);

      });

    
    }catch(e){
      print(e);

    }}

  @override
  void dispose(){
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar:AppBar(backgroundColor:Color.fromRGBO(167, 211, 200, 100), title: const Text("Travel",style: TextStyle(color:Color.fromARGB(255, 50, 50, 50),fontSize: 30,
        fontWeight:FontWeight.bold)
    ),),
      body:Container(

      decoration: const BoxDecoration(
      image: DecorationImage(image:AssetImage('assets/2.jpg'),fit: BoxFit.cover)
    ),child :Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(

          child:Container(

        margin: EdgeInsets.only(top:5,bottom: 70),



      child: ListView.builder(
        shrinkWrap: true,
      itemCount: userdata.length,
      itemBuilder: (BuildContext context, int index) {
        String imgpth=userdata[index]["number"];
        print(imgpth);

        return Container(
          margin: const EdgeInsets.only(left: 14,right: 14,bottom:7),



          child: GlassListTile(
            blur: 15,
            border: 2, linearGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white38.withOpacity(0.2),

              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),








            leading: Container(
                child:ClipOval(



                  child: Image.network(url+"/upload/$imgpth.png",
                    width: 55,
                    height: 80,
                      fit:BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            "assets/pf.png",
                            width: 55,
                            height: 80,
                          fit:BoxFit.cover,

                        );
                      }
                  ),
                ),),
            title: Text(userdata[index]["name"],style:  TextStyle(fontSize:18,fontWeight:FontWeight.lerp(FontWeight.bold,FontWeight.w400 ,1)),textAlign: TextAlign.start,),
            subtitle: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [   Text('${'"'+userdata[index]["bio"]}"',style:  TextStyle(  fontSize:15, fontWeight:FontWeight.lerp(FontWeight.bold, FontWeight.w100, 1)

              ),),Text(userdata[index]["email"] ,style: TextStyle(         fontSize:10,       fontWeight:FontWeight.lerp(FontWeight.bold, FontWeight.w100, 1)
                          ),),


              ]),
            onTap: (){
              indexd=index.toString();

              Navigator.push(context,MaterialPageRoute(builder: (context)=>const friend_fwd()));

            },


            trailing: IconButton(icon:const Icon(Icons.delete_forever),iconSize: 30,color:Colors.grey,onPressed: (){
              setState(() {
                        showDialog(barrierColor: Colors.white,
                                context: context,
                                 builder: (ctx) => AlertDialog(
                                   title: const Text("Delete"),
                                 content:  Text("Do you want to remove ${userdata[index]["name"]} from your friend list"),

                                    actions: <Widget>[


                                      TextButton(
                                        onPressed: () {

                                          Navigator.of(ctx).pop(); setState(() {    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const friend_list()));
                                          }
                                          );









                                        },
                                        child: Container(
                                          color: Colors.black,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text("No",style: TextStyle(color: Colors.white),),
                                        ),
                                      ),


                                                 TextButton(
                                                        onPressed: () {

                                                     Navigator.of(ctx).pop(); setState(() { removeemail=userdata[index]["email"];

                                                     removerec();}
                                                     );


                },
                                   child: Container(
                                         color: Colors.black,
                                         padding: const EdgeInsets.all(14),
                                       child: const Text("Yes",style: TextStyle(color: Colors.white),),
                ),
                ),


                ],
                ),
                );});
                }













            ),





          ),

        );

      },


    ),/*Container(

          margin: EdgeInsets.only(top:5,bottom:5),
          width: 200,
          height: 50,

          child: ElevatedButton(onPressed: (){




            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>addfrnd()));

          },child: Text('+ Add Friend',style: (TextStyle(color: Colors.white)),),

              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.indigo,

              )
          )),*/


















  ))])),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>addfrnd()));
        },
        label: const Text('New Friend',style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.black,
      )
  );
  }
  getMail() async{
    final SharedPreferences u_mail = await SharedPreferences.getInstance();

    setState(() {
      mailval=u_mail.getString('email');
      nameval=u_mail.getString('name');
      getrec();
    });
  }
}
