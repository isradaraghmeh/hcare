import 'package:flutter/material.dart';
import '../Screens/UserScreens/MainUserScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<AnimatedTextExample> _examples;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _examples = animatedTextExamples(onTap: () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final animatedTextExample = _examples[_index];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          animatedTextExample.label,
          style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              fontFamily: ' Horizon'),
        ),
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width * 1.15,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/student.png'),
                      fit: BoxFit.fill)),
              child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(left: 160, top: 50),
                height: 300.0,
                width: 400.0,
                child: Center(
                  child: animatedTextExample.child,
                ),
              ),
            ),
          ),
          Container(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>MainUserScreen(),),);
          //setState(() {});
        },
        child: const Icon(
          Icons.done_all_rounded,
          size: 44.0,
        ),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}

class AnimatedTextExample {
  final String label;
  final Color color;
  final Widget child;

  const AnimatedTextExample({
    this.label,
    this.color,
    this.child,
  });
}

// Colorize Text Style
const _colorizeTextStyle = TextStyle(
  fontSize: 40.0,
  fontFamily: 'Horizon',
);

// Colorize Colors
const _colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

List<AnimatedTextExample> animatedTextExamples({VoidCallback onTap}) =>
    <AnimatedTextExample>[
      AnimatedTextExample(
        label: 'Learning city',
        color: Colors.white,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Bobbers',
            color: Colors.white,
          ),
          child: SizedBox(
            width: 250,
            child: AnimatedTextKit(
              totalRepeatCount: 100,
              pause: const Duration(milliseconds: 3000),
              animatedTexts: [
                TypewriterAnimatedText(
                  'Choose your lesson and your favorite teacher at your right time ',
                ),
                TypewriterAnimatedText(
                    'With the selection of the best teachers',
                    cursor: '|'),
                TypewriterAnimatedText('And with your all trust in us,',
                    cursor: '<|>'),
                TypewriterAnimatedText('Getting the full mark is easy!',
                    cursor: '💡'),
              ],
              onTap: onTap,
            ),
          ),
        ),
      ),
    ];


/*import 'package:flutter/material.dart';

import '../Screens/UserScreens/MainUserScreen.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 30,),
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width*1.15,
              height: MediaQuery.of(context).size.height*0.5,
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: AssetImage('assets/onboarding.png'),
                  fit: BoxFit.fill
                )
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("WHERE DOCTORS LIKE THIER WORK",style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'circe'
                  ),),
                  Text("The Development Of Medical Technology And Its Presence In Every Home \n Treatment Made Easy",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'circe'
                  ),textAlign: TextAlign.center,),
                  Text("Filtered Top Rated Doctors \n Doctors Full of Experience \n In Your Home In Just a Few Clicks ",style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'circe'
                  ),textAlign: TextAlign.center,),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 15,
                          color: Colors.blue.withOpacity(0.1),
                        )
                      ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).accentColor,
                        ),
                        child: IconButton(
                          onPressed: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>MainUserScreen(),),);

                          },
                          icon: Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}*/