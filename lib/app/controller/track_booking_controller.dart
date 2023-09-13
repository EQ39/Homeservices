import 'package:get/get.dart';
import 'package:homeservice/app/backend/parse/track_booking_parse.dart';

class TrackBookingController extends GetxController implements GetxService {
  final TrackBookingParser parser;

  TrackBookingController({required this.parser});
}
