import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';

part 'vegiConfigDTO.freezed.dart';
part 'vegiConfigDTO.g.dart';

List<VegiConfigDTO> fromJsonVegiConfigDTOList(dynamic json) =>
  fromSailsListOfObjectJson<VegiConfigDTO>(VegiConfigDTO.fromJson)(json);
VegiConfigDTO? fromJsonVegiConfigDTO(dynamic json) =>
  fromSailsObjectJson<VegiConfigDTO>(VegiConfigDTO.fromJson)(json);

@Freezed()
class VegiConfigDTO with _$VegiConfigDTO {
  @JsonSerializable()
  factory VegiConfigDTO({
    required String databaseUrl,
    required String databaseSailsAdapter,
    required String webserverHostName,
    required String environment,
  }) = _VegiConfigDTO;

  const VegiConfigDTO._();

  factory VegiConfigDTO.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$VegiConfigDTOFromJson(json),
      );
}
