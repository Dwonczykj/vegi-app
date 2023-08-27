import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/restaurant/ESCRating.dart';
import 'package:vegan_liverpool/redux/viewsmodels/bill_invoice_vm.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({
    required this.rating,
    Key? key,
  }) : super(key: key);

  final ESCRating rating;

  @override
  Widget build(BuildContext context) {
    final escColor = colorForESCRating(rating.rating);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: themeAccent200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: StoreConnector<AppState, BillInvoiceViewModel>(
            converter: BillInvoiceViewModel.fromStore,
            distinct: true,
            builder: (context, viewmodel) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    title: Text(
                      rating.product_name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Icon(
                      Icons.circle,
                      color: escColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
