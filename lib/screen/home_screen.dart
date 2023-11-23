import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_2/data/model_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int i = -1;
  ModelData? modelData;
  List<ModelData> modelDataList = [];
  // var users = List<ModelData>();
 Future< void> getPostCommentData() async{
      var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments"));
      var list = jsonDecode(response.body) as List;
      
      setState(() {
         modelDataList = list.map((n) => ModelData.fromJson(n)).toList() ;
      });
     
    
      print(modelDataList);
       
  }
  @override
  void initState() {
    //  modelDataList.map((e) => getPostCommentData()).toList();
    // print("less $modelDataList");
     getPostCommentData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("P O S T  A N D  C O M M E N T "),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: modelDataList.length,
                itemBuilder: (_, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: IconButton(onPressed: (){
                            //comment show function
                            setState(() {
                              i = index;
                            });
                          
                      }, icon: Icon(Icons.comment, color: Colors.black,)),
                      tileColor: Colors.purple.shade100,
                      title: Text("Post : "+modelDataList[index].id.toString(), style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                  )),
                      subtitle: Text(modelDataList[index].name.toString(),
                      style: TextStyle(
                       color: Colors.black
                  )),
                    ),
                  );
              }),
            )),
            Expanded(
            flex: 1,
            // ignore: unnecessary_null_comparison
            child: i != -1 ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.amber.shade200,
                title: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Post : " + modelDataList[i].id.toString(), style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("COMMENT : " + modelDataList[i].body.toString(), style: TextStyle(
                    fontSize: 12,color: Colors.black
                  ),),
                ),
              ),
            ): ListTile(title: Text('No comment'),))
        ],
      ),
    );
  }
}