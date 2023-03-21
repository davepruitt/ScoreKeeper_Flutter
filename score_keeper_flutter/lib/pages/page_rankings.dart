import 'package:flutter/material.dart';
import 'package:score_keeper_flutter/pages/subpage_add_new_round.dart';
import '../model/player.dart';
import '../model/settings.dart';
import '../model/globals.dart' as globals;
import 'package:tuple/tuple.dart';

class Page_Rankings extends StatefulWidget 
{
    const Page_Rankings({Key? key, required this.title}) : super(key: key);

    final String title;

    @override
    State<Page_Rankings> createState() => Page_Rankings_State();
}

class Page_Rankings_State extends State<Page_Rankings> 
{
    void handle_dropdown_menu_selection_changed (Object? selected_value)
    {
        if (selected_value is String)
        {
            setState(() 
            {
                globals.app_settings.ranking_type = RankingTypeConverter.ConvertFromHumanReadableString(selected_value);
            });
        }
    }

    Widget build_ranking_selector (BuildContext context)
    {
        List<String> menu_strings = RankingTypeConverter.GetListOfHumanReadableStrings();
        List<DropdownMenuItem<String>> menu_items = <DropdownMenuItem<String>>[];
        for (int i = 0; i < menu_strings.length; i++)
        {
            DropdownMenuItem<String> k = DropdownMenuItem<String>(child: Text(menu_strings[i]), value: menu_strings[i]);
            menu_items.add(k);
        }
        
        return DropdownButton(
            items: menu_items,
            value: RankingTypeConverter.ConvertToHumanReadableString(globals.app_settings.ranking_type),
            onChanged: handle_dropdown_menu_selection_changed
        );
    }

    List<DataColumn> build_data_table_columns (BuildContext context)
    {
        //Create an empty list of columns
        List<DataColumn> columns = <DataColumn>[];

        DataColumn rank_column = const DataColumn(label: Text("Rank"));
        DataColumn pair_column = const DataColumn(label: Text("Pair"));
        DataColumn name_column = const DataColumn(label: Text("Name"));
        DataColumn score_column = const DataColumn(label: Text("Score"));
        
        if (globals.app_settings.ranking_type == RankingType.ChiasmaticPairing)
        {
            columns.add(pair_column);
        }
        else
        {
            columns.add(rank_column);
        }
        
        columns.add(name_column);
        columns.add(score_column);

        return columns;
    }

    List<DataRow> build_data_table_rows (BuildContext context)
    {
        //Create a list of rows that we will return to the caller
        List<DataRow> rows = <DataRow>[];

        //Get a list of each player and their current score
        List< Tuple2<String, double> > player_scores = globals.app_scoresheet.players.map((e) => Tuple2<String, double>(e.name, e.get_summed_scores())).toList();
        
        if (globals.app_settings.ranking_type == RankingType.ChiasmaticPairing)
        {
            int num_players = player_scores.length;
            int num_pairs = (num_players / 2).floor();
            
            //Sort the list of players from lowest to highest
            player_scores.sort((a, b) => a.item2.compareTo(b.item2));

            int current_pair = 1;
            int lowest_index = 0;
            int highest_index = num_players - 1;

            for (int i = 0; i < num_pairs; i++)
            {
                List<DataCell> highest_player_cells = <DataCell>[];
                DataCell rank_cell = DataCell(Text(current_pair.toString()));
                DataCell name_cell = DataCell(Text(player_scores[highest_index].item1));
                DataCell score_cell = DataCell(Text(player_scores[highest_index].item2.toString()));
                highest_player_cells.add(rank_cell);
                highest_player_cells.add(name_cell);
                highest_player_cells.add(score_cell);
                DataRow highest_player_row = DataRow(cells: highest_player_cells);
                rows.add(highest_player_row);

                List<DataCell> lowest_player_cells = <DataCell>[];
                DataCell rank_cell_2 = DataCell(Text(current_pair.toString()));
                DataCell name_cell_2 = DataCell(Text(player_scores[lowest_index].item1));
                DataCell score_cell_2 = DataCell(Text(player_scores[lowest_index].item2.toString()));
                lowest_player_cells.add(rank_cell_2);
                lowest_player_cells.add(name_cell_2);
                lowest_player_cells.add(score_cell_2);

                DataRow lowest_player_row = DataRow(cells: lowest_player_cells);
                rows.add(lowest_player_row);         

                lowest_index++;
                highest_index--;
                current_pair++;       
            }

            //If there is an odd number of players, grab the last player
            if (num_players % 2 == 1)
            {
                List<DataCell> lowest_player_cells = <DataCell>[];
                DataCell rank_cell_2 = DataCell(Text(current_pair.toString()));
                DataCell name_cell_2 = DataCell(Text(player_scores[lowest_index].item1));
                DataCell score_cell_2 = DataCell(Text(player_scores[lowest_index].item2.toString()));
                lowest_player_cells.add(rank_cell_2);
                lowest_player_cells.add(name_cell_2);
                lowest_player_cells.add(score_cell_2);

                DataRow lowest_player_row = DataRow(cells: lowest_player_cells);
                rows.add(lowest_player_row);                 
            }
        }
        else
        {
            if (globals.app_settings.ranking_type == RankingType.HighestToLowest)
            {
                player_scores.sort((b, a) => a.item2.compareTo(b.item2));
            }
            else if (globals.app_settings.ranking_type == RankingType.LowestToHighest)
            {
                player_scores.sort((a, b) => a.item2.compareTo(b.item2));
            }
            else if (globals.app_settings.ranking_type == RankingType.ClosestToZero)
            {
                player_scores.sort((a, b) => a.item2.abs().compareTo(b.item2.abs()));
            }

            for (int i = 0; i < player_scores.length; i++)
            {
                List<DataCell> current_player_cells = <DataCell>[];
                DataCell rank_cell = DataCell(Text((i + 1).toString()));
                DataCell name_cell = DataCell(Text(player_scores[i].item1));
                DataCell score_cell = DataCell(Text(player_scores[i].item2.toString()));
                current_player_cells.add(rank_cell);
                current_player_cells.add(name_cell);
                current_player_cells.add(score_cell);

                DataRow current_player_row = DataRow(cells: current_player_cells);
                rows.add(current_player_row);
            }
        }

        //Return the list of rows
        return rows;
    }

    Widget build_data_table (BuildContext context)
    {
        return DataTable(
            columns: build_data_table_columns(context),
            rows: build_data_table_rows(context)
        );
    }

    @override
    Widget build(BuildContext context) 
    {
        //Now create the main UI for the page
        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Text("Choose how to order the players:"),
                        const SizedBox(height: 5),
                        build_ranking_selector(context),
                        const SizedBox(height: 20),
                        build_data_table(context)
                    ],
                ),
            )
        );
    }
}
