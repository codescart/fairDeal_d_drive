import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:fairdeal/HomeDirectry/Roulette_timex/Roulette_timex_home.dart';
import 'package:fairdeal/constant/Apihandler.dart';
import 'package:fairdeal/constant/colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class greenneighbourbet extends StatefulWidget {
final String gnno;
final int time;
greenneighbourbet({ required this.gnno, required this.time});

  @override
  State<greenneighbourbet> createState() => _greenneighbourbetState();
}

class _greenneighbourbetState extends State<greenneighbourbet> {
  @override
  void initState() {

    _dateTime = DateTime.now().toUtc();
    _clockModel = ClockModel();
    _clockModel.is24HourFormat =  true;

    _dateTime = DateTime.now().toUtc();
    _clockModel.hour = _dateTime.hour;
    _clockModel.minute = _dateTime.minute;
    _clockModel.second = _dateTime.second;

    print('ttttttttttttttttttttttt');
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      yui();
      // showcurrentbet();

      _dateTime = DateTime.now().toUtc();
      _clockModel.hour = _dateTime.hour;
      _clockModel.minute = _dateTime.minute;
      _clockModel.second = _dateTime.second;
      print('radha');
      print(_clockModel.second);
      // pji();
      if(_clockModel.second==50 && neigh==true){
        setState(() {
          neigh=false;
        });
        Navigator.pop(context);


      }else{
        setState(() {
          neigh=true;
        });
      }
    });
    // showcurrentbet();
    super.initState();
  }
  bool chug=false;
  late DateTime _dateTime;
  late ClockModel _clockModel;
  late Timer _timer;
  bool neigh=false;
  final AudioCache  _player = AudioCache(fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
  );
  Sound(String sound)async{
    await _player.load(sound);
        //.play(sound);
  }
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }
  _buildChild(BuildContext context) =>Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: (){
                setState(() {
                  neigh=false;
                });
                Navigator.pop(context);},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),

                height: 40,
                width: 40,
                child: Center(child: Icon(Icons.close)),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.2,),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.7,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/neibour.png')
                  )
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*0.01),
                      child:
                      InkWell(
                        onTap: (){
                          print('bbbbbbbbbbbbbbbbbbbb');

                          betlog(bet:49,
                              amount:batam,
                              betimg:'2');
                          yui(); Sound('audio/coin.mp3');

                        },
                        child: otherdata==null?Container(

                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.12,
                            child: Text('')):otherdata[49]['total']==null?Container(

                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.12,
                            child: Text('')):
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.12,
                            child: Center(child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/chipnew.png')
                                  )
                              ),
                              child: Center(
                                child: Text(otherdata[49]['total'].toString(),
                                  style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.w900,color: Colors.black),
                                ),
                              ),
                            )),
                          ),
                        ),


                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,
                          right: MediaQuery.of(context).size.width*0.01),
                      child: InkWell(
                        onTap: (){
                          print('bbbbbbbbbbbbbbbbbbbb');

                          betlog(bet:50,
                              amount:batam,
                              betimg:'2');
                          yui(); Sound('audio/coin.mp3');

                        },
                        child: otherdata==null?Container(

                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.12,
                            child: Text('')):otherdata[50]['total']==null?Container(

                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.12,
                            child: Text('')):
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.12,
                            child: Center(child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/chipnew.png')
                                  )
                              ),
                              child: Center(
                                child: Text(otherdata[50]['total'].toString(),
                                  style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.w900,color: Colors.black),
                                ),
                              ),
                            )),
                          ),
                        ),


                      ),


                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0,right: 5),
                      child: InkWell(
                        onTap: (){
                          print('bbbbbbbbbbbbbbbbbbbb');

                          betlog(bet:51,
                              amount:batam,
                              betimg:'2');
                          yui(); Sound('audio/coin.mp3');

                        },
                        child: otherdata==null?Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.16,
                            child: Text('')):otherdata[51]['total']==null?Container(

                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.16,
                            child: Text('')):
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            width: MediaQuery.of(context).size.width*0.16,
                            child: Center(child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/chipnew.png')
                                  )
                              ),
                              child: Center(
                                child: Text(otherdata[51]['total'].toString(),
                                  style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.w900,color: Colors.black),
                                ),
                              ),
                            )),
                          ),
                        ),


                      ),

                      // Container(
                      //   // color: Colors.blue,
                      //   height: MediaQuery.of(context).size.height*0.08,
                      //  width: MediaQuery.of(context).size.width*0.16,
                      // ),
                    ),


                    InkWell(
                      onTap: (){
                        print('bbbbbbbbbbbbbbbbbbbb');

                        betlog(bet:52,
                            amount:batam,
                            betimg:'2');
                        yui();
                        Sound('audio/coin.mp3');

                      },
                      child: otherdata==null?Container(

                          height: MediaQuery.of(context).size.height*0.08,
                          width: MediaQuery.of(context).size.width*0.12,
                          child: Text('')):otherdata[52]['total']==null?Container(

                          height: MediaQuery.of(context).size.height*0.08,
                          width: MediaQuery.of(context).size.width*0.12,
                          child: Text('')):
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.08,
                          width: MediaQuery.of(context).size.width*0.12,
                          child: Center(child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/chipnew.png')
                                )
                            ),
                            child: Center(
                              child: Text(otherdata[52]['total'].toString(),
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w900,color: Colors.black),
                              ),
                            ),
                          )),
                        ),
                      ),


                    ),
                  ],
                ),
              ),
            ),
          )

        ],
      )
  );

  betlog({required int bet, required amount, required String betimg}) async{
    var gano = widget.gnno;
    print(bet);
    print(amount);
    print(betimg);

    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.post(
      Uri.parse(
          "https://realdeal.apponrent.com/bet.php?gamesno=$gano&amount=$amount&userid=$userid&gameid=2&bet=$bet&gametype=1"),
    );

    final data = jsonDecode(response.body);
    if (data['error'] == "400") {
      Sound('audio/BalanceLow.mp3');

      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.transparent,
          fontSize: 16.0
      );
    } else {
      // setclr();
      print('ddddddddddddddd');
      print(data['msg']);
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.transparent,
          fontSize: 16.0
      );

      print("Bet not registerd");
    }
  }


  var batam;
  var betimg;
  var otherdata;

  // showcurrent()
  yui()async{
    print('rrrrrr');

    var gano =widget.gnno;
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final pr= await SharedPreferences.getInstance();
    setState(() {
      batam= pr.getString('coin')??'0';
    });
    final res= await http.get(Uri.parse('https://realdeal.apponrent.com/showcurrentbet.php?&userid=$userid&gametype=1&gameid=2'));
    final data=jsonDecode(res.body)['data'];
    setState(() {
      otherdata=data;
    });
    print(otherdata);
  }


}

