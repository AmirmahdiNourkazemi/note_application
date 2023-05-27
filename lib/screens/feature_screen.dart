import 'package:flutter/material.dart';

import '../widgets/cheque_screen.dart';

class featureScreen extends StatefulWidget {
  featureScreen(this.isDark, {super.key});
  bool isDark;
  @override
  State<featureScreen> createState() => _featureScreenState();
}

class _featureScreenState extends State<featureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.vertical,
        slivers: [
          SeeCalendar(),
        ],
      ),
    );
  }
}

class SeeCalendar extends StatelessWidget {
  const SeeCalendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color.fromARGB(255, 155, 152, 152)
                          : Color(0xff18DAA3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text('ست کن'),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'یادآوری پرداخت بیمه',
                    textScaleFactor: 1.2,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.document_scanner_outlined,
                    size: 25,
                  ),
                ],
              ),
            ],
          ),
        ),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Theme.of(context).brightness == Brightness.dark
              ? Color.fromARGB(255, 94, 92, 92)
              : Colors.white,
        ),
      ),
    );
  }
}
