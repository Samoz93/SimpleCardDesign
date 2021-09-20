import 'dart:math';

import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

const _letterSize = 30.0;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SimpleCard(),
    );
  }
}

class SimpleCard extends StatefulWidget {
  const SimpleCard({Key? key}) : super(key: key);

  @override
  _SimpleCardState createState() => _SimpleCardState();
}

class _SimpleCardState extends State<SimpleCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.4;
    final width = size.width * 0.9;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.grey.withOpacity(
                  0.3,
                ),
                width: 1),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0,
                    2,
                  )),
            ],
          ),
          height: height,
          width: width,
          padding: EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Row(
                children: [
                  _letterCircle(letter: "d", color: Colors.green),
                  _letterCircle(letter: "f", color: Colors.red),
                  _letterCircle(letter: "b", color: Colors.purple),
                  Spacer(),
                  _customChip(
                    icon: Icons.access_time,
                    label: "10.8/10",
                    color: Colors.orange,
                  ),
                  SizedBox(width: 5),
                  _customChip(
                    icon: Icons.timer,
                    label: "28 Jul",
                    bkColor: Colors.indigo[900],
                    hasBorder: false,
                  ),
                ],
              )),
              Flexible(
                flex: 2,
                child: Text(
                  "Favicon.ico & icons for Wekan,Zulip ATS,Learn,Inovices",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.network(
                        "https://drsamoz.com/static/83e5caf79c7cbb4c29acf3cea6e631a0/3429a/apex2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _avatarWidget),
                    _badgeWidget(icon: Icons.sort, label: "1"),
                    _badgeWidget(icon: Icons.attach_file, label: "3"),
                    _badgeWidget(icon: Icons.done_rounded, label: "2/16"),
                    _badgeWidget(icon: Icons.comment, label: "1"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final users = [
    UserModel(
        id: 1,
        url:
            "https://pbs.twimg.com/profile_images/1055263632861343745/vIqzOHXj.jpg"),
    UserModel(
        id: 2,
        url:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4cHOgdhu9uClu4pE_QdyG6BGvyboCfbM5taGejypcMMzaVHM7oqR0guFI7Z58ta0o8do&usqp=CAU"),
    UserModel(
        id: 3,
        url:
            "https://pbs.twimg.com/profile_images/1165754931791314945/FRdmYcK0.jpg"),
  ];

  Widget get _avatarWidget {
    return LayoutBuilder(builder: (context, cs) {
      final dynamicOffset =
          min(cs.maxWidth / users.length - 1, cs.maxWidth * 0.1);

      return Indexer(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ...users.map((e) {
            final itemIndex = users.indexOf(e) + 1;
            return Indexed(
              index: users.length - itemIndex,
              child: Positioned(
                left: itemIndex * dynamicOffset,
                child: _avatarImg(
                  url: e.url,
                  id: e.id,
                ),
              ),
            );
          }),
          //The Add button
          Indexed(
            index: users.length + 1,
            child: Positioned(
              left: 0,
              child: _avatarImg(),
            ),
          ),
        ],
      );
    });
  }

  Widget _letterCircle({required String letter, Color? color}) {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color?.withOpacity(0.3)),
      height: _letterSize,
      width: _letterSize,
      margin: EdgeInsets.only(right: 3),
      child: Center(
          child: Text(
        letter.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }

  Widget _badgeWidget({
    required IconData icon,
    required String label,
  }) {
    final color = Colors.grey.withOpacity(0.8);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
            ),
          )
        ],
      ),
    );
  }

  Widget _customChip(
      {required IconData icon,
      required String label,
      Color? color,
      Color? bkColor,
      bool hasBorder = true}) {
    return Chip(
      label: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          Text(
            label,
            style: TextStyle(
              color: color ?? Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: bkColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: hasBorder ? color ?? Colors.orange : Colors.transparent,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget _avatarImg({int? id, String? url}) {
    final isAddBtn = url == null;
    final size = _letterSize;
    return InkWell(
      onTap: () {
        if (isAddBtn) {
          final newId = users.length + 1;
          users.add(UserModel(
              id: newId,
              url:
                  "https://i0.wp.com/i.ya-webdesign.com/images/girl-avatar-png-19.png"));
        } else {
          users.removeWhere((element) => element.id == id);
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(1),
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: isAddBtn ? Colors.grey : Colors.white,
          ),
        ),
        child: isAddBtn
            ? Icon(
                Icons.add,
              )
            : Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    url!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );
  }
}

class UserModel {
  int id;
  String url;
  UserModel({
    required this.id,
    required this.url,
  });
}
