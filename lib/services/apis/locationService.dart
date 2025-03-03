import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/location/postCodeDetail.dart';
import 'package:vegan_liverpool/services/apis/places.dart';
import 'package:vegan_liverpool/utils/constants.dart';

void ToNull() {}

@lazySingleton
class LocationService {
  LocationService(this.dio) {
    dio.options.baseUrl = postcodeIoBaseUrl;
    dio.options.headers = Map.from({'Content-Type': 'application/json'});
  }

  final Dio dio;

  // created method for getting user current location
  Future<Position> getUserCurrentLocation({
    void Function() callbackIfDenied = ToNull,
  }) async {
    await Geolocator.requestPermission().then((value) {
      if (value == LocationPermission.denied ||
          value == LocationPermission.deniedForever) {
        callbackIfDenied();
      }
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print('ERROR$error');
    });
    final currentPosition = await Geolocator.getCurrentPosition();
    return currentPosition;
    // return Coordinates(currentPosition.latitude, currentPosition.longitude);
  }

  Future<List<PostCodeDetail>> getPostalCodeDetailFromLocation({
    required Coordinates location,
  }) async {
    final qryParams = 'lon=${location.lng}&lat=${location.lat}';
    final Response<dynamic> response = await dio
        .get<dynamic>(
      '$postcodeIoGetPostcodeDetailRelUrl?$qryParams',
    )
        .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return Response(
          data: {'result': List<PostCodeDetail>.empty()},
          requestOptions: RequestOptions(),
        );
      },
    ).onError(
      (error, stackTrace) => Response(
        data: {'result': List<PostCodeDetail>.empty()},
        requestOptions: RequestOptions(),
      ),
    );

    if (response.data['status'] != 200) {
      return List<PostCodeDetail>.empty();
    }

    final results = List.from(response.data['result'] as Iterable<dynamic>)
        .map((e) => PostCodeDetail.fromJson(e as Map<String, dynamic>))
        .toList();

    return results;
  }

  Future<bool> locationEnabled({required Store<AppState> store}) {
    if (!store.state.userState.useLiveLocation) {
      return Future.value(false);
    }
    return Geolocator.requestPermission().then((value) {
      if (value == LocationPermission.denied ||
          value == LocationPermission.deniedForever) {
        return false;
      }
      return true;
    }).onError((error, stackTrace) async {
      print('ERROR$error');
      await Geolocator.requestPermission();
      return false;
    });
  }
}
