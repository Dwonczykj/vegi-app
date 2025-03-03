import 'package:vegan_liverpool/constants/enums.dart';

const ONGOING_ORDERS_COUNTDOWN_HOURS = 5;

const NEARBY_VENDORS_DISTANCE_KM = 5;

class AppConfig {
  static const useFusePayments = false;
  static const useWeb3Auth = false;
  static const waitingListQueuePreLaunchPerksBound = 100;
  static const rewardCurrency = Currency.GBT;
  static const stripeCardPaymentFlowTimeOutMillis = 60 * 1000;
}
