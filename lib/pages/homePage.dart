import 'package:flutter/material.dart';
import 'package:project_sirac/models/userModel.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:project_sirac/pages/userInformationPage.dart';
import 'package:project_sirac/services/userServices.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
   super.initState();
  }
  String? name;
  bool filtered=false; ///filtreleme uygulanıp uygulanmadığını kontrol eden ternary operatörünün bool değişkeni.
   List<UserModel>? filteredUserList;
  late List<UserModel> userModelList;
  String? country;
  String? city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003749),
        leadingWidth: MediaQuery.of(context).size.width,
        title:  Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    width: MediaQuery.of(context).size.width*0.75,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:Center(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'İsim Giriniz...',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                          onChanged: (value) {
                          setState(() {
                          name = value;
                          filteredUserList=filteringUsersFullname(userModelList, name!);
                          filtered=true;
                          });}
                      ),
                    ),
                    ),
                ],
              ),
            ),
            Icon(Icons.search,size: MediaQuery.of(context).size.height*0.06),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CountryStatePicker(/// Ülke ve şehirleri içerisinde barındıran liste eklentisi.
              onCountryChanged: (ct) => setState(() {
                country = ct;
                city = null;
                filteredUserList=filteringUsersCountry(userModelList, country!);
                filtered=true;
              }),
              onStateChanged: (st) => setState(() {
                city = st;
                filteredUserList=filteringUsersCity(filteredUserList!, city!);
              }),
            ),

        Divider(),
        FutureBuilder(
            future: getUsers(),
            builder: (context, AsyncSnapshot snap) {
              if(!snap.hasData){
                return CircularProgressIndicator();
              }
              else{
                userModelList=snap.data;

                return filtered ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredUserList!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height*0.125,
                      padding:EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:Border(
                          top: BorderSide(width: 1),
                        ),
                      ),
                      child: InkWell(
                        child: Row(
                          children: [
                            Padding(
                              padding:EdgeInsets.only(right: 12),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                width: MediaQuery.of(context).size.height*0.08,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage("${filteredUserList![index].avatar}")),
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),//Profil Fotoğrafı
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(width: MediaQuery.of(context).size.width*0.3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${filteredUserList![index].fullName}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black87),),
                                        Text("${filteredUserList![index].jobTitle}",style: TextStyle(overflow: TextOverflow.ellipsis,color: Colors.black45),),
                                      ],),
                                  ),
                                  Container(width: MediaQuery.of(context).size.width*0.3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${filteredUserList![index].countryName}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black87),),
                                        Text("${filteredUserList![index].cityName}",style: TextStyle(color: Colors.black45),),
                                      ],),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserInformationPage(user: filteredUserList![index],),));
                        },
                      ),
                    );
                  },
                ): ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snap.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height*0.125,
                    padding:EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:Border(
                        top: BorderSide(width: 1),
                      ),
                    ),
                    child: InkWell(
                      child: Row(
                        children: [
                          Padding(
                            padding:EdgeInsets.only(right: 12),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.08,
                              width:MediaQuery.of(context).size.height*0.08,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("${userModelList[index].avatar}")),
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),//Profil Fotoğrafı
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(width: MediaQuery.of(context).size.width*0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${userModelList[index].fullName}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black87),),
                                      Text("${userModelList[index].jobTitle}",style: TextStyle(overflow: TextOverflow.ellipsis,color: Colors.black45),),
                                    ],),
                                ),
                                Container(width: MediaQuery.of(context).size.width*0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${userModelList[index].countryName}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black87),),
                                      Text("${userModelList[index].cityName}",style: TextStyle(color: Colors.black45),),
                                    ],),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserInformationPage(user: userModelList[index],),));
                      },
                    ),
                  );
                },
              );
              }
            } ,),



          ],
        ),
      ),
    );
  }
}



