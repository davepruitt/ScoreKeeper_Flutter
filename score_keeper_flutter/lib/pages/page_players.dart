import 'package:flutter/material.dart';
import '../model/player.dart';
import '../model/globals.dart' as globals;

class Page_Players extends StatefulWidget 
{
    const Page_Players({Key? key, required this.title}) : super(key: key);

    final String title;

    @override
    State<Page_Players> createState() => Page_Players_State();
}

class Page_Players_State extends State<Page_Players> 
{
    void remove_player (Player p)
    {
        setState(() 
        {
            globals.app_scoresheet.players.remove(p);
        });
    }

    void clear_players ()
    {
        setState(() 
        {
            globals.app_scoresheet.players.clear();
        });
    }

    void add_player () 
    {
        setState(() 
        {
            //Create a new Player object
            Player new_player = Player();

            //Make sure the new player has the same number of rounds/scores as all other players
            if (globals.app_scoresheet.players.isNotEmpty && globals.app_scoresheet.players[0].scores.isNotEmpty)
            {
                for(int i = 0; i < globals.app_scoresheet.players[0].scores.length; i++)
                {
                    new_player.scores.add(0);
                }
            }

            //Add the new player to the list of players
            globals.app_scoresheet.players.add(new_player);
        });
    }

    Widget build_single_player (Player player, int player_number)
    {
        //Create a text editing controller for this player
        TextEditingController c = TextEditingController(text: player.name);

        //Create a listener for this controller that will update
        //the player name whenever the text is changed
        c.addListener(() 
        {
            player.name = c.text;
        });

        //Now build the UI for this player
        Row result = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                const SizedBox(width: 20),
                Text(
                    player_number.toString() + ".",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Player name"
                        ),
                        controller: c,
                    )
                ),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () 
                    { 
                        remove_player(player);
                    },
                    icon: const Icon(Icons.clear),
                ),
                const SizedBox(width: 20),
            ]
        );

        //Return the result to the caller
        return result;
    }

    @override
    Widget build(BuildContext context) 
    {
        //Create a widget for each existing player
        List<Player> all_players = globals.app_scoresheet.players;
        List<Widget> player_widgets = <Widget>[];
        player_widgets.add(const SizedBox(height: 30));
        for (int i = 0; i < all_players.length; i++)
        {
            Widget player_widget = build_single_player(all_players[i], i+1);
            player_widgets.add(player_widget);
            if (i < (all_players.length - 1))
            {
                player_widgets.add(const SizedBox(height: 20));
            }
        }

        //Now create the main UI for the page
        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: player_widgets,
                ),
            ),
            floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    FloatingActionButton(
                        heroTag: "clear_all_players",
                        onPressed: clear_players,
                        tooltip: 'Clear all players',
                        child: const Icon(Icons.delete),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                        heroTag: "add_a_player",
                        onPressed: add_player,
                        tooltip: 'Add a player',
                        child: const Icon(Icons.add),
                    )
                ]
            ),
        );
    }
}
