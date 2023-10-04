import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/cart/discount.dart';

part 'acceptVoucherResponse.freezed.dart';
part 'acceptVoucherResponse.g.dart';

List<AcceptVoucherResponse> fromJsonAcceptVoucherResponseList(dynamic json) =>
    fromSailsListOfObjectJson<AcceptVoucherResponse>(
        AcceptVoucherResponse.fromJson)(json);
AcceptVoucherResponse? fromJsonAcceptVoucherResponse(dynamic json) =>
    fromSailsObjectJson<AcceptVoucherResponse>(AcceptVoucherResponse.fromJson)(
        json);

@Freezed()
class AcceptVoucherResponse with _$AcceptVoucherResponse {
  @JsonSerializable()
  factory AcceptVoucherResponse({
    /// 'accepted' | 'rejected' | 'already_accepted'
    required DiscountCodeAcceptanceStatus codeAcceptanceStatus,
    @JsonKey() @Default(null) Discount? discount,
  }) = _AcceptVoucherResponse;

  const AcceptVoucherResponse._();

  factory AcceptVoucherResponse.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$AcceptVoucherResponseFromJson(json),
      );
}
