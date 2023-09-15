import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';

class TrackBookingParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  TrackBookingParser(
      {required this.sharedPreferencesManager, required this.apiService});
}
