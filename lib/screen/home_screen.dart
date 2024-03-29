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

  List<ModelData> modelDataList = [];
  Future< void> getPostCommentData() async{
      var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments"));
      if(response.statusCode == 200){
          var list = jsonDecode(response.body) as List;
        setState(() {
         modelDataList = list.map((n) => ModelData.fromJson(n)).toList() ;
        });
      }
      
     
    
      debugPrint(modelDataList.toString());
       
  }
  @override
  void initState() {
    getPostCommentData();
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
                        
                    }, icon: const Icon(Icons.comment, color: Colors.black,)),
                    tileColor: Colors.purple.shade100,
                    title: Text("Post : ${modelDataList[index].id}", style: const TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20
                )),
                    subtitle: Text(modelDataList[index].name.toString(),
                    style: const TextStyle(
                     color: Colors.black
                )),
                  ),
                );
            })),
            Expanded(
            flex: 1,
            // ignore: unnecessary_null_comparison
            child: i != -1 ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.amber.shade200,
                title: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Post : ${modelDataList[i].id}", style: const TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("COMMENT : ${modelDataList[i].body}", style: const TextStyle(
                    fontSize: 12,color: Colors.black
                  ),),
                ),
              ),
            ): const ListTile(title: Text('No comment'),))
        ],
      ),
    );
  }
}