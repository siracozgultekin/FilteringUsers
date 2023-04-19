import 'package:flutter/material.dart';
import '../models/userModel.dart';

class UserInformationPage extends StatefulWidget {
  late UserModel user;
UserInformationPage({required this.user});

  @override
  State<UserInformationPage> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003749),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            color: Color(0xFF8CA4AC), // Container'ın arkaplanını gri yapıyoruz.
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("${widget.user.avatar}")),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${widget.user.fullName}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 20),),
                    Text("${widget.user.jobTitle}",style: TextStyle(overflow: TextOverflow.ellipsis,color: Colors.black45,fontSize: 20),),
                  ],),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,20,15,20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.45,
                      child: Column(
                        children: [
                          Text("Country",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 20),),
                          Text("${widget.user.countryName}",style: TextStyle(color: Colors.black45,fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.45,
                      child: Column(
                        children: [
                          Text("City",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 20),),
                          Text("${widget.user.cityName}",style: TextStyle(color: Colors.black45,fontSize: 20),),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ), ]
      ),

    );
  }
}
