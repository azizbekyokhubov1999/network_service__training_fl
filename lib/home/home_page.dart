import 'package:flutter/material.dart';
import 'package:networking_service_training_fl/services/network_service.dart';

import '../post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Post?>? post;

  void clickGetButton(){
    setState(() {
      post = NetworkService().fetchPost();
    });
  }

  void clickDeleteButton(){
    setState(() {
      post = NetworkService().deletePost();
    });
  }

  void clickPostButton() {
    setState(() {
      post = NetworkService().createPost("Top Post", "This is example of post");
    });
  }

  void clickUpdateButton() {
    setState(() {
      post = NetworkService().updatePost("Updates Post", "New updated example post");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("http package")),
        backgroundColor: Colors.amber[300],
      ),
      body: SizedBox(
        height: 500,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder<Post?>(
                future: post,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  } else if(snapshot.connectionState == ConnectionState.none){
                    return Container();
                  } else {
                    if(snapshot.hasData){
                      return buildDataWidget(context, snapshot);
                    } else if(snapshot.hasError){
                      return Text("${snapshot.error}");
                    }else {
                      return Container();
                    }
                  }
                }),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () => clickGetButton(),
                  child: Text("GET"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[300]
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () => clickPostButton(),
                  child: Text("POST"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[300]
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () => clickUpdateButton(),
                  child: Text("UPDATE"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[300]
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () => clickDeleteButton(),
                  child: Text("DELETE"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[300]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataWidget(context, snapshot) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
          padding: EdgeInsets.all(15.0),
        child: Text(snapshot.data.title),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(snapshot.data.description),
      ),
    ],
  );
}

