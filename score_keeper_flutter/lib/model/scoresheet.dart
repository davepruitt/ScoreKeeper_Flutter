import 'player.dart';

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
}
