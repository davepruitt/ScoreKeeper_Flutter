import 'package:shared_preferences/shared_preferences.dart';
import 'player.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ScoreSheet
{
    //Variables
    List<Player> players = <Player>[];

    //Constructor
    ScoreSheet()
    {
        //empty
    }

    void ClearRounds ()
    {
        for (int i = 0; i < players.length; i++)
        {
            players[i].scores.clear();
        }
    }

    void RemoveLastRound ()
    {
        for (int i = 0; i < players.length; i++)
        {
            players[i].scores.removeLast();
        }        
    }

    //JSON conversion methods
    Map<String, dynamic> toJson() => 
    {
        'players' : json.encode(players)
    };

    ScoreSheet.fromJson(Map<String, dynamic> json_input)
        : players = json.decode(json_input["players"])

    Future<void> LoadScoresheet () async
    {
        final directory = await getApplicationDocumentsDirectory();
        File file = File("$directory/scoresheet.json");
        final contents = await file.readAsString();

        //TO DO: finish this function
        //Also: write the save function
    }
}
