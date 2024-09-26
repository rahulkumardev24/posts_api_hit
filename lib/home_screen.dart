import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posts_api_hit_expmple/model/post_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
        ),
        body: FutureBuilder<PostData?>(
            future: getPosts(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snap.hasError) {
                return Center(
                  child: Text("Error ${snap.error}"),
                );
              } else if (snap.hasData) {
                return snap.data != null
                    ? ListView.builder(
                    itemCount: snap.data!.posts!.length,
                    itemBuilder: (context, index) {
                      PostModel eachPost = snap.data!.posts![index];
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(eachPost.title!,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(eachPost.body!),
                          ],
                        ),
                      );
                    })
                    : Container();
              }
              return Container();
            }));
  }

  Future<PostData?> getPosts() async {
    PostData? postData;
    String url = "https://dummyjson.com/posts";
    Uri uri = Uri.parse(url);
    http.Response res = await http.get(uri);
    if (res.statusCode == 200) {
      print("Response Body  : ${res.body}");
      var resData = jsonDecode(res.body);
      postData = PostData.fromJson(resData);
    }
    return postData;
  }
}
