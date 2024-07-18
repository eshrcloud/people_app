import 'package:flutter/material.dart';

class LeaveBar extends StatelessWidget {
  final String label;
  final double total;
  final double taken;
  final double balance;
  LeaveBar(this.label,this.total,this.taken,this.balance);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text("${taken.toStringAsFixed(0)} / ${total.toStringAsFixed(0)}")),
        SizedBox(height: 4,),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.grey,width: 10,),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: balance,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4,),
        Text(label,
          style: TextStyle(
          fontFamily: "NexaRegular",
          fontSize: 13,
          color: Colors.black,
        ),),
      ],
    );
  }
}
