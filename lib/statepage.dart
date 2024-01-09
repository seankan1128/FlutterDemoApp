import 'package:flutter/material.dart';

class StatePage extends StatefulWidget {
  const StatePage({super.key});

  @override
  State<StatePage> createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  var myController = TextEditingController();
  final String title = "First Page";
  String _text1 = "First Page text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_text1),
              TextField(
                controller: myController,
                decoration: const InputDecoration(
                  labelText: "Change Text in page 2",
                ),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            SecondPage secondPage = SecondPage(callback: (val) => setState(() => _text1 = val));
            secondPage.text2 = myController.text;
            return secondPage;
          }));
        },
        tooltip: 'Next Page',
        child: const Text('Next'),
      ),
    );
  }
}

typedef TextCallback = void Function(String val);

class SecondPage extends StatelessWidget {

  final TextCallback callback;

  SecondPage({super.key, required this.callback});
  var myController2 = TextEditingController();
  late String text2;
  // final VoidCallback trial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Second Page"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(text2),
              TextField(
                controller: myController2,
                decoration: const InputDecoration(
                  labelText: "Change Text in first page",
                ),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _MyHomePageState.ChangeText(myController2.text);
          callback(myController2.text);
          Navigator.pop(context);
        },
        tooltip: 'Back to first page',
        child: const Text('Back'),
      ),

    );
  }
}
