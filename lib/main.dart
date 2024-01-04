import 'package:expense_tracker/utils/routes.dart';
import 'package:expense_tracker/utils/routes_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  String initialRoute = await findIntialRoute();
  runApp(MyApp(initialRoute));
}
Future<String> findIntialRoute() async {
  String initialRoute = Routes.home;
  return initialRoute;
}
Object? args;

class MyApp extends StatelessWidget {
  late String initialRoute;
    MyApp(this.initialRoute,{super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     initialRoute: Routes.home,
      onGenerateRoute: RoutesGenerator.generateRoute,
      onGenerateInitialRoutes: (String initialRouteName) {
        return [
          RoutesGenerator.generateRoute(RouteSettings(name: initialRoute,arguments: args)),
        ];
      },
      //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
