import 'package:collection/collection.dart';
import 'dart:convert';

class Player
{
    //Properties
    String name = "";
    List<double> scores = <double>[];

    //Constructor
    Player()
    {
        //empty
    }

    //Methods
    double get_summed_scores ()
    {
        return scores.sum;
    }

    double get_average_score ()
    {
        return scores.average;
    }

    //JSON conversion methods
    Map<String, dynamic> toJson() => 
    {
        'name' : name,
        'scores' : json.encode(scores)
    };

    Player.fromJson(Map<String, dynamic> json_input)
        : name = json_input["name"],
        scores = json.decode(json_input["scores"])
}
