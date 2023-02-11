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
    void clear_players ()
    {
        setState(() 
        {

        });
    }

    void add_player () 
    {
        setState(() 
        {
            //empty
        });
    }

    Widget build_single_player (String player_name)
    {
        Row result = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Player name"
                    ),
                    controller: TextEditingController(text: player_name),
                ),
                ElevatedButton(
                    onPressed: () { },
                    child: Icon(Icons.clear),
                ),
            ]
        );

        return result;
    }

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                            build_single_player("Hello, World!"),
                        ],
                ),
            ),
            floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    FloatingActionButton(
                        onPressed: clear_players,
                        tooltip: 'Clear al players',
                        child: const Icon(Icons.delete),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                        onPressed: add_player,
                        tooltip: 'Add a player',
                        child: const Icon(Icons.add),
                    )
                ]
            ),
        );
    }

}
