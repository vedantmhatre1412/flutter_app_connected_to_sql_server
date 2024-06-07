
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitledtravel/friend_list.dart';

class friend_fwd extends StatefulWidget {
  const friend_fwd({Key? key}) :super(key: key);


  @override
  State<friend_fwd> createState() => _fwd_list();

}

class _fwd_list extends State<friend_fwd>{
  List userdata=[];
  String? mailval;
  String? nameval;
  String removeemail="";

  @override
  void initState(){
    super.initState();

   // getMail();


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

      Text("You clicked friend "+indexd)])));





   // throw UnimplementedError();











  }
}