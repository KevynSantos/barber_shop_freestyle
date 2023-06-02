import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginationListBuilder extends StatefulWidget
{
  const PaginationListBuilder({Key? key}): super(key: key);

  @override
  State<PaginationListBuilder> createState() => _PaginationListBuilder();
  
}

class _PaginationListBuilder extends State<PaginationListBuilder>
{
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
      appBar: AppBar(title: Text("Paginação exemplo")),
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
                      subtitle: Text("Subtitulo teste",maxLines: 2,)
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

    var url = '$page';

    print('$url');

    var jsonExample = [{"cities":["New York","Bangalore","San Francisco"],"name":"Pankaj Kumar","age":32}];

    setState(() {
        posts = posts + jsonExample;
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