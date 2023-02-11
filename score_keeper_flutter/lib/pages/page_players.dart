import 'package:flutter/material.dart';

class Page_Players extends StatefulWidget 
{
    const Page_Players({Key? key, required this.title}) : super(key: key);
    final String title;

    @override
    State<Page_Players> createState() => Page_Players_State();
}

class Page_Players_State extends State<Page_Players> 
{
    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        const Text('This is the players page'),
                        ],
                ),
            )
        );
    }
}
