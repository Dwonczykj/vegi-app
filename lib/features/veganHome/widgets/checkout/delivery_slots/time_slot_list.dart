import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/viewsmodels/checkout/time_slot_list_vm.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class TimeSlotListBuilder extends StatefulWidget {
  const TimeSlotListBuilder({Key? key}) : super(key: key);

  @override
  State<TimeSlotListBuilder> createState() => _TimeSlotListBuilderState();
}

class _TimeSlotListBuilderState extends State<TimeSlotListBuilder> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TimeSlotListViewModel>(
      converter: TimeSlotListViewModel.fromStore,
      builder: (context, viewmodel) {
        return viewmodel.timeSlots.isNotEmpty
            ? GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewmodel.timeSlots.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  childAspectRatio: 2.3,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      log.verbose(
                        'Update selected fulfilment timeslot to: ${viewmodel.timeSlots[index]}',
                      );
                      viewmodel
                          .updateSelectedTimeSlot(viewmodel.timeSlots[index]);
                      setState(() {
                        _selected = index;
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                        color: index == _selected
                            ? themeShade200
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          viewmodel.timeSlots[index].formattedDateTimeOnly,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'No slots available',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              );
      },
    );
  }
}
