class ClassPenangkap {
  int _id;
  String _title;
  String _deskripsi;
  String _date;
  String _location;
  String _image;

  ClassPenangkap(this._title, this._deskripsi, this._date, this._location, 
  // this._image
  );
  ClassPenangkap.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._deskripsi = map['deskripsi'];
    this._date = map['date'];
    this._location = map['location'];
    this._image = map['image'];
  }

  int get id => _id;
  String get title => _title;
  String get deskripsi => _deskripsi;
  String get date => _date;
  String get location => _location;
  String get image => _image;

  set title(String value) {
    _title = value;
  }

  set deskripsi(String value) {
    _deskripsi = value;
  }

  set date(String value) {
    _date = value;
  }

  set location(String value) {
    _location = value;
  }

  set image(String value) {
    _image = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = title;
    map['deskripsi'] = deskripsi;
    map['date'] = date;
    map['location'] = location;
    map['image'] = image;
    return map;
  }
}
