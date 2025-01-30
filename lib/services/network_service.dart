// https://679b51f433d3168463236fc8.mockapi.io/user
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../post.dart';

class NetworkService {

  // get api from the internet
  Future<Post> fetchPost() async {
    final uri = Uri.parse("https://679b51f433d3168463236fc8.mockapi.io/user");
    final response = await http.get(uri);
    if(response.statusCode == 200){
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  // post data to the backend
Future<Post> createPost(String title, String description) async {
    Map<String, dynamic> request = {
      'title' : title,
      'description' : description,
      'userId' : "111"
    };

    final uri = Uri.parse("https://679b51f433d3168463236fc8.mockapi.io/user");
    final response = await http.post(uri, body: request);

    if(response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
}

//update data in backend api

Future<Post> updatePost(String title, String description) async {
    Map<String, dynamic>  request = {
      'id': "101",
      'title':title,
      'description':description,
      'userId':"111"
    };

    final uri = Uri.parse("https://679b51f433d3168463236fc8.mockapi.io/user");
    final response = await http.put(uri, body: request);

    if(response.statusCode == 200){
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
}

// delete data in backend api

Future<Post?>? deletePost() async {
    final uri = Uri.parse("https://679b51f433d3168463236fc8.mockapi.io/user");
    final response = await http.delete(uri);

    if(response.statusCode == 200){
      return null;
    } else {
      throw Exception("Failed to load post");
    }
}
}