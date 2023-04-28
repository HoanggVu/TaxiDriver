import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxibookingdriver/global/global.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");

  Future<void> showUserNameDialogAlert(BuildContext context, String name){

    nameController.text = name;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Cập Nhật"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Quay Lại", style: TextStyle(color: Colors.redAccent),)
              ),

              TextButton(
                  onPressed: () {
                    userRef.child(firebaseAuth.currentUser!.uid).update({
                      "name" : nameController.text.trim(),
                    }).then((value){
                      nameController.clear();
                      Fluttertoast.showToast(msg: "Update Successfully. \n Reload the app to see the changes");
                    }).catchError((errorMessage) {
                      Fluttertoast.showToast(msg: "Error Occurred. \n $errorMessage");
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Xác Nhận", style: TextStyle(color: Colors.black),)
              ),
            ],
          );
        }
    );
  }

  Future<void> showUserPhoneDialogAlert(BuildContext context, String phone){

    phoneController.text = phone;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Cập Nhật"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: phoneController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Quay Lại", style: TextStyle(color: Colors.redAccent),)
              ),

              TextButton(
                  onPressed: () {
                    userRef.child(firebaseAuth.currentUser!.uid).update({
                      "phone" : phoneController.text.trim(),
                    }).then((value){
                      phoneController.clear();
                      Fluttertoast.showToast(msg: "Update Successfully. \n Reload the app to see the changes");
                    }).catchError((errorMessage) {
                      Fluttertoast.showToast(msg: "Error Occurred. \n $errorMessage");
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Xác Nhận", style: TextStyle(color: Colors.black),)
              ),
            ],
          );
        }
    );
  }

  Future<void> showUserAddressDialogAlert(BuildContext context, String address){

    addressController.text = address;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Cập Nhật"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: addressController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Quay Lại", style: TextStyle(color: Colors.redAccent),)
              ),

              TextButton(
                  onPressed: () {
                    userRef.child(firebaseAuth.currentUser!.uid).update({
                      "address" : addressController.text.trim(),
                    }).then((value){
                      addressController.clear();
                      Fluttertoast.showToast(msg: "Update Successfully. \n Reload the app to see the changes");
                    }).catchError((errorMessage) {
                      Fluttertoast.showToast(msg: "Error Occurred. \n $errorMessage");
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Xác Nhận", style: TextStyle(color: Colors.black),)
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text("Thông Tin Cá Nhân", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, color: Colors.white,),
                ),

                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${userModelCurrentInfo!.name!}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                        onPressed: () {
                          showUserNameDialogAlert(context, userModelCurrentInfo!.name!);
                        },
                        icon: Icon(
                          Icons.edit,
                        )
                    )
                  ],
                ),

                Divider(
                  thickness: 1,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${userModelCurrentInfo!.phone!}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                        onPressed: () {
                          showUserPhoneDialogAlert(context, userModelCurrentInfo!.phone!);
                        },
                        icon: Icon(
                          Icons.edit,
                        )
                    )
                  ],
                ),

                Divider(
                  thickness: 1,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${userModelCurrentInfo!.address!}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                        onPressed: () {
                          showUserAddressDialogAlert(context, userModelCurrentInfo!.address!);
                        },
                        icon: Icon(
                          Icons.edit,
                        )
                    )
                  ],
                ),
                Divider(
                  thickness: 1,
                ),

                Text(
                  "${userModelCurrentInfo!.email!}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
