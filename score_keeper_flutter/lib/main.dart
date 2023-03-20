import 'package:flutter/material.dart';
import 'pages/page_home.dart';
import 'pages/page_players.dart';
import 'pages/page_rankings.dart';
import '../model/globals.dart' as globals;

Future<void> main() async
{
    await globals.app_settings.Initialize();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
    const MyApp({Key? key}) : super(key: key);

    final String score_keeper_title = "ScoreKeeper";

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) 
    {
        return MaterialApp(
            title: score_keeper_title,
            theme: ThemeData(primarySwatch: Colors.blue),
            home: DefaultTabController(
                length: 5,
                child: Scaffold(
                    appBar: AppBar(
                        backgroundColor: const Color(0xFF3F5AA6),
                        title: Text(score_keeper_title)
                    ),
                    bottomNavigationBar: tab_menu(),
                    body: const TabBarView(
                        children: [
                            Page_Home(title: "Main Page"),
                            Page_Players(title: "Players Page"),
                            Page_Rankings(title: "Rankings Page"),
                            Icon(Icons.bar_chart_rounded),
                            Icon(Icons.settings),
                        ]
                    )
                )
            )
        );
    }

    Widget tab_menu ()
    {
        return Container(
            color: const Color(0xFF3F5AA6),
            child: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.blue,
                tabs: [
                    Tab(text: "Home", icon: Icon(Icons.home)),
                    Tab(text: "Players", icon: Icon(Icons.person_rounded)),
                    Tab(text: "Rankings", icon: Icon(Icons.format_list_numbered)),
                    Tab(text: "Stats", icon: Icon(Icons.bar_chart_rounded)),
                    Tab(text: "Settings", icon: Icon(Icons.settings))
                ]
            ),
        );
    }
}

