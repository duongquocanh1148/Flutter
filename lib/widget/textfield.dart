
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'appbar_home.dart';
class TextFieldWidget{
  static Widget base({
    ValueChanged<String>? onChanged,
    onTap,
    TextEditingController? controller,
    FocusNode? focusNode,   
    InputDecoration? decoration,
    TextInputAction? textInputAction,
    TextStyle? style,    
    TextInputType? textInputType,
    String? hint,
    IconData? icon,
    String? error,
    bool isValidation = false,
  }
  ){
    return TextField(      
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),        
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        hintText: hint,
        prefixIcon: Icon(icon),
        errorText: !isValidation ? error : null,
        ),    
        style: const TextStyle(fontSize: 16),
    );    
  }
}

class AppBarWidget{
  static AppBar base({
    bool flag = true,
  }){
     return AppBar(
        automaticallyImplyLeading: false,             
        title: flag ?
        const AppBarHome() : const AcountBar(),
  ); 
  } 
}

class TextWidget{
  var formater = NumberFormat('#,###,000');
  static Text white({
    TextStyle? style,
    required String text,
  }){
     return Text(
        text,
       style: const TextStyle(color: Colors.white),
  ); 
  } 
 Text price({
    TextStyle? style,
    required String text,
  }){
     return Text(
        "${formater.format(int.parse(text))} VND",
       style: const TextStyle(color: Colors.red, fontSize: 21),
  ); 
  } 
  Text priceBasket({
    TextStyle? style,
    required String text,
  }){
     return Text(
        "${formater.format(int.parse(text))} VND",
       style: const TextStyle(color: Colors.red, fontSize: 12),
  ); 
  } 
  static Text description({
    TextStyle? style,
    required String text,
  }){
     return Text(
        text,
       style: const TextStyle(fontSize: 21),
  ); 
  } 
  static Text name({
    TextStyle? style,
    required String text,
  }){
     return Text(
        text,
       style: const TextStyle(fontSize: 34, color: Colors.green),
  ); 
  } 
}
