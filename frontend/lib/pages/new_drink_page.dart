import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/drink.dart';

class NewDrinkPage extends StatefulWidget {
  const NewDrinkPage({super.key});

  @override
  State<NewDrinkPage> createState() => _NewDrinkPageState();
}

class _NewDrinkPageState extends State<NewDrinkPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  String _image = '';
  String _name = '';
  String _description = '';
  List<String> _compound = [];
  bool _cold = false;
  bool _hot = false;
  final Map<String, int> _prices = {};

  final List<String> _volumes = ['250', '350', '500'];

  void _submitForm() {
    if (_formGlobalKey.currentState!.validate()) {
      _formGlobalKey.currentState!.save();

      Drink newDrink =
          Drink(
            id: 0,
            image: _image,
            name: _name,
            description: _description,
            compound: _compound,
            cold: _cold,
            hot: _hot,
            prices: _prices,
            isFavorite: false
          );

      Navigator.pop(context, newDrink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Новый напиток",
                style: GoogleFonts.sourceSerif4(
                    textStyle: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(44, 32, 17, 1.0),
                )))),
        backgroundColor: const Color.fromRGBO(159, 133, 102, 1.0),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color.fromRGBO(159, 133, 102, 1.0),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: 260,
                        child: TextFormField(
                          maxLength: 20,
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(44, 32, 17, 1.0))),
                          decoration: InputDecoration(
                              counterText: '',
                              isDense: true,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(44, 32, 17, 1.0),
                                      width: 2.0)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(44, 32, 17, 1.0),
                                      width: 2.0)),
                              contentPadding: const EdgeInsets.all(5),
                              labelText: "Название",
                              labelStyle: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18.0,
                                      color:
                                          Color.fromRGBO(217, 217, 217, 1.0)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Введите название";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: SizedBox(
                        width: 260,
                        child: TextFormField(
                          keyboardType: TextInputType.url,
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(44, 32, 17, 1.0))),
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(44, 32, 17, 1.0),
                                      width: 2.0)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(44, 32, 17, 1.0),
                                      width: 2.0)),
                              contentPadding: const EdgeInsets.all(5),
                              labelText: "URL картинки",
                              labelStyle: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18.0,
                                      color:
                                          Color.fromRGBO(217, 217, 217, 1.0)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Введите URL";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _image = value!;
                          },
                        ),
                      ),
                    ),
                    SwitchListTile(
                        title: Text("Можно сделать холодным?",
                            style: GoogleFonts.sourceSerif4(
                                textStyle: const TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(44, 32, 17, 1.0),
                            ))),
                        contentPadding: const EdgeInsets.all(0),
                        inactiveThumbColor:
                            const Color.fromRGBO(44, 32, 17, 1.0),
                        inactiveTrackColor:
                            const Color.fromRGBO(217, 217, 217, 1),
                        activeColor: const Color.fromRGBO(217, 217, 217, 1),
                        activeTrackColor: const Color.fromRGBO(44, 32, 17, 1.0),
                        value: _cold,
                        onChanged: (value) {
                          setState(() {
                            _cold = value;
                          });
                        }),
                    SwitchListTile(
                        title: Text("Можно сделать горячим?",
                            style: GoogleFonts.sourceSerif4(
                                textStyle: const TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(44, 32, 17, 1.0),
                            ))),
                        contentPadding: const EdgeInsets.all(0),
                        inactiveThumbColor:
                            const Color.fromRGBO(44, 32, 17, 1.0),
                        inactiveTrackColor:
                            const Color.fromRGBO(217, 217, 217, 1),
                        activeColor: const Color.fromRGBO(217, 217, 217, 1),
                        activeTrackColor: const Color.fromRGBO(44, 32, 17, 1.0),
                        value: _hot,
                        onChanged: (value) {
                          setState(() {
                            _hot = value;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("Состав:", style: GoogleFonts.sourceSerif4(
                            textStyle: const TextStyle(
                                fontSize: 18.0,
                                color:
                                    Color.fromRGBO(44, 32, 17, 1.0)))),
                    ),
                    SizedBox(
                      width: 260,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        style: GoogleFonts.sourceSerif4(
                            textStyle: const TextStyle(
                                fontSize: 18.0,
                                color: Color.fromRGBO(44, 32, 17, 1.0))),
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 32, 17, 1.0),
                                    width: 2.0)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 32, 17, 1.0),
                                    width: 2.0)),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5
                            ),
                            hintText:
                                'Введите каждый ингредиент на новой строке',
                            hintStyle: GoogleFonts.sourceSerif4(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16.0,
                                    color: Color.fromRGBO(217, 217, 217, 1.0))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Введите хотя бы один ингредиент";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _compound =
                              value!.split('\n').map((e) => e.trim()).toList();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Text('Цена:',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(44, 32, 17, 1.0)))),
                    ),
                    Column(
                        children: List.generate(_volumes.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "${_volumes[index]}мл",
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(44, 32, 17, 1.0))),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 70,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 5,
                                style: GoogleFonts.sourceSerif4(
                                    textStyle: const TextStyle(
                                        fontSize: 16.0,
                                        color:
                                            Color.fromRGBO(44, 32, 17, 1.0))),
                                decoration: InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 5.0,
                                  ),
                                ),

                                onSaved: (value) {
                                  int? parsedPrice = int.tryParse(value!);
                                  if (parsedPrice != null && parsedPrice > 0) {
                                    _prices[_volumes[index]] = parsedPrice;
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    })),
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      style: GoogleFonts.sourceSerif4(
                          textStyle: const TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(44, 32, 17, 1.0))),
                      decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(44, 32, 17, 1.0),
                                  width: 2.0)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(44, 32, 17, 1.0),
                                  width: 2.0)),
                          labelText: "Описание",
                          labelStyle: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(217, 217, 217, 1.0)))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Введите описание";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(44, 32, 17, 1.0),
                        ),
                        onPressed: () => _submitForm(),
                        child: Text('Добавить',
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(255, 238, 205, 1.0)))
                        ),
                      ),
                    ),
                  ],

                )),

          ))),
    );
  }
}
