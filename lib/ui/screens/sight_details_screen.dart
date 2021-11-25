import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(Sight this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(top: 16),
          alignment: Alignment.topCenter,
          child: Container(
            height: 32,
            width: 32,
            // margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '<',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 360,
                  color: Colors.blue.shade300,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      sight.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3B3E5B),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      children: [
                        Text(
                          sight.type,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3B3E5B),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Закрыто до 09:00',
                            style: TextStyle(
                              color: Color(0xFF7C7E92),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (sight.details.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        sight.details,
                        style: TextStyle(color: Color(0xFF3B3E5B)),
                      ),
                    ),
                  // button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                        minHeight: 48,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFF4CAF50),
                      ),
                      child: Text(
                        'Построить маршрут'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Divider(
                      height: 0.8,
                      color: Color.fromRGBO(124, 126, 146, 0.24),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Center(
                            child: Row(
                              children: [
                                // icon
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  color: Colors.red.shade100,
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  'Запланировать',
                                  style: TextStyle(
                                    color: Color.fromRGBO(124, 126, 146, .56),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Center(
                            child: Row(
                              children: [
                                // icon
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  color: Colors.red,
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  'В Избранное',
                                  style: TextStyle(
                                    color: Color(0xFF3B3E5B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
