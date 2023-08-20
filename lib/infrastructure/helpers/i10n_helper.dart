import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizationsHelper {
  AppLocalizationsHelper(this.locale);

  final Locale locale;

  static AppLocalizationsHelper of(BuildContext context) {
    return Localizations.of<AppLocalizationsHelper>(context, AppLocalizationsHelper)!;
  }

  static AppLocalizationsHelper get instance => AppLocalizationsHelperDelegate.instance;

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'poop_type_1': 'Type 1: Hard, separate lumps, like nuts (difficult to pass)',
      'poop_type_2': 'Type 2: Sausage-shaped, but lumpy',
      'poop_type_3': 'Type 3: Sausage-shaped, but with cracks on the surface',
      'poop_type_4': 'Type 4: Sausage or snake-like, smooth and soft',
      'poop_type_5': 'Type 5: Soft blobs with clear-cut edges (easy to pass)',
      'poop_type_6': 'Type 6: Fluffy pieces with ragged edges, a mushy stool',
      'poop_type_7': 'Type 7: Liquid consistency with no solid pieces',
      'question1': 'What is your energy level upon waking up?',
      'question2': 'Does your energy increase throughout the day?',
      'question3': 'Did you experience many cravings for sweets?',
      'question4': 'Do you feel stressed/irritable today?',
      'question5': 'Is the stress/irritation justified by any specific event?',
      'question6': 'How is your libido today?',
      'question7': 'Did you experience muscle or joint pains today?',
      'question8': 'Do you have headaches or migraines?',
      'question9': 'Do you feel that you achieved your goals for today?',
      'question10': 'Did you do meditation/grounding or another practice for your well-being?',
      'question11': 'Something else you want to say?'
    },
    'es': {
      'poop_type_1' : 'Tipo 1: Heces duras y separadas, como nueces (difícil de evacuar)',
      'poop_type_2' : 'Tipo 2: Heces con forma de salchicha, pero grumosas',
      'poop_type_3' : 'Tipo 3: Heces con forma de salchicha, pero con grietas en la superficie',
      'poop_type_4' : 'Tipo 4: Heces con forma de salchicha o serpiente, suave y lisa',
      'poop_type_5' : 'Tipo 5: Heces suaves con bordes definidos (fácil de evacuar)',
      'poop_type_6' : 'Tipo 6: Heces suaves y esponjosas con bordes irregulares',
      'poop_type_7' : 'Tipo 7: Heces líquidas, sin sólidos',
      'question1': '¿Cuál es tu nivel de energía al despertar?',
      'question2': '¿La energía aumenta a lo largo del día?',
      'question3': '¿Sentiste muchos antojos por dulces?',
      'question4': '¿Te sientes estresada/irritada hoy?',
      'question5': '¿El estrés/irritación se justifica por algún acontecimiento específico?',
      'question6': '¿Cómo está tu libido hoy?',
      'question7': '¿Sentiste dolores musculares o articulares hoy?',
      'question8': '¿Tienes dolores de cabeza o migrañas?',
      'question9': '¿Sientes que cumpliste tus objetivos de hoy?',
      'question10': '¿Realizaste meditación/grounding u otra práctica para tu bienestar?',
      'question11': '¿Algo más que quieras decir?'
    },
    'pt' : {
      'poop_type_1': 'Tipo 1: Fezes duras e separadas, como nozes (difícil de evacuar)',
      'poop_type_2': 'Tipo 2: Fezes em forma de salsicha, mas grumosas',
      'poop_type_3': 'Tipo 3: Fezes em forma de salsicha, mas com rachaduras na superfície',
      'poop_type_4': 'Tipo 4: Fezes em forma de salsicha ou de cobra, macias e lisas',
      'poop_type_5': 'Tipo 5: Fezes macias com bordas definidas (fáceis de evacuar)',
      'poop_type_6': 'Tipo 6: Peças fofas com bordas irregulares, uma fezes pastosas',
      'poop_type_7': 'Tipo 7: Consistência líquida sem pedaços sólidos',
      'question1': 'Qual é o teu nível de energia ao acordar?',
      'question2': 'A energia aumenta ao longo do dia?',
      'question3': 'Tiveste muitas vontades de comer doces?',
      'question4': 'Estás a sentir-te stressado/irritado hoje?',
      'question5': 'O stress/irritação é justificado por algum acontecimento específico?',
      'question6': 'Como está a tua libido hoje?',
      'question7': 'Tiveste dores musculares ou articulares hoje?',
      'question8': 'Tens dores de cabeça ou enxaquecas?',
      'question9': 'Sentes que cumpriste os teus objetivos de hoje?',
      'question10': 'Fizeste meditação/grounding ou outra prática para o teu bem-estar?',
      'question11': 'Algo mais que queira dizer?'
    }
  };

  static List<String> languages ()=> _localizedValues.keys.toList();

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key]!;
  }
}
// #enddocregion App

// #docregion Delegate
class AppLocalizationsHelperDelegate
    extends LocalizationsDelegate<AppLocalizationsHelper> {
  static var instance;

  const AppLocalizationsHelperDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizationsHelper.languages().contains(locale.languageCode);


  @override
  Future<AppLocalizationsHelper> load(Locale locale) async {
    var localizations =
    await SynchronousFuture<AppLocalizationsHelper>(AppLocalizationsHelper(locale));
    instance = localizations;
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsHelperDelegate old) => false;
}