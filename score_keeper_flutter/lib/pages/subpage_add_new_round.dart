import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/player.dart';
import '../model/globals.dart' as globals;

class Subpage_AddNewRound extends StatefulWidget 
{
    const Subpage_AddNewRound({Key? key, required this.title}) : super(key: key);

    final String title;

    @override
    State<Subpage_AddNewRound> createState() => Subpage_AddNewRound_State();
}

class Subpage_AddNewRound_State extends State<Subpage_AddNewRound> 
{
    bool should_add_value_to_existing_score = false;

    

    void add_value_to_existing_score_switch_toggled (bool value)
    {
        setState(() {
            should_add_value_to_existing_score = value;
        });
    }

    Widget build_score_entry_section_of_page(BuildContext context)
    {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Enter a score here:", textAlign: TextAlign.left)
                ),
                const SizedBox(height: 10),
                Row(
                    children: [
                        const Expanded(
                            child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()
                                ),
                            )
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                    margin: const EdgeInsets.all(15),
                                    child: const Text("+ / -", style: TextStyle(fontSize: 18))
                                )
                            ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                    margin: const EdgeInsets.all(15),
                                    child: const Text("C", style: TextStyle(fontSize: 18))
                                )
                            )                                                
                        )
                    ]
                ),
                const SizedBox(height: 10),
                Row(
                    children: [
                        const Text("Add value to existing score?"),
                        const SizedBox(width: 20),
                        CupertinoSwitch(
                            value: should_add_value_to_existing_score,
                            onChanged: add_value_to_existing_score_switch_toggled
                        )
                    ]
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black)                
            ]
        );
    }

    Widget build_player_score_section_of_page(BuildContext context)
    {
        return Placeholder();
    }

    Widget build_main_content (BuildContext context)
    {
        Widget score_entry_widget = build_score_entry_section_of_page(context);

        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                score_entry_widget,
                Expanded(
                    child: Row(

                    )
                ),
                Row(
                    children: <Widget>[
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                    margin: const EdgeInsets.all(50),
                                    child: const Text("Cancel", style: TextStyle(fontSize: 18))
                                )
                            )
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                    margin: const EdgeInsets.all(50),
                                    child: const Text("OK", style: TextStyle(fontSize: 18))
                                )
                            )
                        )
                    ],
                )
            ],
        );
    }

    @override
    Widget build(BuildContext context) 
    {
        

        //Now create the main UI for the page
        return Scaffold(
            body: Container(
                margin: EdgeInsets.all(20),
                child: build_main_content(context),
            )
        );
    }
}
