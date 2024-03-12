import 'dart:math';

import 'package:museum_app/api_service.dart';
import 'package:museum_app/models/comment.dart';
import 'package:museum_app/api_service.dart';

class Museum {
  int id = 0;
  String nama = "";
  String gambarUtama = "";
  String alamatLengkap = "";
  String alamatKota = "";
  String deskripsi = "";
  String linkGoogleMap = "";
  String linkVirtualTour = "";
  double rating = 0.0;
  int countRate = 0;
  List<Comment> listKomentar = [];

  // constructor
  Museum({
    required this.id,
    required this.nama,
    required this.gambarUtama,
    required this.alamatLengkap,
    required this.alamatKota,
    required this.deskripsi,
    required this.linkGoogleMap,
    required this.linkVirtualTour,
    required this.rating,
    required this.countRate,
    required this.listKomentar,
  });

  Museum.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    nama = json['nama'] ?? '';
    gambarUtama = json['gambarUtama'] ?? '';
    alamatLengkap = json['alamatLengkap'] ?? '';
    alamatKota = json['alamatKota'] ?? '';
    deskripsi = json['deskripsi'] ?? '';
    linkGoogleMap = json['linkGoogleMap'] ?? '';
    linkVirtualTour = json['linkVirtualTour'] ?? '';
    rating = (json['rating'] ?? 0).toDouble();
    countRate = json['countRate'] ?? 0;
    listKomentar = json['listKomentar'] ?? [];
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

  // setter gambarUtama
  void setGambarUtama(String gambarUtama) {
    this.gambarUtama = gambarUtama;
  }

  // getter gambarUtama
  String getGambarUtama() {
    return gambarUtama;
  }

  // setter alamatLengkap
  void setAlamatLengkap(String alamatLengkap) {
    this.alamatLengkap = alamatLengkap;
  }

  // getter alamatLengkap
  String getAlamatLengkap() {
    return alamatLengkap;
  }

  // setter alamatKota
  void setAlamatKota(String alamatKota) {
    this.alamatKota = alamatKota;
  }

  // getter alamatKota
  String getAlamatKota() {
    return alamatKota;
  }

  // setter deskripsi
  void setDeskripsi(String deskripsi) {
    this.deskripsi = deskripsi;
  }

  // getter deskripsi
  String getDeskripsi() {
    return deskripsi;
  }

  // setter linkGoogleMap
  void setLinkGoogleMap(String linkGoogleMap) {
    this.linkGoogleMap = linkGoogleMap;
  }

  // getter linkGoogleMap
  String getLinkGoogleMap() {
    return linkGoogleMap;
  }

  // setter linkVirtualTour
  void setLinkVirtualTour(String linkVirtualTour) {
    this.linkVirtualTour = linkVirtualTour;
  }

  // getter linkVirtualTour
  String getLinkVirtualTour() {
    return linkVirtualTour;
  }

  // setter rating
  void setRating(double rating) {
    this.rating = rating;
  }

  // getter rating
  double getRating() {
    return rating;
  }

  // setter countRate
  void setCountRate(int countRate) {
    this.countRate = countRate;
  }

  // getter countRate
  int getCountRate() {
    return countRate;
  }

  // setter listKomentar
  void setListKomentar(List<Comment> listKomentar) {
    this.listKomentar = listKomentar;
  }

  // getter listKomentar
  Future<List<Comment>> getListKomentar() async {
    listKomentar = await ApiService.getComments(this.id);

    return listKomentar;
  }

  Future<List<Comment>> postKomentar(Comment newComment) async {
    await ApiService.postComments(newComment.museumId, newComment.komentar);

    listKomentar = await ApiService.getComments(this.id);

    return listKomentar;
  }
}

List<Museum> museums = [];
List<Museum> recent = [];
List<Museum> rating = [];
List<Museum> popular = [];

Future<void> getMuseums() async {
  museums = await ApiService().getMuseum();
  popular = museums;
  recent = List.from(museums.reversed);
  rating = List.from(museums);
  rating.sort((a, b) => b.rating.compareTo(a.rating));
}
