import 'dart:io';

import 'package:badges/badges.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:readmore/readmore.dart';
import 'package:testing_one/image_pick_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: TextButton(
                  child: Text('Flash Bar',
                      style: TextStyle(color: Colors.deepPurpleAccent)),
                  onPressed: () {
                    Flushbar(
                      title: "Hey Ninja",
                      message:
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                      duration: Duration(seconds: 3),
                    )..show(context);
                  },
                ),
              ),
            ),
            TextField(inputFormatters: [maskFormatter]),
            CountryListPick(
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  title: Text('Choisir un pays'),
                ),
                theme: CountryTheme(
                  isShowFlag: false,
                  isShowTitle: false,
                  isShowCode: true,
                  isDownIcon: false,
                  showEnglishName: true,
                ),
                initialSelection: '+234',
                useUiOverlay: true,
                useSafeArea: false),
            Text(continueMessage(),
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 150,
              child: new FlareActor("assets/flare/success_anim.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "start"),
            ),
            ReadMoreText(
              'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
              trimLines: 2,
              colorClickableText: Colors.pink,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImagePickerPage()),
                  );
                },
                child: Text('ImagePick Page')),
            FlutterBadge(
              textStyle: TextStyle(fontSize: 20),
              icon: Icon(Icons.message),
              borderRadius: 20.0,
              itemCount: 3,
            ),
            CountryCodePicker(
              onChanged: print,
              initialSelection: 'IT',
              favorite: ['+39', 'FR'],
              countryFilter: ['IT', 'FR'],
              showFlagDialog: false,
            ),
            Badge(
              badgeContent: Text('10'),
              child: Icon(Icons.person, size: 30),
            ),
            SvgPicture.network(
              'http://upload.wikimedia.org/wikipedia/commons/0/02/SVG_logo.svg',
              placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator(strokeWidth: 1)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Intl trial
  String continueMessage() => Intl.message('Intl hit any key to continue',
      name: 'continueMessage',
      args: [],
      desc: 'Explains that we will not proceed further until '
          'the user presses a key');
}
