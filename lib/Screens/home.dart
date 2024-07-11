import 'package:flutter/material.dart';
import 'package:register_with_course_sqflite/Database_sqflite/dataBase.dart';

class Home extends StatefulWidget {

  const Home({super.key, });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data;
  void delete(int id)async{
    await SqflDataBase.deleteUser(id);
    Refresh();

  }
  @override
  void initState() {
    Refresh();
    super.initState();
  }

  void Refresh()async{
    var mydata=await SqflDataBase.getAll();
    setState(() {
      data=mydata;
    });
  }
  @override
  Widget build(BuildContext context) {

    var name=data[0]['name'];
    var course=data[0]['course'];
    var gender=data[0]['gender'];

    return Scaffold(
appBar: AppBar(title: Text("$name"),),
    body: ListView.builder(itemCount:data.length,itemBuilder: (context,int index){
      return Card(
        child: ListTile(
          title: Text('${data[index]['name']}'),
          subtitle: Column(
            children: [
              Text('${data[index]['course']}'),
              Text('${data[index]['name']}'),
            ],
          ),
        ),
      );
    }),
      );


  }
}
