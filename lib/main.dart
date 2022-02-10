import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.white,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var paddingTop = 0.0;
  var paddingBottom = 0.0;
  var widthScreen = 0.0;

  Timer? timer;
  late ValueNotifier<DateTime> valueNotifier;
  @override
  void initState() {
    valueNotifier = ValueNotifier<DateTime>(DateTime.now());
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      valueNotifier.value = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('ini metod buil widget');
    final mediaQueryData = MediaQuery.of(context);
    widthScreen = mediaQueryData.size.width;
    paddingTop = mediaQueryData.padding.top;
    paddingBottom = mediaQueryData.padding.bottom;

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(
          16,
          paddingTop + 16,
          16,
          paddingBottom > 0 ? paddingBottom : 16,
        ),
        child: Column(
          children: [
            buildWidgetHeader(),
            const SizedBox(height: 24),
            ValueListenableBuilder<DateTime>(
              valueListenable: valueNotifier,
              builder: (BuildContext context, DateTime now, Widget? child) {
                return buildWidgetDateTime(now);
              },
            ),
            buildWidgetButtomPress(),
            buildWidgetButtomPressIcon(),
            const SizedBox(height: 24),
            buildWidgetMenu(),
          ],
        ),
      ),
    );
  }

  Widget buildWidgetHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            Text(
              '_iamantariksa13',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        ClipOval(
          child: Image.asset(
            'assets/images/ase.jpg',
            width: 42,
            height: 42,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget buildWidgetDateTime(DateTime now) {
    print('ini metod builWidgetDateTime');
    final formattedTime = DateFormat('HH:MM', 'id').format(now);
    final formattedTime2 = DateFormat(':ss', 'id').format(now);
    final formattedDate = DateFormat('EEEE, dd MMM yyy', 'id').format(now);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text(
              formattedTime,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
            ),
            Text(
              formattedTime2,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
            ),
          ],
        ),
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  Widget buildWidgetButtomPress() {
    return Expanded(
      child: Container(
        width: widthScreen / 1.5,
        height: widthScreen / 1.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            colors: [
              Colors.orange[900]!,
              Colors.orange,
              Colors.orange[200]!,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              color: Colors.white,
              size: widthScreen / 3,
            ),
            Text(
              'Absen Masuk',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWidgetButtomPressIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_circle),
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Ijin Tidak Hadir'),
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.article_rounded),
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            const Text("Lihat History"),
          ],
        ),
      ],
    );
  }

  Widget buildWidgetMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.fingerprint,
                  color: Colors.orange,
                ),
              ),
              Text(
                'Absensi',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.orange,
                    ),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.local_activity),
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                'Kegiatan',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help),
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                'Problem',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                'Lokasi',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
