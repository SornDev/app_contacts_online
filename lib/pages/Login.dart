import 'package:app_register_online/service/AppProvider.dart';
import 'package:app_register_online/service/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Form.dart';
import 'Register.dart';
import 'AdminHome.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _Phone_number = TextEditingController();
  TextEditingController _Password = TextEditingController();
  bool _seepass = true;
  bool _pressLogin = false;
  bool _showMg = false;

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
        Align(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Padding(
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
                              'ສະບາຍດີ, ຍິນດີຕ້ອນຮັບ',
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
                      'ເບີໂທລະສັບ:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 238, 43, 153),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      maxLength: 10,
                      controller: _Phone_number,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: '',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 0),
                          child: Text(
                            '+ 856 ',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '     ກະລຸນາປ້ອນເບີໂທ...';
                        }
                        return null;
                      },
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
                    TextFormField(
                      obscureText: _seepass,
                      controller: _Password,
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
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _seepass = !_seepass;
                              });
                            },
                            icon: (_seepass)
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Color.fromARGB(255, 238, 43, 153),
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: Color.fromARGB(255, 238, 43, 153),
                                  ),
                          ),
                        ),
                      ),
                      style: const TextStyle(fontSize: 20),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ...';
                        }
                        return null;
                      },
                    ),
                    (_showMg)
                        ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              Provider.of<AuthProvider>(context, listen: false)
                                  .massages_check_login
                                  .toString(),
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          )
                        : SizedBox(
                            height: 100,
                          ),
                    SizedBox(
                      width: double.infinity,
                      child: (_pressLogin)
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Color.fromARGB(255, 238, 43, 153)),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // ປິກ ຄີບອດ
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  setState(() {
                                    _pressLogin = true;
                                  });

                                  bool result = await Provider.of<AuthProvider>(
                                          context,
                                          listen: false)
                                      .LoginAuth(
                                          _Phone_number.text, _Password.text);

                                  if (result) {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => AdminHome()));
                                  } else {
                                    setState(() {
                                      _pressLogin = false;
                                      _showMg = true;
                                    });
                                  }
                                }
                              },
                              child: Text(
                                'ເຂົ້າສູ່ລະບົບ',
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
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: const Text(
                            'ບໍ່ມີບັນຊີ, ລົງທະບຽນ',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'V 1.0.0 Develop by SornDev',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        )
      ]),
    );
  }
}
