
import 'package:flutter/material.dart';

class Repos {
 final String name, html_url;

  Repos({
    required this.name,
    required this.html_url,
  });

factory Repos.fromJson(Map<String, dynamic> json) {
  return Repos(
    name: json['name'],
    html_url: json['html_url']);
}

  //convert to json
  Map<String, dynamic> toJson() => {
    'name' : name,
    'html_url' : html_url,
  };


  //  static Repos fromMap(Map<String, dynamic> map) {
  //   if (map == null) return null!;
  //   return Repos(name: map['name'], html_url: map['html_url']);
  // }

  Repos.fromMap(Map<String, dynamic> map): name = map['name'], html_url = map['html_url'];
}