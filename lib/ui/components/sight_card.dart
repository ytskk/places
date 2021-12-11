import 'package:flutter/cupertino.dart';
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
                height: 96,
                width: double.infinity,
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
                            progress: loadingProgress.expectedTotalBytes != null
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
                          // color: Colors.red.shade400,
                          child: Image.asset(
                            'assets/icons/heart.png',
                            fit: BoxFit.contain,
                          ),
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
        ],
      ),
    );
  }
}
