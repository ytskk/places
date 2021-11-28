import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  const SightCard(Sight this.sight, {Key? key}) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              // photo
              Container(
                color: Colors.blue.shade300,
                height: 96,
              ),
              // text + action buttons
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sight.type,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // сделал на будущее, чтобы можно было добавить ещё кнопок (как actions у Appbar)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          color: Colors.red.shade400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            constraints: BoxConstraints(minWidth: double.infinity),
            padding: EdgeInsets.all(16),
            color: Color(0xFFF5F5F5),
            // Придумал только такой способ, чтобы Column занимал ровно половину места, правда, в таком случае, ConstrainedBox не требуется.
            //Или здесь имеется ввиду задать какое-то ограничение, например, в 100?
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sight.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3B3E5B),
                          ),
                        ),
                        if (sight.details.length > 0)
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              sight.details,
                              style: TextStyle(
                                color: Color(0xFF7C7E92),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
