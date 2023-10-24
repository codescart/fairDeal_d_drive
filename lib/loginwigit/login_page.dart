import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:fairdeal/HomeDirectry/home_page.dart';
import 'package:fairdeal/constant/Apihandler.dart';
import 'package:fairdeal/constant/colorconstant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}
TextEditingController phone = TextEditingController();
 TextEditingController password = TextEditingController();
bool isPasswordVisible =true;
bool _loading = false;
final _globalkey = GlobalKey<FormState>();



final  _player = AudioCache();

Sound(String sound)async{
  await _player.play(sound);
}
class _login_pageState extends State<login_page> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/loginbg.png',),fit: BoxFit.fill,
              )
          ),
          child: SingleChildScrollView(
            child:  Form(
              key: _globalkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.7,
                      width: MediaQuery.of(context).size.width*0.4,
                        decoration: BoxDecoration(
                          border: Border.all(width: 3,color:loginborder ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: loginbg.withOpacity(0.8),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                               Container(),
                               Text('For Assument Only',style: TextStyle(
                                 fontSize: MediaQuery.of(context).size.width*0.01,
                                 color: Colors.white
                               ),)
                             ],),
                             GradientText(
                               'Member Login',
                               style: TextStyle(
                                 fontSize: MediaQuery.of(context).size.width*0.025,
                               ),
                               colors: [
                                 Color(0xffe4e20b),
                                 Colors.white,
                                 Color(0xffe4e20b),
                               ],
                             ),
                             SizedBox(
                               height:MediaQuery.of(context).size.height*0.03,
                             ),
                             Padding(
                               padding:  EdgeInsets.only(
                                   left: MediaQuery.of(context).size.height*0.02),
                               child: Align(
                                   alignment: Alignment.topLeft,
                                   child: Text('Username',
                                     style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.03,
                                         fontWeight: FontWeight.bold,color: Colors.white),

                                   )),
                             ),
                             Center(
                               child: Container(
                                 height: MediaQuery.of(context).size.height*0.1,
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 2,color:loginborder ),
                                   borderRadius: BorderRadius.all(
                                     Radius.circular(10),
                                   ),
                                   color: Colors.black,
                                 ),
                                 width: MediaQuery.of(context).size.height*0.7,
                                 padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                                 child:TextFormField(
                                   controller: phone,
                                   textInputAction: TextInputAction.next,
                                   maxLength: 10,
                                   keyboardType: TextInputType.name,
                                   textAlignVertical: TextAlignVertical.bottom,
                                   style: const TextStyle(color: Colors.white),
                                   cursorColor: const Color(0xFF075E54),
                                   decoration: InputDecoration(
                                     counterText: "",
                                     contentPadding: const EdgeInsets.only(bottom: 13.0),
                                     prefixIcon: Container(
                                         margin: const EdgeInsets.only(right: 8),

                                         child: Icon(Icons.account_circle_outlined,color: Colors.white,)),

                                     border: InputBorder.none,
                                     hintText: 'Username',
                                     hintStyle: TextStyle(
                                       color: Colors.grey[400],
                                       fontSize: 15,
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Padding(
                               padding:  EdgeInsets.only(left: MediaQuery.of(context).size.height*0.02),
                               child: Align(
                                 alignment: Alignment.topLeft,
                                   child: Text('Password',
                                     style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.03,fontWeight: FontWeight.bold,color: Colors.white),

                                   )),
                             ),
                             Center(
                               child: Container(
                                 height: MediaQuery.of(context).size.height*0.1,
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 2,color:loginborder ),
                                   borderRadius: BorderRadius.all(
                                     Radius.circular(10),
                                   ),
                                   color: Colors.black,
                                 ),
                                 width: MediaQuery.of(context).size.height*0.7,
                                 padding: const EdgeInsets.only(left: 5.0,),
                                 child:TextFormField(
                                   controller: password,
                                   obscureText: isPasswordVisible,
                                   textInputAction: TextInputAction.next,

                                   maxLength: 10,
                                   keyboardType: TextInputType.phone,
                                   textAlignVertical: TextAlignVertical.bottom,
                                   style: const TextStyle(color: Colors.white),
                                   cursorColor: const Color(0xFF075E54),
                                   decoration: InputDecoration(
                                     counterText: "",
                                     contentPadding: const EdgeInsets.only(bottom: 13.0),
                                     prefixIcon: Container(
                                         margin: const EdgeInsets.only(right: 8),

                                         child: Icon(Icons.password,color: Colors.white,)),

                                    // isPassword: isPasswordVisible,
                                     suffixIcon: GestureDetector(
                                       onTap: () {
                                         setState(() {
                                           isPasswordVisible = !isPasswordVisible ==true;
                                         });

                                       },
                                       child: Icon(
                                         isPasswordVisible ==true

                                             ? Icons.visibility_off
                                             : Icons.visibility,
                                         color: Colors.white,
                                       ),
                                     ),

                                     border: InputBorder.none,
                                     hintText: 'Password',
                                     hintStyle: TextStyle(
                                       color: Colors.grey[400],
                                       fontSize: 15,
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             InkWell(
                               onTap: (){
                                 if (_globalkey.currentState!.validate()) {

                                   _userlogin(phone.text,password.text);
                                   }
                               },
                               child: Container(
                                 decoration: const BoxDecoration(
                                   // borderRadius: BorderRadius.circular(5),
                                   // color: Colors.green,

                                 ),
                                 child:Container(
                                   height: 40,
                                   decoration: BoxDecoration(
                                       image: DecorationImage(
                                           image: AssetImage("assets/btn_sure.png",)
                                       )
                                   ),
                                   width: 200,
                                   child:Center(
                                     child: Text('Login',
                                       style:  GoogleFonts.playfairDisplay( textStyle:TextStyle(
                                         fontSize: 16,fontWeight: FontWeight.w900,color: Colors.white,
                                       ),
                                       ),
                                     ),
                                   ),
                                 ),
                               ),),
                             SizedBox(
                               height: 10,
                             ),
                             Text.rich(
                                 TextSpan(
                                     text: 'New User ? ',
                                     style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),

                                     children:[
                                       TextSpan(
                                         text: 'Sign up here',
                                         style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,
                                           color: Colors.red,decoration: TextDecoration.underline,
                                         ),
                                          // recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyAndPolicy()))
                                       )
                                     ]
                                 )
                             ),
                           ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/ADULT.png',),fit: BoxFit.fill,
                            )
                        ),
                      ),
                      SizedBox(width: 5,),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: IconButton(onPressed: ()async{
                          final prefs = await SharedPreferences.getInstance();
                          final userid=prefs.getString("userId");

                          final response = await http.get(
                            Uri.parse('https://realdeal.apponrent.com/index.php/Mobile_app/logout?userid=$userid'),
                          );
                          print(response);
                          print('wwwwwwwwwwwwww');
                        }, icon: Icon(Icons.refresh)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _userlogin(
      String phone,String password) async {
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(

         Api.baseurl+Api.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "mobile": phone,
        "pin": password,
      }),
    );

    var data = jsonDecode(response.body);
    if (data["error"] == "200") {
      setState(() {
        _loading = false;
      });
      final prefs = await SharedPreferences.getInstance();
      final key = 'userId';
      final userId =data['data'][0]['id'];
      prefs.setString(key, userId);
      print(userId);
      print('qqqqqqqqqqqqqqqq');
      Sound('audio/WelcomeToRealdeal_goodluck.mp3');
      Fluttertoast.showToast(
          msg: data["msg"] ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.green,
          fontSize: 16.0);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>home_page()));

    } else {
      setState(() {
        _loading = false;
      });

      Fluttertoast.showToast(
          msg: data["msg"] ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 16.0);

      print("Error");
    }
  }

}
