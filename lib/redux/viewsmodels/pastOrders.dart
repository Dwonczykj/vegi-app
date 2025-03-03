import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'dart:math' as Math;
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/cart/order.dart';
import 'package:vegan_liverpool/models/restaurant/orderDetails.dart';

class PastOrdersViewmodel extends Equatable {
  const PastOrdersViewmodel({
    required this.listOfScheduledOrders,
    required this.listOfOngoingOrders,
    required this.hasOngoingOrder,
    required this.globalSearchIsVisible,
    required this.isVendor,
    required this.isLoading,
  });

  factory PastOrdersViewmodel.fromStore(Store<AppState> store) {
    return PastOrdersViewmodel(
      listOfScheduledOrders: store.state.pastOrderState.listOfScheduledOrders,
      listOfOngoingOrders: store.state.pastOrderState.listOfOngoingOrders,
      hasOngoingOrder:
          store.state.pastOrderState.listOfOngoingOrders.isNotEmpty,
      globalSearchIsVisible: store.state.homePageState.showGlobalSearchBarField,
      isVendor: store.state.userState.isVendor,
      isLoading:
          // store.state.homePageState.isLoadingHomePage ||
          store.state.homePageState.isLoadingHttpRequest,
    );
  }

  final List<Order> listOfScheduledOrders;
  final List<Order> listOfOngoingOrders;
  final bool hasOngoingOrder;
  final bool globalSearchIsVisible;
  final bool isVendor;
  final bool isLoading;

  List<Order> get listOfScheduledOrdersWithPaymentsAttempted =>
      listOfScheduledOrders.where(
        (element) {
          return element.paymentAttempted == true;
        },
      ).toList();

  Order? get scheduledOrderToShow => listOfScheduledOrdersWithPaymentsAttempted
      .sortInline((a, b) {
        final timeComp = a.timeSlot.startTime.compareTo(b.timeSlot.startTime);
        if (timeComp == 0) {
          return a.orderID.compareTo(b.orderID);
        } else {
          return timeComp;
        }
      })
      .sublist(
        0,
        Math.min(
          1,
          listOfScheduledOrdersWithPaymentsAttempted.length,
        ),
      )
      .firstOrNull;

  @override
  List<Object?> get props => [
        listOfScheduledOrders,
        listOfOngoingOrders,
        hasOngoingOrder,
        globalSearchIsVisible,
        isVendor,
        isLoading,
        scheduledOrderToShow?.paymentStatusLabel,
        scheduledOrderToShow?.orderID,
        scheduledOrderToShow?.GBPxAmountPaid,
      ];
}
