import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/util/constant.dart';

class ChatParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ChatParser(
      {required this.sharedPreferencesManager, required this.apiService});

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getChatRooms(var uid, var participants) async {
    return await apiService.postPrivate(
        AppConstants.getChatRooms,
        {'sender_id': uid, 'receiver_id': participants},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> createChatRooms(var uid, var participants) async {
    return await apiService.postPrivate(
        AppConstants.createChatRooms,
        {'sender_id': uid, 'receiver_id': participants, 'status': 1},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getChatList(var roomId) async {
    return await apiService.postPrivate(AppConstants.getChatList,
        {'room_id': roomId}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> sendMessage(var param) async {
    return await apiService.postPrivate(AppConstants.sendMessage, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> sendNotification(var body) async {
    var response = await apiService.postPrivate(AppConstants.sendNotification,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
