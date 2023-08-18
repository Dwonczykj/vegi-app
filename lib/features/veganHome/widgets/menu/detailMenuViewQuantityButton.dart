import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/viewsmodels/detailMenuItem.dart';
import 'package:vegan_liverpool/services.dart';

class DetailMenuViewQuantityButton extends StatefulWidget {
  const DetailMenuViewQuantityButton({Key? key}) : super(key: key);

  @override
  _DetailMenuViewQuantityButtonState createState() =>
      _DetailMenuViewQuantityButtonState();
}

class _DetailMenuViewQuantityButtonState
    extends State<DetailMenuViewQuantityButton> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DetailMenuItem>(
      distinct: true,
      converter: DetailMenuItem.fromStore,
      builder: (_, viewmodel) {
        return Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: IconButton(
                onPressed: logAndPipe(
                  () => viewmodel.updateQuantity(false),
                  funcName: 'onPressed',
                  className: "$this",
                  logMessage:
                      'onPressed handler was called for $this on ${rootRouter.current.name} to remove one item to reduce quantity from (${viewmodel.quantity}) for product: "${viewmodel.menuItem?.name ?? 'menu item'}"',
                ),
                icon: const Icon(Icons.remove),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border.symmetric(
                  vertical: BorderSide(color: Colors.grey),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  viewmodel.quantity.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(3, 0),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: logAndPipe(
                  () => viewmodel.updateQuantity(true),
                  funcName: 'onPressed',
                  className: "$this",
                  logMessage:
                      'onPressed handler was called for $this on ${rootRouter.current.name} to remove one item to increase quantity from (${viewmodel.quantity}) for product: "${viewmodel.menuItem?.name ?? 'menu item'}"',
                ),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        );
      },
    );
  }
}
