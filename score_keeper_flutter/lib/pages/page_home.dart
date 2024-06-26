import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    final vertical_scroll_controller = ScrollController();
    final horizontal_scroll_controller = ScrollController();

    void ask_user_about_removal_of_round ()
    {
        AlertDialog alert_dialog = AlertDialog(
            title: const Text("Remove last round"),
            content: const Text("This will remove the most recent round from your game. Are you sure you want to proceed?"),
            actions: <Widget>[
                TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context, "Cancel"),
                ),
                TextButton(
                    child: const Text("OK"),
                    onPressed: () => Navigator.pop(context, "OK")
                )
            ]
        );

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => alert_dialog,
        ).then((value) 
        {
            if (value is String)
            {
                if (value == "OK")
                {
                    setState(() 
                    {
                        globals.app_scoresheet.RemoveLastRound();
                    });
                }
            }
        });        
    }

    void ask_user_about_clearing_all_rounds ()
    {
        AlertDialog alert_dialog = AlertDialog(
            title: const Text("Clear all rounds"),
            content: const Text("This will clear all rounds from your game. Are you sure you want to proceed?"),
            actions: <Widget>[
                TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context, "Cancel"),
                ),
                TextButton(
                    child: const Text("OK"),
                    onPressed: () => Navigator.pop(context, "OK")
                )
            ]
        );

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => alert_dialog,
        ).then((value) 
        {
            if (value is String)
            {
                if (value == "OK")
                {
                    setState(() 
                    {
                        globals.app_scoresheet.ClearRounds();
                    });
                }
            }
        });
    }

    void add_new_round ()
    {
        Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const Subpage_AddNewRound(title: "Add new round"))
        ).then((value) => 
        {
            setState(() { })
        });
    }

    List<DataColumn> build_data_table_columns (BuildContext context)
    {
        //Create an empty list of columns
        List<DataColumn> columns = <DataColumn>[];

        //Create a column for each round of the game
        if (globals.app_scoresheet.players.isNotEmpty)
        {
            //Create the name column
            DataColumn name_column = const DataColumn(label: Text("Name"));
            columns.add(name_column);

            if (globals.app_scoresheet.players[0].scores.isNotEmpty)
            {
                int num_rounds = globals.app_scoresheet.players[0].scores.length;
                for (int i = 0; i < num_rounds; i++)
                {
                    DataColumn current_round_column = DataColumn(
                        label: Text(i.toString())
                    );

                    columns.add(current_round_column);
                }

                //Create a "sum" column at the end
                DataColumn sum_column = const DataColumn(label: Text("Sum"));
                columns.add(sum_column);
            }
        }

        return columns;
    }

    List<DataRow> build_data_table_rows (BuildContext context)
    {
        //Create a list of rows that we will return to the caller
        List<DataRow> rows = <DataRow>[];

        //Iterate over each player
        for (int i = 0; i < globals.app_scoresheet.players.length; i++)
        {
            //Create a list of DataCell objects for the current player
            List<DataCell> row_cells = <DataCell>[];

            //Add the player's name as the first column of each row
            DataCell name_cell = DataCell(Text(globals.app_scoresheet.players[i].name));
            row_cells.add(name_cell);

            //Add each round for this player to the list of cells
            for (int j = 0; j < globals.app_scoresheet.players[i].scores.length; j++)
            {
                DataCell current_round_cell = DataCell(Text(globals.app_scoresheet.players[i].scores[j].round().toString()));
                row_cells.add(current_round_cell);
            }

            //If there is at least one round of scores, go ahead and tack on a "sum" column
            if (globals.app_scoresheet.players[i].scores.isNotEmpty)
            {
                DataCell sum_cell = DataCell(Text(globals.app_scoresheet.players[i].get_summed_scores().round().toString()));
                row_cells.add(sum_cell);
            }

            //Now create a DataRow object to hold all the DataCell objects
            DataRow current_row = DataRow(
                cells: row_cells
            );

            //Now add the current row to the list of all rows
            rows.add(current_row);
        }

        //Return the list of rows
        return rows;
    }

    Widget build_data_table (BuildContext context)
    {
        if (globals.app_scoresheet.players.isNotEmpty && globals.app_scoresheet.players[0].scores.isNotEmpty)
        {
            return DataTable(
                columns: build_data_table_columns(context),
                rows: build_data_table_rows(context)
            );
        }
        else
        {
            return const SizedBox(width: 1, height: 1);
        }
    }

    @override
    Widget build(BuildContext context) 
    {
        //Now create the main UI for the page
        return Scaffold(
            body: Scrollbar(
                controller: vertical_scroll_controller,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                    controller: vertical_scroll_controller,
                    scrollDirection: Axis.vertical,
                    child: Scrollbar(
                        controller: horizontal_scroll_controller,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: SingleChildScrollView(
                            controller: horizontal_scroll_controller,
                            scrollDirection: Axis.horizontal,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: build_data_table(context)
                                    )
                                ],
                            )
                        ),
                    )
                )
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
                    const SizedBox(width:20),
                    FloatingActionButton(
                        heroTag: "remove_round_button",
                        onPressed: ask_user_about_removal_of_round,
                        tooltip: 'Remove most recent round',
                        child: const Icon(Icons.remove)
                    ),
                    const SizedBox(width: 20),
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
