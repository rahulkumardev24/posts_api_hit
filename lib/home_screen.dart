import 'dart:convert';
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
                return const Center(child: CircularProgressIndicator());
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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 7,
                              shadowColor: Colors.deepOrange,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(eachPost.title,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.lightBlue,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    Text(eachPost.body),
                                    /// tags show
                                    const SizedBox(height: 5,),
                                    Text(eachPost.tagsModel.tags.join(', '),style: const TextStyle(fontSize: 11 , color: Colors.black54),) ,
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(Icons.remove_red_eye, size: 30, color: Colors.deepOrangeAccent,),
                                    /// view
                                        Text(eachPost.views.toString()),
                                        const Icon(Icons.thumb_up_alt_outlined , size: 30, color: Colors.lightBlue,) ,
                                        Text(eachPost.reactions.likes.toString()) ,
                                        const Icon(Icons.thumb_down_alt_outlined, size: 30,color: Colors.lightBlue,) ,
                                        Text(eachPost.reactions.dislikes.toString()) ,

                                      ],
                                    )

                                  ],
                                ),
                              ),
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
