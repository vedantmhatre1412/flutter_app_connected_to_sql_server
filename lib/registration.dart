import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitledtravel/friend_list.dart';
import 'package:untitledtravel/main.dart';
import 'package:untitledtravel/utilis.dart';
class registration extends StatefulWidget {
  @override
  _registration createState() => _registration();

}
class _registration extends State<registration>{
   String? mailval="";
   String? nameval="";
   String? _number="";
   String phoneNumber="";
   String _isloading="";


  @override
  void initState(){
    super.initState();
    getMail();
  }
   Uint8List? imgpath;

   String gender="";
   String? imgdata;
   String? imgg="";
   String? imgname;
   // This widget is the root of your application.
   TextEditingController alt_email=TextEditingController();

   TextEditingController num=TextEditingController();

   TextEditingController bio=TextEditingController();




   ImagePicker imagePicker = ImagePicker();


   _incrementCounter() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       _number= num.text;

     });

     prefs.setString('number', _number!);
   }


   void selectImage() async{
     Uint8List img= await pickImage(ImageSource.gallery);

     setState(() {
       imgpath=img;
       imgg=base64.encode(img);
       print(imgg );
     });
   }


   Future<void> register()async{

if(num.text.length==10){
if(mailval!="" && gender!=""){
  try{
       String uri=url+"/registration.php";
       print("this is"+num.text);
       var res=await http.post(Uri.parse(uri),body: {
         "name":nameval,
         "email":mailval,
         "alt_email":alt_email.text,
         "num":num.text,
         "bio":bio.text,
         "gender":gender,
         "img_data":imgg

       });
       var response=jsonDecode(res.body);
       if(response["success"]=="true"){

         print("record inserted");

         _incrementCounter();
         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const friend_list()));

       }
       else{
         print("no");

       }}catch(e){
    Fluttertoast.showToast(
        msg: "Poor internet connection",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 255, 221, 0),
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> registration()));

  }
  }
else{
  Fluttertoast.showToast(
      msg: "Please fill all the details",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 255, 221, 0),
      textColor: Colors.white,
      fontSize: 16.0
  );

}






     }



else{
  Fluttertoast.showToast(
      msg: "Please enter valid mobile number",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 255, 221, 0),
      textColor: Colors.white,
      fontSize: 16.0
  );

}

   }










   String gen="jk";

   @override
  Widget build(BuildContext context) {
  return Material(

      child:SizedBox(
          height: 200,
          width: 200,
child:
     SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.center ,children: [
            Container(

                margin: const EdgeInsets.only(top:25),


            child: Stack(children: [
              imgpath!=null?

              CircleAvatar(radius: 80, backgroundImage:MemoryImage(imgpath!)):
              const CircleAvatar(radius: 80,
                  backgroundImage: AssetImage("assets/pf.png"),backgroundColor: Colors.white,),
              const Positioned(bottom: -2,left: 105,child:CircleAvatar(backgroundColor: Colors.white,radius: 20,)),


       Positioned(bottom: -5,left: 100,child: IconButton(onPressed: () { selectImage(); }, icon: const Icon(Icons.add_a_photo),color:const Color.fromRGBO(0,0, 0, 1),),),
              ])),

            Container(

                padding: EdgeInsets.only(
                  // change 1
                    top: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 50,
                    // change 2
                    left: 10,
                    right: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [





            Container(margin: const EdgeInsets.only(top:10),child:Text(
              nameval!,
              style: const TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,


                  shadows: [
                    Shadow(color: Colors.white54, offset: Offset(2,1), blurRadius:10)
                  ]
              ),
            ),
            ),



          Container(margin: const EdgeInsets.only(top:0,bottom: 5), child:Text(
                             mailval!,
                            style: const TextStyle(
                            fontSize: 15,
                             color: Colors.black54,
                             fontWeight: FontWeight.normal,

                            fontStyle: FontStyle.italic,
                             shadows: [
                              Shadow(color: Colors.white54, offset: Offset(2,1), blurRadius:10)
                             ]
                              ),),),


              Container(margin: const EdgeInsets.all(10),child: TextFormField(controller:alt_email ,decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Alternate Email')
              )
                ,),),

              Container(margin: const EdgeInsets.all(10),child: TextFormField( controller: num,decoration: const InputDecoration(

                border: OutlineInputBorder(),

                label: Text('Number'),), keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],maxLength: 10,onTap:() {




                },
              ),),










              Container(margin: const EdgeInsets.all(10),child: TextFormField(controller: bio ,decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  label: Text('Bio')),maxLength: 40,)),


              const Text("Gender",style: TextStyle(fontSize: 20,color: Colors.black),),

              RadioListTile(
                    title: const Text("Male"),

                    value: "male",
                    fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
                    groupValue: gender,
                    onChanged: (value){
                      setState(() {
                        gender = value.toString();


                      });
                    },
                  ),

                  RadioListTile(
                    title: const Text("Female"),
                    value: "female",
                    fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
                    groupValue: gender,
                    onChanged: (value){
                      setState(() {
                        gender = value.toString();

                      });
                    },
                  ),

                   RadioListTile(
                    title: const Text("Other"),
                    value: "other",
                    fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
                    groupValue: gender,
                    onChanged: (value){
                      setState(() {
                        gender = value.toString();


                      });
                    },

                  ),












            Container(

              margin: const EdgeInsets.only(top: 25),
              width: 320,
              height: 60,

              child: ElevatedButton(onPressed: () async{
                setState(() {
                  _isloading="yes";
                });

                register();

              },style: ElevatedButton.styleFrom(

                backgroundColor: Colors.black,

              ), child:Container( child: Row( mainAxisAlignment: MainAxisAlignment.center,children: [_isloading!="" ? Container(child: Row( children: [
                  SizedBox(

                  height: 25,
                  width: 25,

                  child: CircularProgressIndicator(color: Colors.white,),

                ) ,Container(margin: EdgeInsets.only(left: 10),child:
                  Text("Joining",style: (TextStyle(color: Colors.white)),))])):


                Text("Join Us",style: (TextStyle(color: Colors.white)),)])))

            ), ]
      ) )])))// This trailing comma makes auto-formatting nicer for
    // build methods.
  );


}
 getMail() async{
    final SharedPreferences u_mail = await SharedPreferences.getInstance();


    setState(() {
      mailval=u_mail.getString('email');
      nameval=u_mail.getString('name');
      _number= (u_mail.getString('number') ?? '');
      print(_number);
      if(_number!=""){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const friend_list()));}


    });
}


  }

