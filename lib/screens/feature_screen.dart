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
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            sliver: InsuranceContainer(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            sliver: chequeContainer(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            sliver: SliverToBoxAdapter(
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
                            'یادآور خدمات تعمیر خودرو',
                            textScaleFactor: 1.2,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.car_repair_outlined,
                            size: 28,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromARGB(255, 94, 92, 92)
                      : Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class chequeContainer extends StatelessWidget {
  const chequeContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {},
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ChequeScreen();
                      }),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          textColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Color.fromRGBO(94, 92, 92, 1),
                          disabledTextColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromRGBO(94, 92, 92, 1)
                                  : Colors.white,
                          label: 'حله',
                          onPressed: () {},
                        ),
                        content: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            "لطفا چک خود را اضافه کنید",
                            style: TextStyle(
                              fontFamily: 'SM',
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Color.fromRGBO(94, 92, 92, 1),
                            ),
                          ),
                        ),
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Color.fromRGBO(94, 92, 92, 1)
                                : Colors.white,
                      ),
                    );
                  },
                  child: Text('ست کن'),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'موعود چک',
                      textScaleFactor: 1.2,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.attach_money_outlined,
                      size: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Theme.of(context).brightness == Brightness.dark
                ? Color.fromARGB(255, 94, 92, 92)
                : Colors.white,
          ),
        ),
      ),
    );
  }
}

class InsuranceContainer extends StatelessWidget {
  const InsuranceContainer({
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
        height: 100,
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
