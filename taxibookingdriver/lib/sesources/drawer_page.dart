import 'package:flutter/material.dart';
import 'package:taxibookingdriver/global/global.dart';
import 'package:taxibookingdriver/sesources/profile_page.dart';
import 'package:taxibookingdriver/splashpage/splash_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 20,),

                  Text(
                    userModelCurrentInfo!.name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: 10,),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => ProfilePage()));
                    },
                    child: Text(
                      "Chỉnh Sửa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),

                  Text("Chuyến Đi", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

                  SizedBox(height: 15,),

                  Text("Thanh Toán", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

                  SizedBox(height: 15,),

                  Text("Thông Báo", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

                  SizedBox(height: 15,),

                  Text("Khuyến Mãi", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

                  SizedBox(height: 15,),

                  Text("Trợ Giúp", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

                  SizedBox(height: 15,),
                ],
              ),

              GestureDetector(
                onTap: () {
                  firebaseAuth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (c) => SplashPage()));
                },
                child: Text(
                  "Đăng Xuất",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.redAccent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
