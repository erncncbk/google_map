import 'package:flutter/material.dart';

class MapBottomPill extends StatelessWidget {
  const MapBottomPill({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset.zero)
          ]),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/image/burger_house.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                        bottom: -5,
                        right: -5,
                        child: Icon(
                          Icons.gps_fixed_sharp,
                          color: Colors.black,
                        ))
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mehmet Burger House",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "by exclusive cheff",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "1km distance",
                        style: TextStyle(
                          color: Color(0xFF08A5C8),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.location_pin, color: Colors.red[900], size: 40)
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                        image: AssetImage('assets/image/cheff.jpeg'),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.red, width: 2)),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mehmet Cheff",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Izmir / Basmane",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Anafartalar street",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
