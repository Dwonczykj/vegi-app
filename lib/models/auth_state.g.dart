// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthState _$$_AuthStateFromJson(Map<String, dynamic> json) => _$_AuthState(
      phoneNumberToPrivateKeyMap:
          Map<String, String>.from(json['phoneNumberToPrivateKeyMap'] as Map),
    );

Map<String, dynamic> _$$_AuthStateToJson(_$_AuthState instance) =>
    <String, dynamic>{
      'phoneNumberToPrivateKeyMap': instance.phoneNumberToPrivateKeyMap,
    };
