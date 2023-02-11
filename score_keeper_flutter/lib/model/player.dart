import 'package:collection/collection.dart';

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
}
