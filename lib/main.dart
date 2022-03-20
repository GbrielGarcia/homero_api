import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exampleevent/src/models/the_simpsons_model.dart';
import 'package:exampleevent/src/providers/the_simpsons_provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TheSimpsonsProvider(), lazy: false),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final simpsonProvider = Provider.of<TheSimpsonsProvider>(context);

    int repets = 25;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: FutureBuilder(
            future: simpsonProvider.fetchTheSimpsons(repets),
            builder: (_, AsyncSnapshot<List<TheSimpsonsModels>> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  constraints: const BoxConstraints(maxWidth: 150),
                  height: 180,
                  child: const CupertinoActivityIndicator(),
                );
              }
              final List<TheSimpsonsModels> simp = snapshot.data!;
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 250,
                    ),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: simp.length,
                    itemBuilder: (_, int index) => _CastCard(simp[index])),
              );
            },
          ),
        ));
  }
}

class _CastCard extends StatelessWidget {
  final TheSimpsonsModels simpsons;

  const _CastCard(
    this.simpsons,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: 110,
      height: 180,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(simpsons.character),
            Image.network(simpsons.image),
          ],
        ),
      ),
    );
  }
}
