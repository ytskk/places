import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_strings.dart';
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
                  // color: Colors.blue.shade300,
                  child: Stack(
                    // нашёл только такой способ наложения градиента на изображение, правда есть ещё ShaderMask
                    // подскажите, пожалуйста, как лучше было бы реализовать данный момент?
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        sight.url,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Center(
                            child: CupertinoActivityIndicator.partiallyRevealed(
                              progress:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : 1,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.blue,
                          );
                        },
                      ),
                      Opacity(
                        opacity: 0.4,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff252849),
                                Color.fromRGBO(59, 62, 91, 0.08),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                            // temp
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
                        AppStrings.sightDetailsGetDirections.toUpperCase(),
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
                                Opacity(
                                  opacity: 0.4,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(
                                          'assets/icons/calendar.png',
                                          color: Color(0xff3b3e5b),
                                        ),
                                      ),
                                      Text(
                                        AppStrings.sightDetailsSchedule,
                                        style: TextStyle(
                                          color: Color(0xff3b3e5b),
                                        ),
                                      ),
                                    ],
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
                                  // color: Colors.red,
                                  width: 24,
                                  height: 24,
                                  child: Image.asset(
                                    'assets/icons/heart.png',
                                    color: Color(0xff3b3e5b),
                                  ),
                                ),
                                Text(
                                  AppStrings.sightDetailsAddToWishlist,
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
