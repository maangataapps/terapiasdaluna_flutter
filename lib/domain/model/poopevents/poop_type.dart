import 'package:terapiasdaluna/infrastructure/helpers/i10n_helper.dart';
import 'package:terapiasdaluna/infrastructure/helpers/image_helper.dart';

sealed class PoopType {
  String description;
  String image;
  int index;

  PoopType({
    required this.description,
    required this.image,
    required this.index,
  });

  static List<PoopType> createPoopTypesList() => [
    PoopType1(),
    PoopType2(),
    PoopType3(),
    PoopType4(),
    PoopType5(),
    PoopType6(),
    PoopType7(),
  ];
}

class PoopType1 extends PoopType {
  PoopType1(): super(
    description: AppLocalizationsHelper.instance.translate('poop_type_1'),
    image: ImageHelper().poop1Image,
    index: 0,
  );
}

class PoopType2 extends PoopType {
  PoopType2(): super(
    description: AppLocalizationsHelper.instance.translate('poop_type_2'),
    image: ImageHelper().poop2Image,
    index: 1,
  );
}

class PoopType3 extends PoopType {
  PoopType3(): super(
    description: AppLocalizationsHelper.instance.translate('poop_type_3'),
    image: ImageHelper().poop3Image,
    index: 2,
  );
}

class PoopType4 extends PoopType {
  PoopType4(): super(
    description: AppLocalizationsHelper.instance.translate('poop_type_4'),
    image: ImageHelper().poop4Image,
    index: 3,
  );
}

class PoopType5 extends PoopType {
  PoopType5(): super(
    description: AppLocalizationsHelper.instance.translate('poop_type_5'),
    image: ImageHelper().poop5Image,
    index: 4,
  );
}

class PoopType6 extends PoopType {
  PoopType6(): super(
    description: AppLocalizationsHelper.instance.translate('poop_type_6'),
    image: ImageHelper().poop6Image,
    index: 5,
  );
}

class PoopType7 extends PoopType {
  PoopType7(): super(
    description: AppLocalizationsHelper.instance.translate('poop_type_7'),
    image: ImageHelper().poop7Image,
    index: 6,
  );
}

