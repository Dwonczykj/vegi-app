import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';

part 'transaction_item.freezed.dart';
part 'transaction_item.g.dart';

List<TransactionItem> fromJsonTransactionItemList(dynamic json) =>
    fromSailsListOfObjectJson<TransactionItem>(TransactionItem.fromJson)(json);
TransactionItem? fromJsonTransactionItem(dynamic json) =>
    fromSailsObjectJson<TransactionItem>(TransactionItem.fromJson)(json);

@Freezed()
class TransactionItem with _$TransactionItem {
  @JsonSerializable()
  factory TransactionItem({
    int? id,
    @JsonKey(
      fromJson: jsonToTimeStamp,
      toJson: timeStampToJsonInt,
    )
    required DateTime timestamp,
    required num amount,
    required Currency currency,
    @JsonKey(fromJson: objectIdFromJson) required int receiver,
    @JsonKey(fromJson: objectIdFromJson) required int payer,
    @JsonKey(fromJson: objectIdFromJsonNullable) required int? order,
  }) = _TransactionItem;

  const TransactionItem._();

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);
}
