import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class SwipableCard extends StatefulWidget {
  @override
  _SwipableCardState createState() => _SwipableCardState();
}

class _SwipableCardState extends State<SwipableCard> {
  double opacity = 0.0;
  bool _isLiked;
  int _currentIndex = 0;

  CardController cardController = CardController();

  Widget likeDislikeOverImg({
    IconData icon,
    Color color,
    double opacity,
  }) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 200),
      child: Icon(
        icon ?? Icons.clear,
        size: 48,
        color: color ?? Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            profiles.add('user');
          });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1.4,
                    height: MediaQuery.of(context).size.height * 0.88,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TinderSwapCard(
                      swipeUpdateCallback: (details, align) {
                        if (align.x < 0) {
                          //Card is LEFT swiping
                          if (align.x < -3) {
                            _isLiked = false;
                          }
                          if (-(align.x * 0.1) > 1) {
                            opacity = 1;
                          } else {
                            opacity = -(align.x * 0.1);
                          }
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                          if (align.x > 3) {
                            _isLiked = true;
                          }
                          if ((align.x * 0.1) > 1) {
                            opacity = 1;
                          } else {
                            opacity = (align.x * 0.1);
                          }
                        } else {
                          opacity = 0;
                        }
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) {
                        print(
                            'orientation is $orientation and index is $index');
                        if (orientation == CardSwipeOrientation.LEFT ||
                            orientation == CardSwipeOrientation.RIGHT) {
                          setState(() {
                            _currentIndex = index + 1;
                          });
                          // _pageController.jumpToPage(0);
                        }

                        if (orientation == CardSwipeOrientation.LEFT) {
                          setState(() {
                            // to do --> remove specific user on left swipe through controller
                            profiles = profiles;
                          });
                        }
                        _isLiked = null;
                      },
                      orientation: AmassOrientation.BOTTOM,
                      maxHeight: MediaQuery.of(context).size.height * 0.85,
                      minHeight: MediaQuery.of(context).size.height * 0.7,
                      maxWidth: MediaQuery.of(context).size.width,
                      minWidth: MediaQuery.of(context).size.width * 0.84,
                      stackNum: 4,
                      swipeEdge: 6.0,
                      totalNum: profiles.length,
                      cardController: cardController,
                      cardBuilder: (context, index) {
                        return Stack(
                          children: [
                            Stack(
                              children: List.from(
                                profiles.map(
                                  (e) => cardBuilder(
                                    context,
                                    child: Center(
                                      child: Text(e),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              top: 60,
                              child: _isLiked != null &&
                                      _isLiked == true &&
                                      index == _currentIndex
                                  ? likeDislikeOverImg(
                                      opacity: opacity,
                                      color: Colors.green,
                                      icon: Icons.verified,
                                    )
                                  : Container(),
                            ),
                            Positioned(
                              right: 30,
                              top: 60,
                              child: _isLiked != null &&
                                      _isLiked == false &&
                                      index == _currentIndex
                                  ? likeDislikeOverImg(
                                      opacity: opacity,
                                      color: Colors.red,
                                    )
                                  : Container(),
                            ),
                          ],
                        );
                      },
                    ),
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

// slidable img card
Widget cardBuilder(BuildContext context, {Widget child}) {
  final size = MediaQuery.of(context).size.width;

  return Container(
    width: size,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.blueGrey,
    ),
    child: child,
  );
}

List<String> profiles = [
  'ram',
  'shyam',
  'Ravi',
  'Peeter',
  'Hary',
];
