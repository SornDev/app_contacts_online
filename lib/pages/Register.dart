import 'package:app_register_online/service/ContactProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

final _formKey = GlobalKey<FormState>();
String Gender = 'male';
bool _seepass1 = true;
bool _seepass2 = true;
bool _pressAdd = false;
bool _chpass = false;

TextEditingController _name = TextEditingController();
TextEditingController _last_name = TextEditingController();
TextEditingController _birth_day = TextEditingController();
TextEditingController _phone_number = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();
TextEditingController _confirm_password = TextEditingController();

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
            child: Form(
              key: _formKey,
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
                                        color:
                                            Color.fromARGB(255, 238, 43, 153)),
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
                          TextFormField(
                            controller: _name,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ກະລຸນາປ້ອນຊື່...';
                              }
                              return null;
                            },
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
                          TextFormField(
                            controller: _last_name,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ກະລຸນາປ້ອນນາມສະກຸນ...';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: 'male',
                                      groupValue: Gender,
                                      onChanged: (value) {
                                        setState(() {
                                          Gender = value!;
                                        });
                                      }),
                                  Text(
                                    'ເພດຊາຍ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 238, 43, 153)),
                                  ),
                                  Radio(
                                      value: 'female',
                                      groupValue: Gender,
                                      onChanged: (value) {
                                        setState(() {
                                          Gender = value!;
                                        });
                                      }),
                                  Text(
                                    'ເພດຍິງ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 238, 43, 153)),
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
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _phone_number,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '      ກະລຸນາປ້ອນເບີໂທ...';
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
                            obscureText: _seepass1,
                            controller: _password,
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
                                      _seepass1 = !_seepass1;
                                    });
                                  },
                                  icon: (_seepass1)
                                      ? Icon(
                                          Icons.visibility_off,
                                          color:
                                              Color.fromARGB(255, 238, 43, 153),
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color:
                                              Color.fromARGB(255, 238, 43, 153),
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
                          TextFormField(
                            obscureText: _seepass2,
                            controller: _confirm_password,
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
                                      _seepass2 = !_seepass2;
                                    });
                                  },
                                  icon: (_seepass2)
                                      ? Icon(
                                          Icons.visibility_off,
                                          color:
                                              Color.fromARGB(255, 238, 43, 153),
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color:
                                              Color.fromARGB(255, 238, 43, 153),
                                        ),
                                ),
                              ),
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                          if (_chpass)
                            Padding(
                              child: Text(
                                'ລະຫັດຜ່ານບໍ່ກົງກັນ ກະລຸນາກວດຄືນ!',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              padding: const EdgeInsets.all(15),
                            ),
                          const SizedBox(
                            height: 80,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: _pressAdd
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Color.fromARGB(255, 238, 43, 153)),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_password.text ==
                                            _confirm_password.text) {
                                          _chpass = false;
                                          setState(() {
                                            _pressAdd = true;
                                          });

                                          bool result = await Provider.of<
                                                      ContactProvider>(context,
                                                  listen: false)
                                              .AddUser(
                                                  _name.text,
                                                  _last_name.text,
                                                  Gender,
                                                  '',
                                                  '',
                                                  '',
                                                  _phone_number.text,
                                                  _password.text,
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  null);

                                          if (result) {
                                            // set 0
                                            setState(() {
                                              _name.text = '';
                                              _last_name.text = '';
                                              _phone_number.text = '';
                                              _password.text = '';
                                              _confirm_password.text = '';
                                              _pressAdd = false;
                                              Navigator.of(context).pop();
                                            });
                                          } else {
                                            setState(() {
                                              _pressAdd = false;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            _chpass = true;
                                          });
                                        }
                                      }
                                    },
                                    child: Text(
                                      'ລົງທະບຽນ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        primary:
                                            Color.fromARGB(255, 238, 43, 153)),
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
          ),
        )
      ]),
    );
  }
}
