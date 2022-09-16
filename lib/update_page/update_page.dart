import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../view_page/view_page.dart';
class update_page extends StatefulWidget {
  String? prodId;
  String? catId;
  String? prodName;
  String? prodMrp;
  String? prodDescription;
  update_page(this. prodId, this. catId, this. prodName, this. prodMrp, this. prodDescription);
  @override
  State<update_page> createState() => _update_pageState();
}

class _update_pageState extends State<update_page> {


  TextEditingController tcategory = TextEditingController();
  TextEditingController tname = TextEditingController();
  TextEditingController tmrp = TextEditingController();
  TextEditingController tdicription = TextEditingController();
  @override
  void initState() {
    super.initState();

    tcategory.text = "Fruits";
    tname.text = widget.prodName!;
    tmrp.text = widget.prodMrp!;
    tdicription.text = widget.prodDescription!;


    print(widget.prodId);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text("EDIT PRODUCT"),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
            return view_page();
          },));
        }, icon: Icon(Icons.arrow_back)),
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
                child: Text("Selecte Category : ",style: const TextStyle(
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

                  var url = Uri.parse('http://workfordemo.in/bunch2/insert_product.php?cat_id=${widget.catId}&prod_name=$name&prod_mrp=${mrp.splitMapJoin('.00')}&prod_description=$decription');
                  var response = await http.get(url);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');

                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                    return view_page();
                  },));

                }, child: const Text("Update"),style: ElevatedButton.styleFrom(
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
