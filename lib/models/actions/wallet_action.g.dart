// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Bonus _$$BonusFromJson(Map<String, dynamic> json) => _$Bonus(
      id: json['_id'] as String,
      status: json['status'] as String,
      tokenAddress: json['tokenAddress'] as String,
      to: json['to'] as String,
      value: BigInt.parse(json['value'] as String),
      tokenName: json['tokenName'] as String,
      tokenSymbol: json['tokenSymbol'] as String,
      tokenDecimal: json['tokenDecimal'] as int,
      timestamp: json['timestamp'] as int? ?? 0,
      name: json['name'] as String? ?? 'tokenBonus',
      txHash: json['txHash'] as String?,
      blockNumber: json['blockNumber'] as int? ?? 0,
      from: json['from'] as String?,
      bonusType: json['bonusType'] as String?,
    );

Map<String, dynamic> _$$BonusToJson(_$Bonus instance) => <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'tokenAddress': instance.tokenAddress,
      'to': instance.to,
      'value': instance.value.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
      'timestamp': instance.timestamp,
      'name': instance.name,
      'txHash': instance.txHash,
      'blockNumber': instance.blockNumber,
      'from': instance.from,
      'bonusType': instance.bonusType,
    };

_$Send _$$SendFromJson(Map<String, dynamic> json) => _$Send(
      id: json['_id'] as String,
      status: json['status'] as String,
      tokenAddress: json['tokenAddress'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      value: BigInt.parse(json['value'] as String),
      tokenName: json['tokenName'] as String,
      tokenSymbol: json['tokenSymbol'] as String,
      tokenDecimal: json['tokenDecimal'] as int,
      timestamp: json['timestamp'] as int? ?? 0,
      name: json['name'] as String? ?? 'sendTokens',
      txHash: json['txHash'] as String?,
      blockNumber: json['blockNumber'] as int? ?? 0,
    );

Map<String, dynamic> _$$SendToJson(_$Send instance) => <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'tokenAddress': instance.tokenAddress,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
      'timestamp': instance.timestamp,
      'name': instance.name,
      'txHash': instance.txHash,
      'blockNumber': instance.blockNumber,
    };

_$FiatDeposit _$$FiatDepositFromJson(Map<String, dynamic> json) =>
    _$FiatDeposit(
      id: json['_id'] as String,
      status: json['status'] as String,
      tokenAddress: json['tokenAddress'] as String,
      to: json['to'] as String,
      value: BigInt.parse(json['value'] as String),
      tokenName: json['tokenName'] as String,
      tokenSymbol: json['tokenSymbol'] as String,
      tokenDecimal: json['tokenDecimal'] as int,
      timestamp: json['timestamp'] as int? ?? 0,
      name: json['name'] as String? ?? 'fiat-deposit',
      txHash: json['txHash'] as String?,
      blockNumber: json['blockNumber'] as int? ?? 0,
      from: json['from'] as String?,
    );

Map<String, dynamic> _$$FiatDepositToJson(_$FiatDeposit instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'tokenAddress': instance.tokenAddress,
      'to': instance.to,
      'value': instance.value.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
      'timestamp': instance.timestamp,
      'name': instance.name,
      'txHash': instance.txHash,
      'blockNumber': instance.blockNumber,
      'from': instance.from,
    };

_$CreateWallet _$$CreateWalletFromJson(Map<String, dynamic> json) =>
    _$CreateWallet(
      id: json['_id'] as String,
      status: json['status'] as String,
      timestamp: json['timestamp'] as int? ?? 0,
      name: json['name'] as String? ?? 'createWallet',
      txHash: json['txHash'] as String?,
      blockNumber: json['blockNumber'] as int? ?? 0,
    );

Map<String, dynamic> _$$CreateWalletToJson(_$CreateWallet instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'timestamp': instance.timestamp,
      'name': instance.name,
      'txHash': instance.txHash,
      'blockNumber': instance.blockNumber,
    };

_$Swap _$$SwapFromJson(Map<String, dynamic> json) => _$Swap(
      id: json['_id'] as String,
      status: json['status'] as String,
      timestamp: json['timestamp'] as int? ?? 0,
      name: json['name'] as String? ?? 'swapTokens',
      txHash: json['txHash'] as String?,
      blockNumber: json['blockNumber'] as int? ?? 0,
      tradeInfo: json['metadata'] == null
          ? null
          : Trade.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SwapToJson(_$Swap instance) => <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'timestamp': instance.timestamp,
      'name': instance.name,
      'txHash': instance.txHash,
      'blockNumber': instance.blockNumber,
      'metadata': instance.tradeInfo?.toJson(),
    };

_$Receive _$$ReceiveFromJson(Map<String, dynamic> json) => _$Receive(
      id: json['_id'] as String,
      status: json['status'] as String,
      tokenAddress: json['tokenAddress'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      value: BigInt.parse(json['value'] as String),
      tokenName: json['tokenName'] as String,
      tokenSymbol: json['tokenSymbol'] as String,
      tokenDecimal: json['tokenDecimal'] as int,
      timestamp: json['timestamp'] as int? ?? 0,
      name: json['name'] as String? ?? 'receiveTokens',
      txHash: json['txHash'] as String?,
      blockNumber: json['blockNumber'] as int? ?? 0,
    );

Map<String, dynamic> _$$ReceiveToJson(_$Receive instance) => <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'tokenAddress': instance.tokenAddress,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
      'timestamp': instance.timestamp,
      'name': instance.name,
      'txHash': instance.txHash,
      'blockNumber': instance.blockNumber,
    };

_$ReceiveNFT _$$ReceiveNFTFromJson(Map<String, dynamic> json) => _$ReceiveNFT(
      id: json['_id'] as String,
      status: json['status'] as String,
      tokenAddress: json['tokenAddress'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      tokenName: json['tokenName'] as String,
      tokenSymbol: json['tokenSymbol'] as String,
      tokenDecimal: json['tokenDecimal'] as int,
      timestamp: json['timestamp'] as int? ?? 0,
      name: json['name'] as String? ?? 'receiveNFT',
      txHash: json['txHash'] as String?,
      blockNumber: json['blockNumber'] as int? ?? 0,
    );

Map<String, dynamic> _$$ReceiveNFTToJson(_$ReceiveNFT instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'tokenAddress': instance.tokenAddress,
      'from': instance.from,
      'to': instance.to,
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
      'timestamp': instance.timestamp,
      'name': instance.name,
      'txHash': instance.txHash,
      'blockNumber': instance.blockNumber,
    };
