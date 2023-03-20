import 'package:shared_preferences/shared_preferences.dart';

enum RankingType { HighestToLowest, LowestToHighest, ClosestToZero, ChiasmaticPairing }

class RankingTypeConverter
{
    static List<String> GetListOfHumanReadableStrings ()
    {
        List<String> result = <String>[];
        result.add("Highest to Lowest");
        result.add("Lowest to Highest");
        result.add("Closest to Zero");
        result.add("Chiasmatic Pairing");
        return result;
    }

    static String ConvertToHumanReadableString (RankingType r)
    {
        switch (r)
        {
            case RankingType.HighestToLowest:
                return "Highest to Lowest";
            case RankingType.LowestToHighest:
                return "Lowest to Highest";
            case RankingType.ClosestToZero:
                return "Closest to Zero";
            case RankingType.ChiasmaticPairing:
                return "Chiasmatic Pairing";
            default:
                return "Highest to Lowest";
        }
    }

    static RankingType ConvertFromHumanReadableString (String s)
    {
        if (s == "Highest to Lowest")
        {
            return RankingType.HighestToLowest;
        }
        else if (s == "Lowest to Highest")
        {
            return RankingType.LowestToHighest;
        }
        else if (s == "Closest to Zero")
        {
            return RankingType.ClosestToZero;
        }
        else if (s == "Chiasmatic Pairing")
        {
            return RankingType.ChiasmaticPairing;
        }
        else
        {
            return RankingType.HighestToLowest;
        }
    }
}

class Settings
{
    //Private data members
    bool _are_advertisements_enabled = false;
    bool _players_are_rows = true;
    
    //Public data members
    RankingType ranking_type = RankingType.HighestToLowest;

    //Constructor
    Settings()
    {
        //empty
    }

    //Properties
    bool get are_advertisements_enabled
    {
        return _are_advertisements_enabled;
    }

    set are_advertisements_enabled (bool value)
    {
        _are_advertisements_enabled = value;
        _save_properties_to_shared_preferences();
    }

    bool get players_are_rows
    {
        return _players_are_rows;
    }

    set players_are_rows (bool value)
    {
        _players_are_rows = value;
        _save_properties_to_shared_preferences();
    }

    //Private methods
    Future<void> _save_properties_to_shared_preferences () async
    {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("are_advertisements_enabled", _are_advertisements_enabled);
        prefs.setBool("players_are_rows", _players_are_rows);        
    }

    Future<void> _get_properties_from_shared_preferences () async
    {
        final prefs = await SharedPreferences.getInstance();
        _are_advertisements_enabled = prefs.getBool("are_advertisements_enabled") ?? false;
        _players_are_rows = prefs.getBool("players_are_rows") ?? true;
    }

    //Public methods
    Future<void> Initialize () async
    {
        await _get_properties_from_shared_preferences();
    }
}