import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/cart/createOrderForFulfilment.dart';
import 'package:vegan_liverpool/services.dart';

class GenerateQRFromUserDetailsViewModel extends Equatable {
  const GenerateQRFromUserDetailsViewModel({
    required this.isSimulator,
    required this.orderId,
    required this.generatorWalletAddress,
    required this.vegiUserId,
    required this.vegiAccountId,
    // required this.customerWalletAddress,
    // required this.vendorWalletAddress,
  });

  factory GenerateQRFromUserDetailsViewModel.fromStore(Store<AppState> store) {
    return GenerateQRFromUserDetailsViewModel(
      isSimulator: store.state.userState.isUsingSimulator,
      vegiUserId: store.state.userState.vegiUserId,
      vegiAccountId: store.state.userState.vegiAccountId,
      orderId: store.state.cartState.orderID,
      generatorWalletAddress: store.state.userState.accountAddress,
      // customerWalletAddress: store.state.userState.isVendor
      //     ? store.state.userState.accountAddress
      //     : null,
      // vendorWalletAddress: store.state.userState.isVendor
      //     ? store.state.userState.accountAddress
      //     : store.state.cartState.restaurantWalletAddress,
    );
  }

  // final String? customerWalletAddress;
  // final String vendorWalletAddress;
  final String generatorWalletAddress;
  final int? vegiUserId;
  final int? vegiAccountId;
  final String orderId;
  final bool isSimulator;

  Map<String, dynamic> get userIdJson => {
        'id': vegiUserId,
        // 'vegiAccountId': vegiAccountId,
        // 'walletAddress': generatorWalletAddress,
      };

  String get encodedUserId => json.encode(userIdJson);

  @override
  List<Object?> get props => [
        orderId,
        isSimulator,
        generatorWalletAddress,
        // customerWalletAddress,
        // vendorWalletAddress,
        encodedUserId,
      ];
}
