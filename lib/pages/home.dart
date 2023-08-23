import 'dart:convert';

import 'package:app_foods/model/menusModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];

  int jml = 0;
  var val;

  @override
  void initState() {
    super.initState();
    getDataMenus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60.0,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: const Color(0xFFDFDFDF),
                              ),
                              child: Image.network(
                                '${data[index]['gambar']}',
                                fit: BoxFit.contain,
                                height: 60.0,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: SizedBox(
                                width: 130.0,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${data[index]['nama']}\n',
                                        style: const TextStyle(
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Rp ${data[index]['harga']}\n',
                                        style: const TextStyle(
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF009AAD),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20.0, right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      width: 20.82,
                                      height: 20.82,
                                      child: IconButton(
                                        icon: const Center(
                                          child: FaIcon(
                                              FontAwesomeIcons.squareMinus,
                                              color: Color(0xFF009AAD)),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 15.0),
                                    child: Text(
                                      '${data[index]['id']}',
                                      style: const TextStyle(
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.82,
                                    height: 20.82,
                                    child: IconButton(
                                      icon: const Center(
                                        child: FaIcon(
                                            FontAwesomeIcons.solidPlusSquare,
                                            color: Color(0xFF009AAD)),
                                      ),
                                      onPressed: () {
                                        jmlDibeli(index);
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
                  },
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 200.0,
              width: size.width,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                // color: Colors.red,
                color: Color(0xf0E6E6E6),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Pesanan (3 menu):',
                          style: TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Rp 28.000',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF009AAD),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: size.width,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: const Flex(
                        direction: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Icon(
                              Icons.confirmation_num,
                              color: Color(0xFF009AAD),
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text('Voucher'),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Input Voucher'),
                                FaIcon(FontAwesomeIcons.angleRight),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      voucher();
                    },
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.only(bottom: 11.0, top: 11.0),
                    margin: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      color: Colors.white70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const FaIcon(FontAwesomeIcons.basketShopping,
                              size: 40, color: Color(0xFF009AAD)),
                        ),
                        const SizedBox(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Total Pembayaran\n',
                                  style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Rp 28.000',
                                  style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF009AAD),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        MaterialButton(
                          color: const Color(0xFF009AAD),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: const Text('Pesan sekarang',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {},
                        ),
                      ],
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

  voucher() {
    return showModalBottomSheet(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.transparent,
                offset: Offset.fromDirection(18),
                blurRadius: 2.0,
                spreadRadius: 0.0,
                blurStyle: BlurStyle.solid,
              ),
              const BoxShadow(
                color: Colors.black26,
                offset: Offset(-5, -8),
                blurRadius: 2.0,
                spreadRadius: 0.0,
                blurStyle: BlurStyle.inner,
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  FaIcon(
                    Icons.confirmation_num,
                    size: 28,
                    color: Color(0xFF009AAD),
                  ),
                  SizedBox(width: 10.0),
                  Text('Punya kode voucher?', style: TextStyle(fontSize: 18.0)),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Masukkan kode voucher disini',
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Kode voucher',
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                child: MaterialButton(
                  child: Text('Ambil Voucher',
                      style: TextStyle(color: Colors.white)),
                  color: Color(0xFF009AAD),
                  onPressed: () {},
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> getDataMenus() async {
    final url = await Uri.parse('https://tes-mobile.landa.id/api/menus');
    final respon = await http.get(url);

    if (respon.statusCode == 200) {
      setState(() {
        data = jsonDecode(respon.body)['datas'];
      });
    } else {
      throw Exception('Ada Yg salah!');
    }
  }

  void jmlDibeli(int index) {
    switch (data[index]['harga']) {
      case 11000:
        setState(() {
          data[index]['harga'] * jml++;
        });
        break;
      case 9000:
        setState(() {
          data[index]['harga'] * jml++;
        });
        break;
      case 8000:
        setState(() {
          data[index]['harga'] * jml++;
        });
        break;
      case 12000:
        setState(() {
          data[index]['harga'] * jml++;
        });
        break;
      default:
    }
  }
}
