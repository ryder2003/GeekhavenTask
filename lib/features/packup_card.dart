import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../api/apis.dart';

class PackupListCard extends StatefulWidget{
  const PackupListCard({
    super.key,
    required this.carryItem,
    required this.isPacked,
    required this.onChanged,
    required this.deleteFunction,
  });

  final String carryItem;
  final bool isPacked;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  State<PackupListCard> createState() => _PackupListCardState();
}

class _PackupListCardState extends State<PackupListCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20,bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: widget.deleteFunction,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(15),
                  backgroundColor: Colors.grey.shade200,

              )
           ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: APIs.hexToColor("#ffe6cc"),
              borderRadius: BorderRadius.circular(15)
          ),
          padding: EdgeInsets.all(12),
          //color: ,
          child: Row(
            children: [
              Checkbox(
                value: widget.isPacked,
                onChanged: widget.onChanged,
                checkColor: Colors.lightBlue,
                activeColor: Colors.white,
                side: BorderSide(color: Colors.grey.shade900),
        
              ),
        
              Text(
                widget.carryItem,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  decoration: widget.isPacked ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: Colors.grey.shade600   ,
                  decorationThickness: 2.5
        
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}