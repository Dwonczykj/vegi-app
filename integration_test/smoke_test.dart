import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vegan_liverpool/app.dart';
import 'package:vegan_liverpool/features/home/widgets/button.dart';
import 'package:vegan_liverpool/features/onboard/screens/security_screen.dart';
import 'package:vegan_liverpool/features/onboard/screens/username_screen.dart';
import 'package:vegan_liverpool/features/onboard/screens/verify_screen.dart';
import 'package:vegan_liverpool/features/screens/on_board_screen.dart';
import 'package:vegan_liverpool/features/screens/set_up_pincode.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/veganHome/screens/veganHome.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/menu/detailMenuItemView.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/menu/detailMenuViewQuantityButton.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/menu/floating_cart_bar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/menu/singleFeaturedMenuItem.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/shimmerButton.dart';
import 'package:vegan_liverpool/services.dart';

import 'register_dependencies.dart';
import 'tests_common.dart';
// import '../lib_old/main.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  late TestsCommon tests;

  // testWidgets('Route Transition Test', (WidgetTester tester) async {
  //   await registerDependencies();
  //   final store = await reduxStore;
  //   // Run app
  //   await tester.pumpWidget(MyApp(store)); // Create main app
  //   await tester.pumpAndSettle(); // Finish animations and scheduled microtasks

  //   // Simulate route transition
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => NextScreen()));

  //   // Wait for the widget tree to update
  //   await tester.pump();

  //   // Make assertions on the new screen's content
  // });

  testWidgets('Smoke test', (WidgetTester tester) async {
    await registerDependencies();
    final store = await reduxStore;

    tests = TestsCommon(tester);
    // Run app
    await tester.pumpWidget(MyApp(store)); // Create main app
    await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
    await tester.pump(Duration(seconds: 2)); // Wait some time
    await tester.pump(); // Wait some time
    await tester.pump(); // Wait some time
    await tester.pump(); // Wait some time

    // Enumerate all states that exist in the app just to show we can
    // print("All states: ");
    // tester.allStates.forEach((s) => print(s));

    // wait until the wallet screen is shown
    await tests.waitUntil(
        conditionMet: () => find.byType(OnBoardScreen).evaluate().isNotEmpty);

    // await tester.pumpWidget(MyApp(store));

    final Finder onboardingRightArrowButton =
        find.byKey(ValueKey('onboardingRightArrowButton'));

    expect(onboardingRightArrowButton, findsOneWidget);

    // Tap Button
    await tester.tap(onboardingRightArrowButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.tap(onboardingRightArrowButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.tap(onboardingRightArrowButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.tap(onboardingRightArrowButton, warnIfMissed: true);
    await tester.pumpAndSettle();
    await tester.pump();

    // Find textFields
    final Finder phoneTextField = find.byKey(
      ValueKey("SignUpScreenPhoneNoCountryField"),
    );
    expect(phoneTextField, findsOneWidget);

    final Finder countryCodeTextField = find.byType(
      CountryCodePicker,
    );
    expect(countryCodeTextField, findsOneWidget);
    final Finder signUpScreenNextButton = find.byType(
      PrimaryButton,
    );
    expect(signUpScreenNextButton, findsOneWidget);

    await tester.enterText(phoneTextField, '5733450033');

    await tester.tap(countryCodeTextField);
    await tester.pumpAndSettle();

    ///if you want to tap first item
    final dropdownItem = find.text('+1 United States of America'); //.last;
    expect(dropdownItem, findsOneWidget);
    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();
    await tester.pump();
    await tester.tap(signUpScreenNextButton);
    await tester.pump();
    await tester.pumpAndSettle();
    await tester.pump();

    await tests.waitUntil(
        conditionMet: () =>
            find.byType(VerifyPhoneNumber).evaluate().isNotEmpty);

    // Find textFields
    final Finder verifySMSCodeTextField = find.byType(
      PinCodeTextField,
    );
    expect(verifySMSCodeTextField, findsOneWidget);

    await tester.enterText(verifySMSCodeTextField, '635347');
    await tester.pumpAndSettle();

    // final Finder verifyScreenNextButton = find.byType(
    //   PrimaryButton,
    // );
    // expect(verifyScreenNextButton, findsOneWidget);
    // await tester.tap(verifyScreenNextButton);
    // await tester.pump();
    // await tester.pumpAndSettle();
    // await tester.pump();

    // find a widget by its type
    final bioAuthSelectorScreen = find.byType(ChooseSecurityOption);
    // tap a child of the parentWidget that contains the text 'US Stocks'
    await tester.tap(
      find.descendant(
          of: bioAuthSelectorScreen, matching: find.textContaining('Pincode')),
    );
    await tester.pumpAndSettle();
    await tester.pump();

    // final bioAuthSetScreen = find.byType(SetUpPinCodeScreen);
    // expect(bioAuthSetScreen, findsOneWidget);
    // final bioAuthSetScreenForm = find.byType(Form);
    // expect(bioAuthSetScreenForm, findsOneWidget);
    // final bioAuthSetScreenTextField = find.byType(PinCodeTextField);
    // expect(bioAuthSetScreenTextField, findsOneWidget);

    // tap a child of the parentWidget that contains the text 'US Stocks'
    // final setUpPincodeTextField = find.descendant(
    //     of: bioAuthSetScreen,
    //     matching: find.byKey(ValueKey("SetUpPincodeTextField")).hitTestable());
    // final setUpPincodeTextField =
    //     find.byKey(ValueKey("SetUpPincodeTextField")).hitTestable();
    final setUpPincodeTextField = find.byType(PinCodeTextField);
    await tester.enterText(
      setUpPincodeTextField,
      '555555',
    );
    await tester.pumpAndSettle();
    await tester.pump();
    // setUpPincodeTextField =
    //     find.byKey(ValueKey("SetUpPincodeTextField")).hitTestable();
    await tester.enterText(
      setUpPincodeTextField,
      '555555',
    );
    await tester.pumpAndSettle();
    await tester.pump();

    // * HOME SCREEN

    final homeScreenWidget = find.byType(VeganHomeScreen);
    expect(homeScreenWidget, findsOneWidget);
    final purpleCarrotRestaurantItemWidget = find.text('Purple Carrot');
    expect(
      purpleCarrotRestaurantItemWidget,
      findsOneWidget,
    );
    await tester.tap(purpleCarrotRestaurantItemWidget);
    await tester.pumpAndSettle();
    await tester.pump();

    // final productItem = find.text('Falafel Balls');
    // // find.widgetWithText(SingleFeaturedMenuItem, 'Falafel Balls');
    // expect(productItem, findsOneWidget);
    // await tester.tap(productItem);
    // await tester.pump();

    // expect(find.byType(DetailMenuItemView), findsOneWidget);
    // final quantityButton = find.byType(DetailMenuViewQuantityButton);
    // expect(quantityButton, findsOneWidget);
    // final addToToteButton = find.widgetWithText(ElevatedButton, 'Add to Tote');
    // expect(addToToteButton, findsOneWidget);
    // final increaseItemCountButton = find.descendant(
    //     of: quantityButton,
    //     matching: find.widgetWithIcon(IconButton, Icons.add));
    // expect(increaseItemCountButton, findsOneWidget);
    // final decreaseItemCountButton = find.descendant(
    //     of: quantityButton,
    //     matching: find.widgetWithIcon(IconButton, Icons.remove));
    // expect(decreaseItemCountButton, findsOneWidget);

    // // tap a child of the parentWidget that contains the text 'US Stocks'
    // await tester.tap(
    //   addToToteButton,
    // );
    // await tester.pump();

    // final houmousProductItem =
    //     find.widgetWithText(SingleFeaturedMenuItem, 'Classic Houmous');
    // expect(houmousProductItem, findsOneWidget);
    // await tester.tap(houmousProductItem);
    // await tester.pump();

    // expect(find.byType(DetailMenuItemView), findsOneWidget);
    // final quantityButton2 = find.byType(DetailMenuViewQuantityButton);
    // expect(quantityButton2, findsOneWidget);
    // final addToToteButton2 = find.widgetWithText(ElevatedButton, 'Add to Tote');
    // expect(addToToteButton2, findsOneWidget);
    // final increaseItemCountButton2 = find.descendant(
    //     of: quantityButton,
    //     matching: find.widgetWithIcon(IconButton, Icons.add));
    // expect(increaseItemCountButton2, findsOneWidget);
    // final decreaseItemCountButton2 = find.descendant(
    //     of: quantityButton,
    //     matching: find.widgetWithIcon(IconButton, Icons.remove));
    // expect(decreaseItemCountButton2, findsOneWidget);

    // // tap a child of the parentWidget that contains the text 'US Stocks'
    // await tester.tap(
    //   increaseItemCountButton2,
    // );
    // await tester.tap(
    //   increaseItemCountButton2,
    // );
    // await tester.tap(
    //   addToToteButton2,
    // );
    // await tester.pump();

    // expect(find.byType(FloatingCartBar), findsOneWidget);

    // expect(
    //     find.widgetWithText(
    //         Text, 'This restaurant is not accepting orders below £0.30'),
    //     findsNothing);

    // final gotoCheckoutButton = find.byType(ShimmerButton);

    // expect(gotoCheckoutButton, findsOneWidget);

    // await tester.tap(gotoCheckoutButton);

    // Set Delivery Address (if none - it will be)
    // Choose card and place order

    // expect(verifySMSCodeTextField, findsOneWidget);

    // final Finder userNameScreenNextButton = find.byType(
    //   PrimaryButton,
    // );
    // expect(userNameScreenNextButton, findsOneWidget);

    // await tester.enterText(verifySMSCodeTextField, 'Tester');
    // await tester.pumpAndSettle();

    // await tester.tap(userNameScreenNextButton);
    // await tester.pump();
    // await tester.pumpAndSettle();
    // await tester.pump();

    // Find textFields
    // final Finder pincodeTextField = find.byElementType(PinCodeTextField);
    // // final Finder passText = find.byKey(ValueKey('passText'));

    // // Ensure there is a login and password field on the initial page
    // expect(pincodeTextField, findsOneWidget);
    // // expect(passText, findsOneWidget);

    // // Enter text
    // await tester.enterText(pincodeTextField, '555555');
    // // await tester.enterText(passText, 'password');
    // await tester.pumpAndSettle();
    // await tester.pump(Duration(seconds: 2));

    // // Tap btn
    // final Finder loginBtn = find.byKey(ValueKey('loginBtn'));
    // await tester.tap(loginBtn, warnIfMissed: true);
    // await tester.pumpAndSettle();
    // await tester.pump(Duration(seconds: 2));

    // Check internal state
    // MyAppState state = tester.state(find.byType(MyApp));
    // expect(state.isLoggedInState.value, true);

    // // Get navigator and show a dialog
    // NavigatorState navigator = state.navKey.currentState!;
    // print(navigator.context);
    // showDialog(
    //   context: navigator.context,
    //   builder: (c) => _SomeDialog(),
    // );
    // await tester.pumpAndSettle();
    // await tester.pump(Duration(seconds: 1));

    // // Close dialog, method 1
    // navigator.pop();
    // await tester.pumpAndSettle();

    // // Verify dialog was closed
    // expect(find.byWidget(_SomeDialog()), findsNothing);

    // // Show dialog again
    // showDialog(context: navigator.context, builder: (c) => _SomeDialog());
    // await tester.pumpAndSettle();

    // // Close dialog, method 2
    // await tester.tap(find.byKey(ValueKey('okBtn')));
    // await tester.pumpAndSettle();

    // // Verify dialog was closed
    // expect(find.byType(_SomeDialog), findsNothing);

    // Expect all anims have finished
    expect(SchedulerBinding.instance.transientCallbackCount, 0);

    // Wait a bit more...
    await tester.pump(Duration(seconds: 2));
  });
}

class _SomeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        OutlinedButton(
          key: ValueKey("okBtn"),
          onPressed: () => Navigator.pop(context),
          child: Text("Ok"),
        ),
      ],
    );
  }
}
