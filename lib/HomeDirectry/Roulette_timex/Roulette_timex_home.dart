import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:fairdeal/HomeDirectry/Roulette_timex/Neighbourbet.dart';
import 'package:fairdeal/HomeDirectry/Roulette_timex/gameRule.dart';
import 'package:fairdeal/HomeDirectry/game_history_blue.dart';
import 'package:fairdeal/constant/Apihandler.dart';
import 'package:fairdeal/loginwigit/login_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:circular_countdown/circular_countdown.dart';
import 'package:fairdeal/HomeDirectry/Roulette_timex/Roulette_timexAppbar.dart';
import 'package:fairdeal/HomeDirectry/Roulette_timex/casino_board.dart';
import 'package:fairdeal/HomeDirectry/Roulette_timex/gameHistory.dart';
import 'package:fairdeal/HomeDirectry/Roulette_timex/spinwheel.dart';
import 'package:fairdeal/constant/colorconstant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class ClockModel {

  late int hour;
  late int minute;
  late int second;
  late bool is24HourFormat;

  get is24HourTimeFormat => this.is24HourFormat;
}



class Roulette_timex_home extends StatefulWidget {
  const Roulette_timex_home({Key? key}) : super(key: key);

  @override
  State<Roulette_timex_home> createState() => _Roulette_timex_homeState();
}

class _Roulette_timex_homeState extends State<Roulette_timex_home>with SingleTickerProviderStateMixin {


  late final AnimationController _controller = AnimationController(vsync: this,
      duration: Duration(milliseconds: 9000))..repeat();

  static const List batvalset= <String>[
    '2',
    '5',
    '10',
    '50',
    '100',
    '500',
    '1000',
    '3000',
  ];
  static const List batvals= <String>[
    '2',
    '5',
    '10',
    '50',
    '100',
    '500',
    '1K',
    '3K',
  ];
  var batam;
  var betimg;
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    _dateTime = DateTime.now().toUtc();
    _clockModel = ClockModel();
    _clockModel.is24HourFormat =  true;

    _dateTime = DateTime.now().toUtc();
    _clockModel.hour = _dateTime.hour;
    _clockModel.minute = _dateTime.minute;
    _clockModel.second = _dateTime.second;

    print('ttttttttttttttttttttttt');
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      showcurrentbet();
      viewprofile();
      showlastresult();

      _dateTime = DateTime.now().toUtc();
      _clockModel.hour = _dateTime.hour;
      _clockModel.minute = _dateTime.minute;
      _clockModel.second = _dateTime.second;

      print(_clockModel.second);
      // pji();

      setState(() {
        time=_clockModel.second;
        //_clockModel.second;
        timesd=40-_clockModel.second;
        double calc=_clockModel.second/40;
        String timexdl=calc.toStringAsFixed(2);
        timexd= double.parse(timexdl);
      });


      if(_clockModel.second>=36){

        setState(() {
          c=true;
        });
      }else{
        setState(() {
          c=false;
        });
      }
      if(_clockModel.second==40){

        setState(() {
          win ='38';
          timeup=true;
          watch=false;
          chakra=false;
        });
      }
      if(_clockModel.second==48){
        setState(() {
          // chakra=true;
        });
        pji();

      }
      if(_clockModel.second==57){
        youwon();

        pji();
      }
      if(_clockModel.second>=58){
        setState(() {
          win =winne;
          chuga=true;

        });
      winnersound(win);
        yui();
      }
      if(_clockModel.second==1){
        lockcheck();
        placechips();
        setState(() {
          // won='0';
          timeup=false;
          chuga=false;
          rep=false;
          watch=true;

        });
      }



    });
    super.initState();

    showcurrentbet();
    viewprofile();
    showlastresult();



  }

  bool chuga=false;
  bool timeup=false;
  bool chakra=false;
  bool watch=false;
  var sno='0';
  lockcheck() async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final res= await http.get(Uri.parse('https://realdeal.apponrent.com/checkstatus.php?userid=$userid'));
    final dala=jsonDecode(res.body)['error'];
    if(dala != "200"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login_page()));
    }
  }

  pji()async{
    //
    print('radhe radhe');
    print(timexd);
    final response = await http.get(
      Uri.parse('https://realdeal.apponrent.com/lastgamesno.php?gameid=1&gametype=1'),
    );
    final gata=jsonDecode(response.body);
    setState(() {
      sno = gata["gamesno"].toString();

    });
  }
  var timesd;
  double timexd=0.10;

  bool c=false;
  final AudioCache  _player = AudioCache(fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
  );

  Sound(String sound)async{
    await _player.play(sound);
  }

var time=0;
  var maped;
  Future viewprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.get(
      Uri.parse(Api.baseurl+Api.homeprofile+'user_id=$userid'),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() {
        maped =data['data'];
      });
    }
  }


  var won='0';
   youwon() async {
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.get(
      Uri.parse('https://realdeal.apponrent.com/totalwinamount.php?gamesno=$sno&userid=$userid&gameid=1'),
    );
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      var data = jsonDecode(response.body);

      setState(() {
        won =data['totalwin'].toString();
      });
    }
  }

  var map;
  String dap='0';
  var data;
  showcurrentbet() async {
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    print("https://realdeal.apponrent.com/showcurrentbet.php?gamesno=$sno&userid=$userid&gametype=1&gameid=1");
    final respo = await http.get(
      Uri.parse('https://realdeal.apponrent.com/showcurrentbet.php?gamesno=$sno&userid=$userid&gametype=1&gameid=1'),
    );
    // var
    final dhaba=jsonDecode(respo.body);
      setState(() {
         data = dhaba;
        map =data['data'];
        dap =data['totalbet'].toString();
      });

      print("uuuuuuuuuuuuuuuuu");
      print(map);
      print("ooooooooooooooooooooo");
      for (var item in map) {
        print(item['totalbet']);

      }
  }
  var win='38';
  showlastresult() async {
    // final prefs = await SharedPreferences.getInstance();
    // final userid=prefs.getString("userId");
    final respo = await http.get(
      Uri.parse('https://realdeal.apponrent.com/lastresult.php?gameid=1'),
    );
    // var
     var dat = jsonDecode(respo.body)['winnerno'];


    setState(() {
      winne =dat.toString();
    });

  }
var winne='38';
  int tom=0;
  late double percent;
  final red = {1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36};

  late DateTime _dateTime;
  late ClockModel _clockModel;
  late Timer _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: roulette_appbar(),
      // appBar: roulette_appbar(),
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.black,
                content: Container(
                  height: 250.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/golobby.jpeg')
                      )
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 160.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.pop(context,true);
                            },
                            child: Container(

                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                          SizedBox(
                            width: 40.w,
                          ),

                          InkWell(
                            onTap:(){
                              Navigator.pop(context,false);
                            },
                            child: Container(
                              height: 30.h,
                              width: 30.w,


                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
          return shouldPop!;
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image:  AssetImage('assets/bg.png',),fit: BoxFit.fill,
              )
          ),
          child: Stack(
            children: [
              ///chips
              Positioned(
                left: MediaQuery.of(context).size.width*0.30,
                // right: MediaQuery.of(context).size.width*0.006,
                bottom: MediaQuery.of(context).size.height*0.20,
                child: Transform.rotate(
                  angle: -math.pi /6.72,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    padding: EdgeInsets.all(3),
                    height:MediaQuery.of(context).size.height*0.10,
                    width: MediaQuery.of(context).size.width*0.44,
                    child: ListView.builder(

                        scrollDirection: Axis.horizontal,
                        itemCount: batvals.length,
                        itemBuilder: (BuildContext context, int index) {

                          return Padding(
                            padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.012),
                            child: InkWell(
                              onTap: () async{
                                final prefs= await SharedPreferences.getInstance();
                                prefs.setString('coin', batvalset[index].toString());
                                yui();
                                // Sound('audio/coin.mp3');

                                setState(() {
                                  batam= batvalset[index].toString();
                                  betimg = batvals[index].toString();
                                });

                                // Betregisteredfunroulette("Andar",batval[index].toString());
                              },
                              child: Container(
                                  height: MediaQuery.of(context).size.width*0.04,
                                  width: MediaQuery.of(context).size.width*0.04,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/coingreen.png')
                                      )
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(1),
                                    child: Center(
                                      child: Text(
                                        batvals[index].toString(),style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width*0.012,
                                          fontWeight: FontWeight.w900,color: Colors.black
                                      ),
                                      ),
                                    ),
                                  )
                                // CircleAvatar(
                                //
                                //   radius: widget.widths*0.05,
                                //   child: Image.asset(batvals[index].toString()),
                                // ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ),
              ),
              ///casino board
              Positioned(
                // left: -MediaQuery.of(context).size.width*0.001.w,
                left: 3.w,
                // right: MediaQuery.of(context).size.width*0.006,
                // top: MediaQuery.of(context).size.height*0.34.h,
                bottom: 6.h,
                child: RouletteLayout(
                    result:win,
                    // widths: MediaQuery.of(context).size.width*0.62,
                    // heights:MediaQuery.of(context).size.height*0.49
                    widths: 300.w,
                    heights:280.h,
                    gnno: sno,
                    chuga:chuga,
                    time:time
                ),
              ),
              ///chakra
              ///
              Positioned (
                  top:-04.h,
                  //  MediaQuery.of(context).size.height-0.001,
                  right: 34.w,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0015)
                      ..rotateX(-20),
                    child: AnimatedBuilder(
                        animation: _controller,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle:
                            _controller.value * 2 * math.pi,
                            child: Casino(
                              pad:60.h,
                              widthc:102.w,
                              heightc: 102.w,

                              result: win==null?'65':win.toString(),
                              time: time, gnno: '',


                            ),
                          );
                        }
                    ),
                  )),


              Positioned(
                  top:11.h,
                  //  MediaQuery.of,(context).size.height-0.001,
                  right: 67.w,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0018)
                      ..rotateX(-18),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.20.h,
                      width: MediaQuery.of(context).size.width*0.017.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/hhh.png'),
                          )
                      ),
                    ),
                  )),
              ///neighbourbet
              Positioned(
                bottom:MediaQuery.of(context).size.height*0.08.h,
                left: MediaQuery.of(context).size.height*0.00.w,
                // left: MediaQuery.of(context).size.width*0.150,
                child: InkWell(
                  onTap: (){

                    showDialog(
                      context: context,
                      builder: (BuildContext context) => neighbourbet(

                          time: time, gnno: '',

                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.08.h,
                    width: MediaQuery.of(context).size.width*0.04.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:  AssetImage('assets/betbutton.png',),fit: BoxFit.fill,
                        )
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(2.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('NEIGHBOUR',maxLines: 1,
                              style: TextStyle(
                                  fontSize:MediaQuery.of(context).size.width*0.012.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900
                              )),
                          Center(
                            child: Text('BET',maxLines: 1,style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width*0.012.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w900
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ///time
              watch==true?
              Positioned(
                bottom: MediaQuery.of(context).size.height*0.09.h,
                right: 0,
                child: Container(
                  height: 87.h,
                  width: 43.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image:  AssetImage('assets/framefun.png',)
                        ,fit: BoxFit.fill,
                      )
                  ),
                  // decoration: BoxDecoration(
                  //   border: Border.all(width: 3,color:Color(0xffFFD700) ),
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(10),
                  //   ),
                  //   color: loginbg.withOpacity(0.8),
                  // ),
                  child:Center(
                    child: CircularPercentIndicator(
                      radius: 35.h,
                      lineWidth: 10.h,
                      percent: timexd,
                      center:  Text(timesd.toString(),
                        style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w900,
                          color:Colors.white,),

                      ),
                      progressColor: c==false?Colors.blue:Colors.red,
                    ),
                  ),
                ),
              ):Container(),
              ///wallet
              Positioned(
                  top:180,
                  left:50,
                  child:Text(time.toString())),
              Positioned(
                bottom: 0.h,
                left: MediaQuery.of(context).size.width*0.00.w,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.08.h,
                  width: MediaQuery.of(context).size.width*0.05.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image:  AssetImage('assets/button_pay.png',),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(2.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Point Balance',style: TextStyle(
                            fontSize: 8.0.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w900
                        )),
                        Center(
                          child: Text(maped==null?'':maped['wallet'],style: TextStyle(
                              fontSize: 12.0.sp,
                              color: Colors.white
                          )),
                        ),


                      ],
                    ),
                  ),
                ),
              ),

              ///name
              Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width*0.05.w,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.08.h,
                  width: MediaQuery.of(context).size.width*0.05.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image:  AssetImage('assets/button_pay.png',),fit: BoxFit.fill,
                      )
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(2.0.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text('Name',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 08.0.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900

                              )),
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.12.w,
                            child: Text(maped==null?'':maped['full_name'],
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 13.0.sp,
                                    color: Colors.white
                                )),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),

              ///bet confirm
              Positioned(
                bottom: MediaQuery.of(context).size.height*0.15.h,
                right: MediaQuery.of(context).size.width*0.08.w,
                child: InkWell(
                  onTap: (){
                    betconfirm();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.08.h,
                    width: MediaQuery.of(context).size.width*0.07.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:  AssetImage('assets/werty.png',),fit: BoxFit.fill,
                        )
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(4.0.h),
                      child: Center(
                        child: Text('Bet Confirm',style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width*0.020.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w900
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              ///game history
              Positioned(
                bottom: 0.h,
                right: MediaQuery.of(context).size.width*0.05.w,
                child: InkWell(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => gameHistory_blue(),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.115.h,
                    width: MediaQuery.of(context).size.width*0.06.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:  AssetImage('assets/betbutton.png',),fit: BoxFit.fill,
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Center(
                          child: Text('Game\nHistory',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.022.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),

                        Icon(Icons.settings_suggest_outlined,color: Colors.black,
                            size: MediaQuery.of(context).size.width*0.022.sp),
                      ],
                    ),
                  ),
                ),
              ),
              ///game leave
              Positioned(
                bottom: 0.h,
                right: MediaQuery.of(context).size.width*0.0.w,
                child: InkWell(
                  onTap: (){
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: Colors.black,
                          content: Container(
                            height: 250.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/golobby.jpeg')
                                )
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 160.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        Navigator.pop(context);
                                      },
                                      child: Container(

                                        height: 30.h,
                                        width: 30.w,


                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.w,
                                    ),

                                    InkWell(
                                      onTap:(){
                                        Navigator.pop(context,false);
                                      },
                                      child: Container(
                                        height: 30.h,
                                        width: 30.w,


                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                     height: 18.h,
                     width: 30.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:  AssetImage('assets/leave.png',),fit: BoxFit.fill,
                        )
                    ),

                  ),
                ),
              ),

              ///clear repeat

              watch==false? Container():

              Positioned(
                bottom: 0.h,
                right: MediaQuery.of(context).size.width*0.11.w,
                child: Container(
                  child: Row(
                    children: [
                      dap=='0'? Container():
                      InkWell(
                        onTap: (){
                          clearbet();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.076.h,
                          width: MediaQuery.of(context).size.width*0.05.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:  AssetImage('assets/betbutton.png',),fit: BoxFit.fill,
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('Clear Bet',style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.02.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              )),

                              Icon(Icons.close,color: Colors.black,size:
                              MediaQuery.of(context).size.width*0.02.sp,),
                            ],
                          ),
                        ),
                      ),
                      dap=='0'? Container():
                      InkWell(
                        onTap: ()async{
                          final prefs= await SharedPreferences.getInstance();
                          prefs.setString('coin', 'rem');

                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.076.h,
                          width: MediaQuery.of(context).size.width*0.05.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:  AssetImage('assets/betbutton.png',),fit: BoxFit.fill,
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('Remove',style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.02.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900
                              )),
                              Icon(Icons.delete_forever_outlined,color: Colors.black,size:
                              MediaQuery.of(context).size.width*0.02.sp,),
                            ],
                          ),
                        ),
                      ),
                      timeup == false && rep==false?
                      InkWell(
                        onTap: (){
                          repeat();
                          setState(() {
                            rep=true;
                          });
                          Sound('audio/Repeat.mp3');
                          // showlastresult();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.076.h,
                          width: MediaQuery.of(context).size.width*0.05.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:  AssetImage('assets/betbutton.png',),fit: BoxFit.fill,
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('Repeat',style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.02.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              )),

                              Icon(Icons.replay_sharp,color: Colors.black,
                                size:MediaQuery.of(context).size.width*0.02.sp,),
                            ],
                          ),
                        ),
                      ):timeup == false?
                      InkWell(
                        onTap: (){
                          Betdouble();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.076.h,
                          width: MediaQuery.of(context).size.width*0.05.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:  AssetImage('assets/betbutton.png',),fit: BoxFit.fill,
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('Double',style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.017.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              )),

                              Icon(Icons.content_copy,color: Colors.black,
                                size:
                                MediaQuery.of(context).size.width*0.02.sp,),
                            ],
                          ),
                        ),
                      ):Container(),
                    ],
                  ),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        height: MediaQuery.of(context).size.height*0.39.h,
                        width: MediaQuery.of(context).size.width*0.045.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image:AssetImage('assets/bettingreslt.png',),
                              fit: BoxFit.fill,
                            )
                        ),
                        child: Padding(
                            padding:  EdgeInsets.only(left: 2.0.w,right: 4.w,top: 8.h,bottom: 8.h),
                            child: ListView.builder(
                                itemCount: allrounf.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return   Padding(
                                    padding:  EdgeInsets.only(left:5.h, right:5.h),
                                    child: Row(
                                      mainAxisAlignment: allrounf[index].toString()== "1"|| allrounf[index].toString()== "3"|| allrounf[index].toString()==  "5"|| allrounf[index].toString()==  "7"|| allrounf[index].toString()==  "9"|| allrounf[index].toString()==  "12"|| allrounf[index].toString()==  "14"|| allrounf[index].toString()==  "16"|| allrounf[index].toString()==  "18"|| allrounf[index].toString()==  "19"|| allrounf[index].toString()==  "21"|| allrounf[index].toString()==  "23"|| allrounf[index].toString()==  "25"|| allrounf[index].toString()==  "27"|| allrounf[index].toString()==  "30"|| allrounf[index].toString()==  "32"|| allrounf[index].toString()==  "34"|| allrounf[index].toString()==  "36"?
                                      MainAxisAlignment.end: allrounf[index].toString()== "0"?MainAxisAlignment.center:MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Text('${allrounf[index].toString()}',style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.w900,
                                            color: allrounf[index].toString()== "1"|| allrounf[index].toString()== "3"||
                                                allrounf[index].toString()==  "5"|| allrounf[index].toString()==  "7"||
                                                allrounf[index].toString()==  "9"|| allrounf[index].toString()==  "12"||
                                                allrounf[index].toString()==  "14"|| allrounf[index].toString()==  "16"||
                                                allrounf[index].toString()==  "18"|| allrounf[index].toString()==  "19"||
                                                allrounf[index].toString()==  "21"|| allrounf[index].toString()==  "23"||
                                                allrounf[index].toString()==  "25"|| allrounf[index].toString()==  "27"||
                                                allrounf[index].toString()==  "30"|| allrounf[index].toString()==  "32"||
                                                allrounf[index].toString()==  "34"|| allrounf[index].toString()==  "36"?
                                            Colors.red:allrounf[index].toString()==  "0"?Colors.green:Colors.yellow
                                        )),


                                      ],
                                    ),
                                  );
                                }
                            )


                          // FutureBuilder<List<alldata>>(
                          //     future: yui(),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.hasError) print(snapshot.error);
                          //       return snapshot.hasData
                          //           ? ListView.builder(
                          //         itemCount: snapshot.data!.length,
                          //         physics: NeverScrollableScrollPhysics(),
                          //         shrinkWrap: true,
                          //         itemBuilder: (context, index) {
                          //           return   Padding(
                          //             padding:  EdgeInsets.only(left:5.h, right:5.h),
                          //             child: Row(
                          //               mainAxisAlignment: snapshot.data![index].betno== "1"|| snapshot.data![index].betno== "3"|| snapshot.data![index].betno==  "5"|| snapshot.data![index].betno==  "7"|| snapshot.data![index].betno==  "9"|| snapshot.data![index].betno==  "12"|| snapshot.data![index].betno==  "14"|| snapshot.data![index].betno==  "16"|| snapshot.data![index].betno==  "18"|| snapshot.data![index].betno==  "19"|| snapshot.data![index].betno==  "21"|| snapshot.data![index].betno==  "23"|| snapshot.data![index].betno==  "25"|| snapshot.data![index].betno==  "27"|| snapshot.data![index].betno==  "30"|| snapshot.data![index].betno==  "32"|| snapshot.data![index].betno==  "34"|| snapshot.data![index].betno==  "36"?
                          //               MainAxisAlignment.end: snapshot.data![index].betno== "0"?MainAxisAlignment.center:MainAxisAlignment.start,
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //
                          //               children: [
                          //                 Text('${snapshot.data![index].betno}',style: TextStyle(
                          //                     fontSize: 9.sp,
                          //                     fontWeight: FontWeight.w900,
                          //                     color: snapshot.data![index].betno== "1"|| snapshot.data![index].betno== "3"||
                          //                         snapshot.data![index].betno==  "5"|| snapshot.data![index].betno==  "7"||
                          //                         snapshot.data![index].betno==  "9"|| snapshot.data![index].betno==  "12"||
                          //                         snapshot.data![index].betno==  "14"|| snapshot.data![index].betno==  "16"||
                          //                         snapshot.data![index].betno==  "18"|| snapshot.data![index].betno==  "19"||
                          //                         snapshot.data![index].betno==  "21"|| snapshot.data![index].betno==  "23"||
                          //                         snapshot.data![index].betno==  "25"|| snapshot.data![index].betno==  "27"||
                          //                         snapshot.data![index].betno==  "30"|| snapshot.data![index].betno==  "32"||
                          //                         snapshot.data![index].betno==  "34"|| snapshot.data![index].betno==  "36"?
                          //                     Colors.red:snapshot.data![index].betno==  "0"?Colors.green:Colors.yellow
                          //                 )),
                          //
                          //
                          //               ],
                          //             ),
                          //           );
                          //         },
                          //       ):Center(child:Text('jj'));
                          //     }
                          // ),
                        ),

                      ),

                      Container(
                        height: MediaQuery.of(context).size.height*0.30.h,
                        width: MediaQuery.of(context).size.width*0.10.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  AssetImage('assets/currentplay.png',),
                              fit: BoxFit.fill,
                            )
                        ),

                        child: Padding(
                          padding:  EdgeInsets.fromLTRB(5.w, 0.h, 5.w, 0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 5.h),
                                child: Center(
                                  child: Container(
                                    color: Colors.black,
                                    height: MediaQuery.of(context).size.height*0.170.h,
                                    child:    Stack(
                                      children: [
                                        // chakra==true?
                                        Positioned(
                                          top:-75.h,
                                          right: -85.w,
                                          child: Casino(
                                            result: win==null?'65':win.toString(),

                                            widthc:240.w,
                                            heightc: 240.w, pad: -20.h,
                                            time: time, gnno: '',

                                          ),
                                        )
                                            // :Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(right: 4.0.w,left: 2.w),
                                child: Row(
                                  children: [
                                    Text('Current Play : ',style: TextStyle(
                                        fontSize:MediaQuery.of(context).size.width*0.013.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900
                                    )),
                                    Spacer(),
                                    Text(dap.toString(),style: TextStyle(
                                        fontSize:MediaQuery.of(context).size.width*0.013.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.01.h,
                              ),
                              Padding(
                                padding:  EdgeInsets.only(right: 4.0.w,left: 2.w),
                                child: Row(
                                  children: [

                                    Text('You Won : ',style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width*0.013.sp,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900
                                    )),
                                    Spacer(),
                                    Text(won.toString(),style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width*0.013.sp,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.15.h,
                            width: MediaQuery.of(context).size.width*0.07.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:  AssetImage('assets/tray.png',),
                                  fit: BoxFit.fill,
                                )
                            ),


                          ),

                          InkWell(
                            onTap:(){

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>gamerule()));
                              Sound('audio/GameRule.mp3');
                            },
                            child: Container(
                              height: 20,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:  AssetImage('assets/btn_sort_1_.png',),
                                    fit: BoxFit.fill,
                                  )
                              ),
                              child:   Center(
                                child: Text('Game Rules',style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white
                                )),
                              ),


                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 2.w,),
                      Container(
                        height: MediaQuery.of(context).size.height*0.10.h,
                        width: MediaQuery.of(context).size.width*0.045.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  AssetImage('assets/winnertray.png',),
                              fit: BoxFit.fill,
                            )
                        ),
                        child:   Center(
                          child: Text(win=='38'?'':win.toString(),style: TextStyle(
                            fontSize: 30.0.sp,
                            color: win=="1"|| win=="3"||
                                win=="5"|| win=="7"||
                                win=="9"|| win=="12"||
                                win=="14"|| win=="16"||
                                win=="18"|| win=="19"||
                                win=="21"|| win=="23"||
                                win=="25"|| win=="27"||
                                win=="30"|| win=="32"||
                                win=="34"|| win=="36"?
                            Colors.red:win=="0"?Colors.green:Colors.yellow,
                            fontWeight: FontWeight.w900,
                          )),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  betconfirm() async{
    print('testttttt');
     // Sound('audio/Betting Playd Successfully.mp3');
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    print('raja');
    print(sno);
    print('raja deraj rohit padhar rahe h');
    final response = await http.get(
      Uri.parse(
          "https://realdeal.apponrent.com/betlock.php?gameid=1&userid=$userid&gamesno=$sno&gametype=1"),
    );
    final data = jsonDecode(response.body);
    print(data);
    print('raja deraj rohit padhar nahi pa rahe h');
    if (data['error'] == "200") {
     // Sound('audio/Betting Playd Successfully.mp3');
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    } else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      print("Bet not registerd");
    }

  }

  repeat() async{

    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.post(
      Uri.parse(
          "https://realdeal.apponrent.com/repeat.php?gameseno=$sno&userid=$userid&gametype=1&gameno=1"),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == "200") {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

    } else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // signup();
      print("Bet not registerd");
    }

  }

bool rep=false;

  clearbet() async{


    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.post(
      Uri.parse(
          "http://realdeal.wishufashion.com/clearbet.php?gameseno=$sno&userid=$userid&gametype=1&gameno=1"),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == "200") {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

    } else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // signup();
      print("Bet not registerd");
    }

  }


 Betdouble() async{

    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.post(
      Uri.parse(
          "https://realdeal.apponrent.com/double.php?userid=$userid&gametype=1&gameseno=$sno&gameno=1"),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == "200") {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

    } else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // signup();
      print("Bet not registerd");
    }

  }


  List<String> allrounf = [];

  yui() async{

    final response = await http.get(
      Uri.parse('https://realdeal.apponrent.com/last13.php?gameid=1'),
    );
    var jsond = json.decode(response.body);
    setState(() {
      allrounf.clear();

    });
    print('swami');
    print(jsond);
    for (var i = 0; i < 13; i++) {
      setState(() {
        allrounf.add(jsond[i]["betno"]);
      });

    }


    print('wwwwwwwwwwwwwwwwwwww');
    print(jsond);
    showcurrentbet();
    viewprofile();
    showlastresult();

  }

  winnersound(String win) {

    win=='0'?Sound('audio/0GreenWinner.mp3'):
    win=='1'?Sound('audio/1RedWinner.mp3'):
    win=='2'?Sound('audio/2BlackWinner.mp3'):
    win=='3'?Sound('audio/3RedWinner.mp3'):
    win=='4'?Sound('audio/4BlackWinner.mp3'):
    win=='5'?Sound('audio/5RedWinner.mp3'):
    win=='6'?Sound('audio/6BlackWinner.mp3'):
    win=='7'?Sound('audio/7RedWinner.mp3'):
    win=='8'?Sound('audio/8BlackWinner.mp3'):
    win=='9'?Sound('audio/9RedWinner.mp3'):
    win=='10'?Sound('audio/10BlackWinner.mp3'):
    win=='11'?Sound('audio/11BlackWinner.mp3'):
    win=='12'?Sound('audio/12BlackWinner.mp3'):
    win=='13'?Sound('audio/13BlackWinner.mp3'):
    win=='14'?Sound('audio/14RedWinner.mp3'):
    win=='15'?Sound('audio/15 Black Winner.mp3'):
    win=='16'?Sound('audio/16RedWinner.mp3'):
    win=='17'?Sound('audio/17 Black Winner.mp3'):
    win=='18'?Sound('audio/18RedWinner.mp3'):
    win=='19'?Sound('audio/19RedWinner.mp3'):
    win=='20'?Sound('audio/20 Black Winner.mp3'):
    win=='21'?Sound('audio/21RedWinner.mp3'):
    win=='22'?Sound('audio/22 Black Winner.mp3'):
    win=='23'?Sound('audio/23RedWinner.mp3'):
    win=='24'?Sound('audio/24 Black Winner.mp3'):
    win=='25'?Sound('audio/25RedWinner.mp3'):
    win=='26'?Sound('audio/26 Black Winner.mp3'):
    win=='27'?Sound('audio/27RedWinner.mp3'):
    win=='28'?Sound('audio/28 Black Winner.mp3'):
    win=='29'?Sound('audio/29 Black Winner.mp3'):
    win=='30'?Sound('audio/30 Red Winner.mp3'):
    win=='31'?Sound('audio/31 Black Winner.mp3'):
    win=='32'?Sound('audio/32 Red Winner.mp3'):
    win=='33'?Sound('audio/33BlackWinner.mp3'):
    win=='34'?Sound('audio/34redWinner.mp3'):
    win=='35'?Sound('audio/35BlackWinner.mp3'):
    Sound('audio/36RedWinner.mp3');
  }

  placechips() {
    Sound('audio/placeyourchips.mp3');
  }
}






class alldata {
  String? id;
  String? betno;




  alldata(
      this.id,
      this.betno,
      );

}
