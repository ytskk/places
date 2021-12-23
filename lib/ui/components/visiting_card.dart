import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/domain/sight.dart';

/// Model for sight card in visiting screen
class VisitingCard extends StatelessWidget {
  /// [actions] - List of buttons.
  ///
  /// [scheduledAt] - Depends on [isVisited]
  const VisitingCard(
    Sight this.sight, {
    Key? key,
    this.actions = const [],
    this.scheduledAt = '',
    this.workingStatus = '',
    this.isVisited = false,
  }) : super(key: key);

  final Sight sight;
  final List<Widget> actions;
  final String scheduledAt;
  final String workingStatus;
  final bool isVisited;

  @override
  Widget build(BuildContext context) {
    Color scheduledAtColor =
        isVisited ? AppColors.whiteInactiveBlack : AppColors.green;

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        for (var action in actions)
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: action,
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
                if (scheduledAt.length > 0)
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      scheduledAt,
                      style: TextStyle(
                        color: scheduledAtColor,
                      ),
                    ),
                  ),
                if (workingStatus.length > 0)
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      workingStatus,
                      style: TextStyle(
                        color: AppColors.whiteInactiveBlack,
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
