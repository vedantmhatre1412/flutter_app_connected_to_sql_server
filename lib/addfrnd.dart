
import 'dart:convert';
import 'dart:core';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitledtravel/main.dart';

import 'friend_list.dart';

class addfrnd extends StatefulWidget {
  addfrnd({Key? key}) :super(key: key);
  @override
  State<addfrnd> createState() => _addfrnd();

}

class _addfrnd extends State<addfrnd>{

  String? mailval;
  String? nameval;
  String? numval;

  @override
  void initState(){
    super.initState();

    getMail();

  }


  List userdata=[];
  TextEditingController num=TextEditingController();



  Future<void>getrec()async{
    if(numval!=num.text){
    try{
      String uri=url+"/add_friend.php";
      //print("this is"+name.text);
      var res=await http.post(Uri.parse(uri),body: {
        "num":num.text,
        "email":mailval,
        "name":nameval
      });

      var response =jsonDecode(res.body);
      if(response["success"]=="exists"){
        Fluttertoast.showToast(
            msg: "User is already in your friend list",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 255, 221, 0),
            textColor: Colors.white,
            fontSize: 16.0
        );





      }
      if(response["success"]=="err"){

        Fluttertoast.showToast(
            msg: "User not found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 255, 221, 0),
            textColor: Colors.white,
            fontSize: 16.0
        );}

        if(response["success"]=="done"){

          Fluttertoast.showToast(
              msg: "User added successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );

          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>friend_list()));


      }







    }catch(e){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>friend_list()));



    }}else{
      Fluttertoast.showToast(
          msg: "Please enter your friend's mobile number",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.yellow,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add Friend"),),
        body: Column(children: [




                Container(
                  margin: const EdgeInsets.only(top:150,left: 25,right:25),child: TextFormField(controller: num,decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  label: Text('Enter Number'),), keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly],maxLength: 10,
                ),),



          Container(
              margin: const EdgeInsets.only(top:25),
              width: 200,
              height: 50,

              child: ElevatedButton(onPressed: (){


                getrec();



              },child: const Text('+ Add Friend',style: (TextStyle(color: Colors.white)),),

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.black,

                  )
              )),



           ]));}



  getMail() async{
    final SharedPreferences u_mail = await SharedPreferences.getInstance();

    setState(() {
      mailval=u_mail.getString('email');
      nameval=u_mail.getString('name');
      numval=u_mail.getString('number');
    });
  }














  }


