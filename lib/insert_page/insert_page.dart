

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class insert_page extends StatefulWidget {
  const insert_page({Key? key}) : super(key: key);

  @override
  State<insert_page> createState() => _insert_pageState();
}

class _insert_pageState extends State<insert_page> {


  TextEditingController tcategory = TextEditingController();
  TextEditingController tname = TextEditingController();
  TextEditingController tmrp = TextEditingController();
  TextEditingController tdicription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("Selecte Category",style: const TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder(),suffixIcon: Icon(Icons.arrow_downward,color: Colors.black,),),
                  controller: tcategory,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("Name",style: const TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: tname,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("MRP",style: const TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: tmrp,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("Description",style: const TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 5 * 20,
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: tdicription,
                  ),
                ),
              ),

              Container(
                height: 50,
                alignment: Alignment.center,
                child: ElevatedButton(onPressed: () async {
                  String category = tcategory.text;
                  String name = tname.text;
                  String mrp = tmrp.text;
                  String decription = tdicription.text;

                  var url = Uri.parse('http://workfordemo.in/bunch2/insert_product.php?cat_id=1&prod_name=$name&prod_mrp=$mrp&prod_description=$decription');
                  var response = await http.get(url);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');

                  Navigator.pop(context);

                }, child: const Text("Submit"),style: ElevatedButton.styleFrom(
                  primary: Colors.brown,
                ),),
              )
            ],

          ),
        ),
      ),
    );
  }
}
