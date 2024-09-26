import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

import '../database.dart';
import 'employee.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontro = new TextEditingController();
  TextEditingController agecontro = new TextEditingController();
  TextEditingController locationcontro = new TextEditingController();

  Stream? EmployeeStream;
  getontheload() async{
    EmployeeStream = await database().getemployeedetails();

    setState(() {

    });
  }
  @override
  void initState() {
   getontheload();
    super.initState();

  }
  Widget allemployeeDetails(){
    return StreamBuilder(
        stream: EmployeeStream,

      builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData?ListView.builder(
        itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
          DocumentSnapshot ds=snapshot.data.docs[index];
          return     Container(
            margin: EdgeInsets.all(8),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 5.0,
              child: Container(
                
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,

                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      offset: Offset(4, 4), // Shadow offset
                      blurRadius: 8, // Blur radius
                      spreadRadius: 2, // Spread radius
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Expanded(child: Text("Day:  "+ds["name"],style: TextStyle(fontSize: 20),),),
                        // SizedBox(width: 180),
                        // Spacer(),
                      InkWell(child: Icon(Icons.edit,color: Colors.green,),
                        onTap: (){
                        namecontro.text=ds["name"];
                        agecontro.text=ds["age"];
                        locationcontro.text=ds["location"];
                        Editdetails(ds["IDd"]);
                        },
                      ),
                        SizedBox(width: 2,),
                        InkWell(child: Icon(Icons.delete,color: Colors.red,),
                          onTap: () async {
                            await database().deletedetails(ds["IDd"]).then((value){
                              // Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Note Has been Deleted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            });

                          },
                        ),

                      ],
                    ),
                    Text("Amount:  "+ds["age"],style: TextStyle(fontSize: 20),),
                   Row(
                     children: [
                       Expanded(child:  Text("Descrption:  "+ds["location"],style: TextStyle(fontSize: 20)),),
                     ],
                   )
                  ],
                ),
              ),
            ),
          );
          }):Container();

    }, );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          namecontro.clear();
          agecontro.clear();
          locationcontro.clear();
           showDialog(context: context, builder: (context) => AlertDialog(
             content: Padding(
               padding: EdgeInsets.all(16.0),
               child: Form(
                 key: _formKey,
                 child:SingleChildScrollView(
                   scrollDirection: Axis.vertical,
                   child:  Column(
                     children: <Widget>[
                       Row(children: [
                         GestureDetector(
                             onTap: (){
                               Navigator.pop(context);
                             },
                             child:  Icon(Icons.cancel)
                         ),
                         SizedBox(width: 20,),
                         Text('Add Note' ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                       ],),
                       SizedBox(height: 20,),
                       Padding(padding: EdgeInsets.all(11),
                         child: TextFormField(
                           controller: namecontro,
                           decoration: InputDecoration(
                             labelText: 'Day',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.blue, width: 2.0),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.grey, width: 1.0),
                             ),
                           ),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter Day';
                             }
                             return null;
                           },
                           onChanged: (value) {

                           },
                         ),),
                       Padding(padding: EdgeInsets.all(11),
                         child: TextFormField(
                           controller: agecontro,
                           decoration: InputDecoration(
                             labelText: 'Amount',
                             border: OutlineInputBorder(),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.blue, width: 2.0),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.grey, width: 1.0),
                             ),
                           ),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter Amount';
                             }
                             return null;
                           },
                           onChanged: (value) {

                           },
                         ),),
                       Padding(padding: EdgeInsets.all(11),
                         child: TextFormField(
                           controller: locationcontro,
                           decoration: InputDecoration(

                             labelText: 'Description',
                             border: OutlineInputBorder(),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.blue, width: 2.0),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.grey, width: 1.0),
                             ),
                           ),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter Description';
                             }
                             return null;
                           },
                           onChanged: (value) {

                           },
                         ),),

                       SizedBox(height: 20),
                       ElevatedButton(
                         onPressed: () async {

                           if (_formKey.currentState!.validate()) {
                             String id=randomAlphaNumeric(10);
                             Map<String, dynamic> employeemapid = {
                               "name": namecontro.text,
                               "age": agecontro.text,
                               "IDd":id,
                               "location": locationcontro.text, // Make sure to use .text for TextEditingController
                             };
                             await database().addemployee(employeemapid,id).then((value){
                               Navigator.pop(context);
                               Fluttertoast.showToast(
                                   msg: "Note Succesfully Added",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.BOTTOM,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.green,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             });


                           }
                         },
                         child: Text('Add Note'),
                       ),
                     ],
                   ),
                 )
               ),
             ),
           ),);
        },
          child: Icon(Icons.add),),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.grey,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: AppBar(
              title: Text('Note',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
              centerTitle: true,
              backgroundColor: Colors.transparent, // Set to transparent
              elevation: 0, // Remove shadow
            ),
          ),
        ),
body: Container(
  height: double.infinity,
  width: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.white,
        Colors.blue,

      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),

  ),
  // margin: EdgeInsets.only(left: 10,right: 10,top: 10),
  child: Column(
    children: [
      Expanded(child: allemployeeDetails()),

    ],
  ),
),
      ),
    );
  }
  Future Editdetails(String id)=>showModalBottomSheet(context: context, builder: (context) => AlertDialog(
    content: Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(children: [
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child:  Icon(Icons.cancel)
              ),
              SizedBox(width: 50,),
              Text('Edit Note' ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

            ],),
            Padding(padding: EdgeInsets.all(11),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: namecontro,
                decoration: InputDecoration(
                  labelText: 'Day',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),

                onChanged: (value) {

                },
              ),),
            Padding(padding: EdgeInsets.all(11),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: agecontro,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),

                onChanged: (value) {

                },
              ),),
            Padding(padding: EdgeInsets.all(11),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: locationcontro,
                decoration: InputDecoration(

                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),

                onChanged: (value) {

                },
              ),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () async{
                  Map<String, dynamic> Updateinfo = {
                    "name": namecontro.text,
                    "age": agecontro.text,
                    "IDd":id,
                    "location": locationcontro.text, // Make sure to use .text for TextEditingController
                  };
                  await database().addemployee(Updateinfo,id).then((value){
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "Updated Succesfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  });
                }, child: Text('Update')),
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);

                }, child: Text('Cancel'))
              ],
            )


          ],
        ),
      )
    ),
  ));



  }

