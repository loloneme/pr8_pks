import 'package:flutter/material.dart';
import 'package:frontend/components/incrementor.dart';
import 'package:frontend/models/cart_item.dart';
import '../models/drink.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/drink_info.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({
    super.key,
    required this.drink,
    required this.isDeletable,
    required this.addToCart,
  });

  final Drink drink;
  final bool isDeletable;
  final Function addToCart;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  void _showConfirmDelete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(44, 32, 17, 1.0),
            title: Text("Удалить напиток?",
                style: GoogleFonts.sourceSerif4(
                    textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(255, 238, 205, 1.0),
                ))),
            content: Text("Отменить это действие будет невозможно",
                style: GoogleFonts.sourceSerif4(
                    textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(255, 238, 205, 1.0),
                ))),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Отмена",
                      style: GoogleFonts.sourceSerif4(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(255, 238, 205, 1.0),
                      )))),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("OK",
                      style: GoogleFonts.sourceSerif4(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(255, 238, 205, 1.0),
                      ))))
            ],
          );
        }).then((result) {
      if (result == true) {
        Navigator.of(context).pop(true);
      }
    });
  }

  void _showAddToCartModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromRGBO(159, 133, 102, 1.0),
      builder: (BuildContext context) {
        List<String> temperatureOptions = [];
        List<String> volumeOptions = widget.drink.prices.keys.toList();

        if (widget.drink.cold) {
          temperatureOptions.add("Холодный");
        }

        if (widget.drink.hot) {
          temperatureOptions.add("Горячий");
        }

        CartItem newItem = CartItem(widget.drink.name,
            widget.drink.image,
            false,
            1,
            widget.drink.prices[volumeOptions[0]]!,
            volumeOptions[0]
        );

        String selectedTemperature = temperatureOptions[0];

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Выберите опции для напитка",
                        style: GoogleFonts.sourceSerif4(
                            textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(44, 32, 17, 1.0),
                        ))),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        temperatureOptions.length > 1 ? DropdownButton<String>(
                          value: selectedTemperature,
                          items: temperatureOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: GoogleFonts.sourceSerif4(
                                      textStyle: const TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(44, 32, 17, 1.0),
                                  ))),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedTemperature = newValue!;
                            });
                          },
                        ) : Text(selectedTemperature,
                            style: GoogleFonts.sourceSerif4(
                                textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(44, 32, 17, 1.0),
                                ))),
                        volumeOptions.length > 1 ? DropdownButton<String>(
                          value: newItem.volume,
                          items: volumeOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text("$valueмл",
                                  style: GoogleFonts.sourceSerif4(
                                      textStyle: const TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(44, 32, 17, 1.0),
                                  ))),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setModalState(() {
                              newItem.volume = newValue!;
                            });
                          },
                        ) : Text("${newItem.volume}мл",
                            style: GoogleFonts.sourceSerif4(
                                textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(44, 32, 17, 1.0),
                                ))),
                       Incrementor(
                           onDecrement: (){
                             if (newItem.amount > 1){
                               setModalState((){
                                 newItem.amount -= 1;
                               });
                             }
                           },
                           onIncrement: (){
                             setModalState((){
                               newItem.amount += 1;
                             });
                           },
                           count: newItem.amount)
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                        "Стоимость: ${newItem.priceOfOneItem * newItem.amount}₽",
                        style: GoogleFonts.sourceSerif4(
                            textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(44, 32, 17, 1.0),
                        ))),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(44, 32, 17, 1.0),
                      ),
                      onPressed: () {
                        if (selectedTemperature == 'Холодный'){
                          newItem.isCold = true;
                        }
                        widget.addToCart(newItem);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                          backgroundColor: const Color.fromRGBO(44, 32, 17, 1.0),
                            content: Text('${newItem.name} добавлен в корзину!',
                                style: GoogleFonts.sourceSerif4(
                                    textStyle: const TextStyle(
                                        fontSize: 18.0,
                                        color: Color.fromRGBO(255, 238, 205, 1.0)))
                            )));
                        Navigator.pop(context);
                      },
                      child: Text('Добавить',
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(255, 238, 205, 1.0)))),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.drink.name,
                style: GoogleFonts.sourceSerif4(
                    textStyle: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(44, 32, 17, 1.0),
                )))),
        backgroundColor: const Color.fromRGBO(159, 133, 102, 1.0),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            width: double.infinity,
            color: const Color.fromRGBO(159, 133, 102, 1.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
              child: Column(
                children: [
                  DrinkInfo(drink: widget.drink),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.isDeletable
                                ? IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: const Color.fromRGBO(44, 32, 17, 1.0),
                                    iconSize: 30,
                                    onPressed: _showConfirmDelete)
                                : const SizedBox.shrink(),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(44, 32, 17, 1.0),
                                ),
                                onPressed: _showAddToCartModal,
                                child: Text('В корзину',
                                    style: GoogleFonts.sourceSerif4(
                                        textStyle: const TextStyle(
                                            fontSize: 20.0,
                                            color: Color.fromRGBO(255, 238, 205, 1.0)))),
                              ),
                          ],
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
