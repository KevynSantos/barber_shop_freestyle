import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/HttpService.dart' as http;
import '../config.dart' as config;
import '../utils/toast.dart' as toast;

class PaginationListBuilder extends StatefulWidget
{
  const PaginationListBuilder(this.url,this.pageName,this.locator,this.requestBody,{Key? key}): super(key: key);

  final String? url;
  final String? pageName;
  final String? locator;
  final Map<String,String> requestBody;

  @override
  State<PaginationListBuilder> createState() => _PaginationListBuilder(url,pageName!,locator!,requestBody!);
  
}

class _PaginationListBuilder extends State<PaginationListBuilder>
{
  final String? url;
  final String pageName;
  final String locator;
  final Map<String,String> requestBody;
  _PaginationListBuilder(this.url, this.pageName, this.locator, this.requestBody)
  {

  }
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  List posts = [];
  int page = 1;

  @override
  void initState()
  {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text(this.pageName)),
      body: ListView.builder(
          padding: EdgeInsets.all(12.0),
          controller: scrollController,
          itemCount: isLoadingMore ? posts.length + 1 : posts.length,
          itemBuilder: (context,index){
            if(index < posts.length)
              {
                var post = posts[index];
                return Card(
                  child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}'),),
                      title: Text(post.toString(),maxLines: 1),
                      //subtitle: Text("Subtitulo teste",maxLines: 2,)
                  ),
                );
              }
            else
              {
                return Center(child: CircularProgressIndicator(),);
              }
      }),
    );
  }

  Future<void> fetchPosts() async{
      //aqui fica a requisição

    Map<String,String> header = new HashMap();

    requestBody.addAll({'pageNumber':page.toString(),'pageSize':"10"});

    final response = await http.doGet(config.host, url!, header, requestBody);

    if(response.statusCode != 200)
    {
      toast.showMessageError("Ocorreu um erro inesperado");
      return;
    }
    final responseJson = json.decode(response.body);
    var code = responseJson['code'];
    if(code != 'SUCCESS') {
      var messageError = responseJson['message'];
      toast.showMessageError(messageError);
      return;
    }

    var content = responseJson[this.locator];

    setState(() {
        posts = posts + content;
    });
  }

  Future<void> _scrollListener() async{
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent)
      {
        setState(() {
          isLoadingMore = true;
        });
        print("chamou a listagem");
        page = page + 1;
        await fetchPosts();
        setState(() {
          isLoadingMore = false;
        });
      }

  }

}