import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


Future<RandomUser> getData() async{
  String api = "https://randomuser.me/api/?results=40";
  http.Response response = await http.get(api);

  if(response.statusCode == 200){
    return compute(randomUserFromMap, response.body);
  }
  else{
    print("Error Internet!");
    throw Exception("Error Internet");
  }
}

RandomUser randomUserFromMap(String str) => RandomUser.fromMap(json.decode(str));

String randomUserToMap(RandomUser data) => json.encode(data.toMap());

class RandomUser {
  RandomUser({
    this.results,
    this.info,
  });

  List<Result> results;
  Info info;

  factory RandomUser.fromMap(Map<String, dynamic> json) => RandomUser(
    results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    info: Info.fromMap(json["info"]),
  );

  Map<String, dynamic> toMap() => {
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
    "info": info.toMap(),
  };
}

class Info {
  Info({
    this.seed,
    this.results,
    this.page,
    this.version,
  });

  String seed;
  int results;
  int page;
  String version;

  factory Info.fromMap(Map<String, dynamic> json) => Info(
    seed: json["seed"],
    results: json["results"],
    page: json["page"],
    version: json["version"],
  );

  Map<String, dynamic> toMap() => {
    "seed": seed,
    "results": results,
    "page": page,
    "version": version,
  };
}

class Result {
  Result({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.login,
    this.dob,
    this.registered,
    this.phone,
    this.cell,
    this.id,
    this.picture,
    this.nat,
  });

  String gender;
  Name name;
  Location location;
  String email;
  Login login;
  Dob dob;
  Dob registered;
  String phone;
  String cell;
  Id id;
  Picture picture;
  String nat;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    gender: json["gender"],
    name: Name.fromMap(json["name"]),
    location: Location.fromMap(json["location"]),
    email: json["email"],
    login: Login.fromMap(json["login"]),
    dob: Dob.fromMap(json["dob"]),
    registered: Dob.fromMap(json["registered"]),
    phone: json["phone"],
    cell: json["cell"],
    id: Id.fromMap(json["id"]),
    picture: Picture.fromMap(json["picture"]),
    nat: json["nat"],
  );

  Map<String, dynamic> toMap() => {
    "gender": gender,
    "name": name.toMap(),
    "location": location.toMap(),
    "email": email,
    "login": login.toMap(),
    "dob": dob.toMap(),
    "registered": registered.toMap(),
    "phone": phone,
    "cell": cell,
    "id": id.toMap(),
    "picture": picture.toMap(),
    "nat": nat,
  };
}

class Dob {
  Dob({
    this.date,
    this.age,
  });

  DateTime date;
  int age;

  factory Dob.fromMap(Map<String, dynamic> json) => Dob(
    date: DateTime.parse(json["date"]),
    age: json["age"],
  );

  Map<String, dynamic> toMap() => {
    "date": date.toIso8601String(),
    "age": age,
  };
}

class Id {
  Id({
    this.name,
    this.value,
  });

  String name;
  String value;

  factory Id.fromMap(Map<String, dynamic> json) => Id(
    name: json["name"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "value": value == null ? null : value,
  };
}

class Location {
  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  });

  Street street;
  String city;
  String state;
  String country;
  dynamic postcode;
  Coordinates coordinates;
  Timezone timezone;

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    street: Street.fromMap(json["street"]),
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postcode: json["postcode"],
    coordinates: Coordinates.fromMap(json["coordinates"]),
    timezone: Timezone.fromMap(json["timezone"]),
  );

  Map<String, dynamic> toMap() => {
    "street": street.toMap(),
    "city": city,
    "state": state,
    "country": country,
    "postcode": postcode,
    "coordinates": coordinates.toMap(),
    "timezone": timezone.toMap(),
  };
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  String latitude;
  String longitude;

  factory Coordinates.fromMap(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Street {
  Street({
    this.number,
    this.name,
  });

  int number;
  String name;

  factory Street.fromMap(Map<String, dynamic> json) => Street(
    number: json["number"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "number": number,
    "name": name,
  };
}

class Timezone {
  Timezone({
    this.offset,
    this.description,
  });

  String offset;
  String description;

  factory Timezone.fromMap(Map<String, dynamic> json) => Timezone(
    offset: json["offset"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "offset": offset,
    "description": description,
  };
}

class Login {
  Login({
    this.uuid,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
  });

  String uuid;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  factory Login.fromMap(Map<String, dynamic> json) => Login(
    uuid: json["uuid"],
    username: json["username"],
    password: json["password"],
    salt: json["salt"],
    md5: json["md5"],
    sha1: json["sha1"],
    sha256: json["sha256"],
  );

  Map<String, dynamic> toMap() => {
    "uuid": uuid,
    "username": username,
    "password": password,
    "salt": salt,
    "md5": md5,
    "sha1": sha1,
    "sha256": sha256,
  };
}

class Name {
  Name({
    this.title,
    this.first,
    this.last,
  });

  String title;
  String first;
  String last;

  factory Name.fromMap(Map<String, dynamic> json) => Name(
    title: json["title"],
    first: json["first"],
    last: json["last"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "first": first,
    "last": last,
  };
}

class Picture {
  Picture({
    this.large,
    this.medium,
    this.thumbnail,
  });

  String large;
  String medium;
  String thumbnail;

  factory Picture.fromMap(Map<String, dynamic> json) => Picture(
    large: json["large"],
    medium: json["medium"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toMap() => {
    "large": large,
    "medium": medium,
    "thumbnail": thumbnail,
  };
}






