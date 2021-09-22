import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MapUserBadge extends StatelessWidget {
  bool isSelected;
  MapUserBadge({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: this.isSelected ? Colors.green[400] : Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(
                  0.3,
                ),
                blurRadius: 10,
                offset: Offset.zero)
          ]),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(
                    color: this.isSelected ? Colors.white : Colors.green,
                    width: 1),
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: AssetImage('assets/image/me.png'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Erencan Cabuk",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: this.isSelected ? Colors.white : Colors.grey),
              ),
              Text(
                "Izmir / Basmane",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: this.isSelected ? Colors.white : Colors.green,
                    fontSize: 12),
              )
            ],
          )),
          Icon(
            Icons.location_pin,
            color: this.isSelected ? Colors.white : Colors.green,
            size: 40,
          )
        ],
      ),
    );
  }
}
