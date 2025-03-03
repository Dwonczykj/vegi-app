// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:vegan_liverpool/common/router/routes.dart';
// import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
// import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
// import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
// import 'package:vegan_liverpool/generated/l10n.dart';
// import 'package:vegan_liverpool/models/app_state.dart';
// import 'package:vegan_liverpool/redux/viewsmodels/recovery.dart';
// import 'package:vegan_liverpool/services.dart';
// import 'package:vegan_liverpool/utils/log/log.dart';

// import 'package:auto_route/annotations.dart';

// @RoutePage()
// class RestoreFromBackupScreen extends StatefulWidget {
//   const RestoreFromBackupScreen({Key? key}) : super(key: key);

//   @override
//   State<RestoreFromBackupScreen> createState() =>
//       _RestoreFromBackupScreenState();
// }

// class _RestoreFromBackupScreenState extends State<RestoreFromBackupScreen> {
//   bool isLoading = false;
//   final wordsController = TextEditingController(text: '');
//   final _formKey = GlobalKey<FormState>();
//   bool isPreloading = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     wordsController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyScaffold(
//       title: I10n.of(context).restore_from_backup,
//       body: Container(
//         padding: const EdgeInsets.only(
//           bottom: 40,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(top: 30),
//                         child: Text(
//                           I10n.of(context).restore_words,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: <Widget>[
//                         TextFormField(
//                           controller: wordsController,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: 5,
//                           style: TextStyle(
//                             color: Theme.of(context).colorScheme.onSurface,
//                             backgroundColor: Theme.of(context).canvasColor,
//                           ),
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 2,
//                                 color: Theme.of(context).colorScheme.onSurface,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 2,
//                                 color: Theme.of(context).colorScheme.onSurface,
//                               ),
//                             ),
//                             fillColor: Colors.transparent,
//                           ),
//                           validator: (String? value) =>
//                               value?.split(' ').length != 12
//                                   ? 'Please enter 12 words'
//                                   : null,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 StoreConnector<AppState, RecoveryViewModel>(
//                   distinct: true,
//                   converter: RecoveryViewModel.fromStore,
//                   builder: (_, viewModel) => Center(
//                     child: PrimaryButton(
//                       preload: isPreloading,
//                       disabled: isPreloading,
//                       label: I10n.of(context).next_button,
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           setState(() {
//                             isPreloading = true;
//                           });
//                           final seedPhrase = wordsController.text
//                               .toLowerCase()
//                               .replaceAll(RegExp(r'[^A-Za-z0-9\s]'), '');
//                           if (viewModel
//                               .validateWalletRecoveryPhrase(seedPhrase)) {
//                             viewModel.generateWalletFromBackup(seedPhrase, () {
//                               setState(() {
//                                 isPreloading = false; // replace with
//                               });
//                               // log.info('Push SignUpScreen() from ${rootRouter.current.name} in generate wallet from backup button.');
//                               // context.router.push(const SignUpScreen());
//                             }, () {
//                               setState(() {
//                                 isPreloading = false;
//                               });
//                               showErrorSnack(
//                                 context: context,
//                                 message: I10n.of(context).phrase_invaild,
//                                 title: I10n.of(context).oops,
//                               );
//                             });
//                           } else {
//                             setState(() {
//                               isPreloading = false;
//                             });
//                             showErrorSnack(
//                               context: context,
//                               message: I10n.of(context).phrase_invaild,
//                               title: I10n.of(context).oops,
//                             );
//                           }
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
