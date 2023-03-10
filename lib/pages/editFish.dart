import 'package:fish/components/backgrounds/background_home.dart';
import 'package:fish/components/util/User.dart';
import 'package:fish/components/util/fishes.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../components/util/SelectPhotoScreen.dart';
import '../components/util/ImagePicker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../components/util/customized_textfield.dart';
import '../components/util/SelectPhotoScreen.dart';

class editFishPage extends StatefulWidget {
  final User user;
  final fishes item;
  const editFishPage({Key? key, required this.user, required this.item})
      : super(key: key);

  @override
  State<editFishPage> createState() => _editFishState();
}

// ignore: camel_case_types
class _editFishState extends State<editFishPage> {
  final fishesType = ["Fresh Water", "Salty Water", "Mixed Water"];
  String? fishTypeVal;
  File? _image;

  TextEditingController fish_name_controller = TextEditingController();
  TextEditingController fish_price_controller = TextEditingController();
  TextEditingController fish_desc_controller = TextEditingController();

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (err) {
      const msg = SnackBar(
        content: Text("No Access"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(msg);
    }
  }

  @override
  void initState() {
    super.initState();
    fish_name_controller.text = widget.item.fish_name;
    fish_price_controller.text = widget.item.fish_price;
    fish_desc_controller.text = widget.item.fish_desc;
    fishTypeVal = widget.item.fish_type;
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              //EXIT BUTTON TO LOGIN PAGE
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  //NAVIGASI KE HOME PAGE
                  onPressed: () {
                    Navigator.popUntil(
                        context, (Route<dynamic> route) => route.isFirst);
                  },
                ),
              ), //EXIT BUTTON TO LOGIN PAGE
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Edit fish page",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SF',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Background_home(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
                      child: Center(
                        child: Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: _image != null
                                ? const Text(
                                    'Insert Image',
                                    style: TextStyle(fontSize: 20),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage(widget.item.image_path),
                                    radius: 200,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //FISH NAME
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 170, 0),

                  //FISH NAME
                  child: Text(
                    "FISH NAME",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF',
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                CustomizedTextField(
                  controller: fish_name_controller,
                  hintText: "Fish Name",
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: Icons.abc,
                ), //FISH NAME

                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 170, 0),

                  //FISH NAME
                  child: Text(
                    "FISH PRICE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF',
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                CustomizedTextField(
                  controller: fish_price_controller,
                  hintText: "Fish Price",
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: Icons.attach_money_outlined,
                ),

                //FISH TYPE
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 180, 0),

                  //FISH NAME
                  child: Text(
                    "FISH TYPE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF',
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: fishTypeVal,
                        style: const TextStyle(fontSize: 16),
                        elevation: 0,
                        iconEnabledColor: Colors.black,
                        isExpanded: true,
                        items: fishesType.map(
                          (String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 63, 63, 63),
                                  fontSize: 16,
                                  fontFamily: 'SF',
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String? value) {
                          setState(
                            () {
                              fishTypeVal = value!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),

                //FISH DESC
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 175, 0),

                  //FISH NAME
                  child: Text(
                    "FISH DESC",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF',
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                CustomizedTextField(
                  controller: fish_desc_controller,
                  hintText: "Fish Desc",
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: Icons.abc,
                ),

                //SUBMIT FORM
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        String errMSG = 'Fish Succesfully Edited';
                        Color errCol;
                        // if (fish_name_controller.text.isEmpty ||
                        //     fish_price_controller.text.isEmpty ||
                        //     fish_desc_controller.text.isEmpty ||
                        //     _image == null) {
                        //   errMSG = "Please fill all of the forms";
                        //   errCol = Colors.red;}
                        // else {
                        if (1 < 4) {
                          Navigator.pop(context);
                          errCol = const Color.fromARGB(255, 130, 234, 134);
                        } else {
                          //ERROR MESSAGE
                          errMSG = "Something went wrong";
                          errCol = Colors.red;
                        }
                        final msg = SnackBar(
                          content: Text(errMSG),
                          backgroundColor: errCol,
                          duration: const Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(msg);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 227, 235, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "SUBMIT",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'INTER',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
