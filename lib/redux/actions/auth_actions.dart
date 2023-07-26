class RegisterNewFusePrivateKey {
  RegisterNewFusePrivateKey({
    required this.fusePrivateKey,
    required this.phoneNumberNoCountry,
    required this.phoneNumberCountryCode,
  });

  final String fusePrivateKey;
  final String phoneNumberNoCountry;
  final String phoneNumberCountryCode;

  @override
  String toString() {
    return 'RegisterNewFusePrivateKey : fusePrivateKey:"$fusePrivateKey", phoneNumber:"+$phoneNumberCountryCode $phoneNumberNoCountry"';
  }
}
