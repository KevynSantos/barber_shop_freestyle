import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/HttpService.dart' as http;
import '../config.dart' as config;
import '../utils/toast.dart' as toast;

class PaginationListBuilder extends StatefulWidget
{
  PaginationListBuilder(this.url,this.floatingActionButton,this.locator,this.requestBody,this.callBackCard,{Key? key}): super(key: key);

  final String? url;
  final String? locator;
  final Map<String,String> requestBody;
  final Function callBackCard;
  final Widget floatingActionButton;
  late _PaginationListBuilder _stateForRefreash;

  @override
  State<PaginationListBuilder> createState(){
    _stateForRefreash = _PaginationListBuilder(url,floatingActionButton,locator!,requestBody!,callBackCard);
    return _stateForRefreash;
  }

  refrsh(Map<String,String> filter)
  {
    _stateForRefreash.refresh(filter);
  }
  
}

class _PaginationListBuilder extends State<PaginationListBuilder>
{
  final String? url;
  final String locator;
  final Map<String,String> requestBody;
  final Function callBackCard;
  final Widget floatingActionButton;
  _PaginationListBuilder(this.url,this.floatingActionButton, this.locator, this.requestBody, this.callBackCard)
  {

  }
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  List posts = [];
  int page = 1;
  late bool isEmpty = false;
  late bool confirmIsEmpty = false;

  @override
  void initState()
  {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchPosts(this.filter);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff8f9e7),
      body: ListView.builder(
          padding: EdgeInsets.all(12.0),
          controller: scrollController,
          itemCount: isLoadingMore ? posts.length + 1 : posts.length,
          itemBuilder: (context,index){
            if(this.isEmpty == true)
            {
              if(this.confirmIsEmpty == false)
                {
                  this.confirmIsEmpty = true;
                  return Center(child: Text("Não há registros"));
                }
              else {
                return Center();
              }
            }
            if(index < posts.length)
              {
                var post = posts[index];
                return Card(
                  child: callBackCard(index,post),
                );
              }
            else
              {
                return Center(child: CircularProgressIndicator(),);
              }
      }),
        floatingActionButton: floatingActionButton
    );
  }

  Future<void> fetchPosts(Map<String, String> filter) async{
      //aqui fica a requisição

    Map<String,String> header = new HashMap();

    requestBody.addAll({'pageNumber':page.toString(),'pageSize':"10"});
    requestBody.addAll(filter);

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

    count = responseJson['totalElements'];

    List newContent = [];

    newContent.addAll(posts);
    newContent.addAll(content);

    this.confirmIsEmpty = false;

    if(count == 0)
      {
        this.isEmpty = true;
        newContent = [{'isEmpty':'isEmpty'}];
      }
    else
      {
        this.isEmpty = false;
      }

    setState(() {
      posts = newContent;
    });

  }

  late int count = 0;

  late Map<String,String> filter = new HashMap();

  Future<void> _scrollListener() async{
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent)
      {

            setState(() {
              isLoadingMore = true;
            });


        print("chamou a listagem");
        page = page + 1;
        await fetchPosts(this.filter);

          setState(() {
            isLoadingMore = false;
          });

      }

  }

  Future<void> refresh(Map<String, String> filter)
  async {

    if(count>0) {
      setState(() {
        isLoadingMore = true;
      });
    }

    page = 1;
    posts = [];

    this.filter = new HashMap();
    this.filter = filter;

    await fetchPosts(filter);

    if(count>0) {
      setState(() {
        isLoadingMore = false;
      });
    }

  }

}