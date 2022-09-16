import 'dart:convert';

import 'package:demo/insert_page/insert_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/Model.dart';
import '../update_page/update_page.dart';

class view_page extends StatefulWidget {
  const view_page({Key? key}) : super(key: key);

  @override
  State<view_page> createState() => _view_pageState();
}

class _view_pageState extends State<view_page> {


  @override
  void initState() {

    super.initState();

    loadData();
  }

  bool status = false;
  Future<void> loadData()
  async {
    var url = Uri.parse('http://workfordemo.in/bunch2/get_product.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
   // print('Response body: ${response.body}');


    Map m = jsonDecode(response.body);
    int success  = m['success'];
    if(success==1)
      {
        Model.l = m['product_list'];
      }

    print(Model.l);
    status=true;
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("ALL PRODUCT"),
        centerTitle: true,
      ),
      body: (status) ?  ( Model.l.isNotEmpty ? ListView.builder(physics: BouncingScrollPhysics(),itemCount: Model.l.length,itemBuilder: (context, index) {
        Map m = Model.l[index];
        User user = User.fromJson(m);
        return RawScrollbar(
          thumbColor: Colors.brown,
          child: Card(
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product ID : ${user.prodId}"),
                Text("Selecte Category : ${user.catName}"),
                Text("Name : ${user.prodName}"),
                Text("MRP : ${user.prodMrp}"),
                Text("Decription : ${user.prodDescription}"),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return update_page(
                      user.prodId,user.catId,user.prodName,user.prodMrp,user.prodDescription
                    );
                  },));
                }, child: Text("Update"),style: ElevatedButton.styleFrom(primary: Colors.brown),),
              ),
            ],
            ),
          ),
        );
      },) : Center(child: Text("NO DATA FOUND"),)):Center(child: CircularProgressIndicator(color: Colors.brown,)),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.brown,child: Icon(Icons.navigate_next),onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return insert_page();
        },));
      },),
    );
  }
}

class User {
  String? prodId;
  String? prodName;
  String? catId;
  String? catName;
  String? prodMrp;
  String? prodDescription;
  String? prodCreated;

  User(
      {this.prodId,
        this.prodName,
        this.catId,
        this.catName,
        this.prodMrp,
        this.prodDescription,
        this.prodCreated});

  User.fromJson(Map json) {
    prodId = json['prod_id'];
    prodName = json['prod_name'];
    catId = json['cat_id'];
    catName = json['cat_name'];
    prodMrp = json['prod_mrp'];
    prodDescription = json['prod_description'];
    prodCreated = json['prod_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prod_id'] = this.prodId;
    data['prod_name'] = this.prodName;
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['prod_mrp'] = this.prodMrp;
    data['prod_description'] = this.prodDescription;
    data['prod_created'] = this.prodCreated;
    return data;
  }
  
}
