import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:museum_app/models/museum.dart';

import 'models/comment.dart';
import 'package:museum_app/models/user.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<List<Museum>> getMuseum() async {
    final response = await http.get(Uri.parse('$baseUrl/api/museums'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData.map((item) => Museum.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load museums');
    }
  }

  static getToken() async {
    final storage = new FlutterSecureStorage();
    var jwt = await storage.read(key: 'jwt');

    // jwt =
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODc0NDY0NzIsImV4cCI6MTY4NzUzMjg3MiwibmJmIjoxNjg3NDQ2NDcyLCJqdGkiOiI5YnloZVFHb0hkOE9HcDhVIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.J7206DHXLBOS-zLJZXdCbj3xIZV7kLMlnMiMP6ahLHE";

    return jwt;
  }

  static Future<List<Comment>> getComments(museumId) async {
    var token = await getToken() as String;

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + token
    };

    print("send request");

    final response = await http
        .get(Uri.parse('$baseUrl/api/comments/$museumId'), headers: header);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData.map((item) => Comment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comment');
    }
  }

  static postComments(museumId, komentar) async {
    var token = await getToken() as String;

    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    };

    Map paramData = {
      'komentar': komentar,
      'museumId': museumId,
    };

    var body = json.encode(paramData);

    print("send request post comment");

    final response = await http.post(Uri.parse('$baseUrl/api/comment'),
        headers: header, body: body);
    if (response.statusCode == 201) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post comment');
    }
  }

  Future<List<Museum>> getMuseumById(int id) async {
    print('id: $id');
    final response = await http.get(Uri.parse('$baseUrl/api/museum/$id'));
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Museum.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load museums');
    }
  }

  Future<List<Museum>> getFavoriteMuseums() async {
    final storage = new FlutterSecureStorage();
    var jwt = await storage.read(key: 'jwt');
    //use bearer token
    final response = await http.get(
      Uri.parse('$baseUrl/api/favorites'),
      headers: {
        'Authorization': 'Bearer $jwt', // Include bearer token in the headers
      },
    );

    print("lola");
    print(response.statusCode);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Museum.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load museums');
    }
  }

  Future<User> getProfile() async {
    final storage = new FlutterSecureStorage();
    var jwt = await storage.read(key: 'jwt');
    final response =
        await http.get(Uri.parse('$baseUrl/api/auth/profile'), headers: {
      'Authorization': 'Bearer $jwt', // Include bearer token in the headers
    });
    print("lol");
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  //return json response function

  Future<Map<String, dynamic>> deleteFavorite(int museumId) async {
    final storage = new FlutterSecureStorage();
    var jwt = await storage.read(key: 'jwt');
    print("museumId: $museumId");
    final response = await http.post(
      Uri.parse('$baseUrl/api/delete-favorite'),
      headers: {
        'Authorization': 'Bearer $jwt',
      },
      body: {
        'museumId': museumId.toString()
      }, // Pass museumId in the request body
    );

    // Process the response and return the result
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to delete favorite');
    }
  }

  Future<Map<String, dynamic>> storeFavorite(int museumId) async {
    final storage = new FlutterSecureStorage();
    var jwt = await storage.read(key: 'jwt');
    print("museumId: $museumId");
    final response = await http.post(
      Uri.parse('$baseUrl/api/favorite'),
      headers: {
        'Authorization': 'Bearer $jwt',
      },
      body: {
        'museumId': museumId.toString()
      }, // Pass museumId in the request body
    );

    // Process the response and return the result
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to store favorite');
    }
  }
}
