import 'package:museum_app/api_service.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/models/comment.dart';

class User {
  int id = 0;
  String nama = "";
  String email = "";
  List<Museum> favoritMuseum = [];
  List<Comment> komentar = [];

  // constructor
  User(
      {required this.id,
      required this.nama,
      required this.email,
      required this.favoritMuseum,
      required this.komentar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['name'];
    email = json['email'];
    favoritMuseum = json['favoritMuseum'] ?? [];
    komentar = json['komentar'] ?? [];
  }

  // setter id
  void setId(int id) {
    this.id = id;
  }

  // getter id
  int getId() {
    return id;
  }

  // setter nama
  void setNama(String nama) {
    this.nama = nama;
  }

  // getter nama
  String getNama() {
    return nama;
  }

  // setter email
  void setEmail(String email) {
    this.email = email;
  }

  // getter email
  String getEmail() {
    return email;
  }

  // setter favoritMuseum
  void setFavoritMuseum(List<Museum> favoritMuseum) {
    this.favoritMuseum = favoritMuseum;
  }

  // getter favoritMuseum
  List<Museum> getFavoritMuseum() {
    return favoritMuseum;
  }

  // setter komentar
  void setKomentar(List<Comment> komentar) {
    this.komentar = komentar;
  }

  // getter komentar
  List<Comment> getKomentar() {
    return komentar;
  }
}

//initiate null user
User user_1 = User(id: 0, nama: "", email: "", favoritMuseum: [], komentar: []);

Future<void> getFavorites() async {
  List<Museum> museums = await ApiService().getFavoriteMuseums();

  User user = await ApiService().getProfile();

  user_1.setFavoritMuseum(museums);
  print("erricccc");

  List<Museum> favoritMuseum = user_1.getFavoritMuseum();
  for (int i = 0; i < favoritMuseum.length; i++) {
    print(favoritMuseum[i].getNama());
    //print all attributes and values
    print(favoritMuseum[i].getId());
  }

  // popular = museums;
  // recent = List.from(museums.reversed);
  // rating = List.from(museums);
}

Future<void> getProfile() async {
  User user = await ApiService().getProfile();
  user_1.setEmail(await user.getEmail());
  user_1.setNama(await user.getNama());
  user_1.setId(await user.getId());
}
