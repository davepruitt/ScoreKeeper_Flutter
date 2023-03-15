import 'package:flutter/material.dart';
import 'package:score_keeper_flutter/pages/subpage_add_new_round.dart';
import '../model/player.dart';
import '../model/globals.dart' as globals;

class Page_Home extends StatefulWidget 
{
    const Page_Home({Key? key, required this.title}) : super(key: key);

    final String title;

    @override
    State<Page_Home> createState() => Page_Home_State();
}

class Page_Home_State extends State<Page_Home> 
{
    void ask_user_about_removal_of_round ()
    {
        //empty
    }

    void ask_user_about_clearing_all_rounds ()
    {
        //empty
    }

    void remove_last_round ()
    {
        //empty
    }

    void clear_all_rounds ()
    {
        //empty
    }

    void add_new_round ()
    {
        Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const Subpage_AddNewRound(title: "Add new round"))
        );
    }

    @override
    Widget build(BuildContext context) 
    {
        //Now create the main UI for the page
        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
                ),
            ),
            floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    FloatingActionButton(
                        heroTag: "clear_rounds_button",
                        onPressed: ask_user_about_clearing_all_rounds,
                        tooltip: 'Clear all rounds',
                        child: const Icon(Icons.delete),
                    ),
                    SizedBox(width:20),
                    FloatingActionButton(
                        heroTag: "remove_round_button",
                        onPressed: ask_user_about_removal_of_round,
                        tooltip: 'Remove most recent round',
                        child: const Icon(Icons.remove)
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                        heroTag: "add_round_button",
                        onPressed: add_new_round,
                        tooltip: 'Add a new round',
                        child: const Icon(Icons.add),
                    )
                ]
            ),
        );
    }
}
