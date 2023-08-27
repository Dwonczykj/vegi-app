import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/restaurant/ESCExplanation.dart';
import 'package:vegan_liverpool/redux/viewsmodels/bill_invoice_vm.dart';

class ExplanationsCard extends StatelessWidget {
  const ExplanationsCard({
    required this.explanation,
    Key? key,
  }) : super(key: key);

  final ESCExplanation explanation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final escColor = colorForESCRating(explanation.measure);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: themeShade100,
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
                    // title: Text(
                    //   explanation.title,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: 16,
                    //   ),
                    // ),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          explanation.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        // Text('${explanation.rating}/${explanation.measure}'),
                        Text('${explanation.measure.toStringAsFixed(1)}'),
                      ],
                    ),
                    trailing: Icon(
                      Icons.circle,
                      color: escColor,
                    ),
                  ),
                  if (explanation.imageUrl.isNotEmpty) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 5),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            memCacheWidth: size.width.toInt(),
                            imageUrl: explanation.imageUrl,
                            fit: BoxFit.cover,
                            width: size.width,
                            errorWidget: (context, error, stackTrace) =>
                                const Icon(
                              Icons.broken_image,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                  const Divider(
                    color: themeShade300,
                    thickness: 1,
                    height: 30,
                  ),
                  ...explanation.reasons.mapIndexed(
                    (i, reason) {
                      return Text.rich(
                        TextSpan(
                          text: '#$i ${reason}',
                        ),
                      );
                    },
                  ).toList()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
