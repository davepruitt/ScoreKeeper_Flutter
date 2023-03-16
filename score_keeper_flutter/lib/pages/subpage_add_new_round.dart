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
    int current_score = 0;
    bool should_add_value_to_existing_score = false;
    List<double> scores_to_add = <double>[];

    void switch_sign_on_current_score ()
    {
        setState(() {
            current_score = -current_score;
        });
    }

    void clear_current_score ()
    {
        setState(() {
            current_score = 0;
        });
    }

    void add_value_to_existing_score_switch_toggled (bool value)
    {
        setState(() {
            should_add_value_to_existing_score = value;
        });
    }

    void assign_current_score_to_player (int player_idx)
    {
        setState(() {
            if (should_add_value_to_existing_score)
            {
                scores_to_add[player_idx] += current_score;
            }
            else
            {
                scores_to_add[player_idx] = current_score.toDouble();
            }
        });
    }

    void handle_cancel_button_press ()
    {
        //In the event the user cancels, we simply pop this page and do nothing else
        Navigator.pop(context);
    }

    void handle_ok_button_press ()
    {
        //In the event the user presses "OK", we need to save the scores that
        //the user entered to each player's model object
        if (scores_to_add.length == globals.app_scoresheet.players.length)
        {
            for (int i = 0; i < globals.app_scoresheet.players.length; i++)
            {
                globals.app_scoresheet.players[i].scores.add(scores_to_add[i]);
            }
        }

        //Now we can pop the page
        Navigator.pop(context);
    }

    Widget build_score_entry_section_of_page(BuildContext context)
    {
        //Create a controller for monitoring the current score entered
        //by the user
        TextEditingController current_score_controller = TextEditingController(
            text: current_score.toString()
        );

        current_score_controller.addListener(() {
            current_score = int.tryParse(current_score_controller.text) ?? 0;
        });

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
                        Expanded(
                            child: TextField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()
                                ),
                                controller: current_score_controller,
                            )
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: switch_sign_on_current_score,
                                child: Container(
                                    margin: const EdgeInsets.all(15),
                                    child: const Text("+ / -", style: TextStyle(fontSize: 18))
                                )
                            ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: clear_current_score,
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
        //Initialize the "scores_to_add" list, so that each initial score is 0
        if (scores_to_add.isEmpty)
        {
            for (int i = 0; i < globals.app_scoresheet.players.length; i++)
            {
                scores_to_add.add(0);
            }
        }

        //Create a row for each player
        List<Widget> player_rows = <Widget>[];
        player_rows.add(const Align(
            alignment: Alignment.centerLeft,
            child: Text("Assign score to a player:")
        ));
        player_rows.add(const SizedBox(height: 10));
        for (int i = 0; i < globals.app_scoresheet.players.length; i++)
        {
            player_rows.add(const SizedBox(height: 10));
            player_rows.add(build_individual_player_score_section(context, i));
            player_rows.add(const SizedBox(height: 10));
        }

        //Now create the full UI piece and return it to the caller
        return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: player_rows
            )
        );
    }

    Widget build_individual_player_score_section(BuildContext context, int player_idx)
    {
        return Row(
            children: [
                Expanded(
                    child: Text(scores_to_add[player_idx].round().toString(),
                        style: const TextStyle(fontSize: 24)),
                    flex: 1
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                            assign_current_score_to_player(player_idx);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(15),
                            child: Text(globals.app_scoresheet.players[player_idx].name, style: const TextStyle(fontSize: 18))
                        )
                    ),
                    flex: 2
                )
            ]
        );
    }

    Widget build_main_content (BuildContext context)
    {
        Widget score_entry_widget = build_score_entry_section_of_page(context);
        Widget player_score_widget = build_player_score_section_of_page(context);

        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                score_entry_widget,
                Expanded(
                    child: player_score_widget
                ),
                Row(
                    children: <Widget>[
                        Expanded(
                            child: ElevatedButton(
                                onPressed: handle_cancel_button_press,
                                child: Container(
                                    margin: const EdgeInsets.all(50),
                                    child: const Text("Cancel", style: TextStyle(fontSize: 18))
                                )
                            )
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: handle_ok_button_press,
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
        return Scaffold(
            body: Container(
                margin: const EdgeInsets.all(20),
                child: build_main_content(context),
            )
        );
    }
}
