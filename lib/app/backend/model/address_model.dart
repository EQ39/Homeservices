class AddressModel {
  int? id;
  int? uid;
  int? isDefault;
  String? optionalPhone;
  int? title;
  String? address;
  String? house;
  String? landmark;
  String? pincode;
  String? lat;
  String? lng;
  int? status;
  String? extraField;

  AddressModel(
      {this.id,
      this.uid,
      this.isDefault,
      this.optionalPhone,
      this.title,
      this.address,
      this.house,
      this.landmark,
     this.pincode,
      this.lat,
      this.lng,
      this.status,
      this.extraField});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    isDefault = json['is_default'] != null && json['is_default'] != ''
        ? int.parse(json['is_default'].toString())
        : 0;
    optionalPhone = json['optional_phone'];
    title = int.parse(json['title'].toString());
    address = json['address'];
    house = json['house'];
    landmark = json['landmark'];
    pincode = json['pincode'];
    lat = json['lat'];
    lng = json['lng'];
    status = int.parse(json['status'].toString());
    extraField = json['extra_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['is_default'] = isDefault;
    data['optional_phone'] = optionalPhone;
    data['title'] = title;
    data['address'] = address;
    data['house'] = house;
    data['landmark'] = landmark;
    data['pincode'] = pincode;
    data['lat'] = lat;
    data['lng'] = lng;
    data['status'] = status;
    data['extra_field'] = extraField;
    return data;
  }
}
