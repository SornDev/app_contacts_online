import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 400,
            color: Color.fromARGB(255, 238, 43, 153),
          ),
        ),
        Positioned(
          child: Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'ລົງທະບຽນ ບັນຊີໃໝ່',
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Color.fromARGB(255, 238, 43, 153)),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          'ຊື່:',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 238, 43, 153)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: '.....',
                          ),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        const Text(
                          'ນາມສະກຸນ:',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 238, 43, 153)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: '.....',
                          ),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: 'null',
                                    onChanged: (index) {}),
                                Text(
                                  'ເພດຊາຍ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 238, 43, 153)),
                                ),
                                Radio(
                                    value: 1,
                                    groupValue: 'null',
                                    onChanged: (index) {}),
                                Text(
                                  'ເພດຍິງ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 238, 43, 153)),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'ເບີໂທລະສັບ:',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 238, 43, 153)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10, right: 0),
                              child: Text(
                                '+ 856 20 ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 0,
                              top: 20,
                              bottom: 20,
                              right: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: '....',
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        const Text(
                          'ລະຫັດຜ່ານ:',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 238, 43, 153)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: '.....',
                          ),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        const Text(
                          'ຍືນຍັນຫລະຫັດຜ່ານ:',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 238, 43, 153)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: '.....',
                          ),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'ລົງທະບຽນ',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                primary: Color.fromARGB(255, 238, 43, 153)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'V 1.0.0 Develop by SornDev',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
