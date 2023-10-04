import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/cash_wallet_state.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class BalanceViewModel extends Equatable {
  const BalanceViewModel({
    // required this.gbpxbalance,
    required this.gbtBalance,
    required this.selectedGBTToSpend,
  });

  factory BalanceViewModel.fromStore(Store<AppState> store) {
    final CashWalletState cashWalletState = store.state.cashWalletState;
    return BalanceViewModel(
      gbtBalance: Money(
        currency: Currency.GBT,
        value: cashWalletState.tokens[TokenDefinitions.greenBeanToken.address]!
            .getAmountTokens(),
      ),
      selectedGBTToSpend: store.state.cartState.selectedCashBackAppliedToCart,
      // gbpxbalance: cashWalletState.tokens[gbpxToken.address]!
      //     .getAmountTokens()
      //     .toStringAsFixed(2),
      // usdValue: display(value),
    );
  }

  final Money gbtBalance;
  final Money selectedGBTToSpend;
  // final String gbpxbalance;

  @override
  List<Object> get props => [
        gbtBalance,
        gbtBalance.currency,
        gbtBalance.value,
        selectedGBTToSpend,
        selectedGBTToSpend.currency,
        selectedGBTToSpend.value,
        // gbpxbalance,
      ];
}
