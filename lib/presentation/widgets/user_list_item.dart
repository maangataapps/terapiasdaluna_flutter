import 'package:flutter/material.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/infrastructure/helpers/image_helper.dart';
import 'package:terapiasdaluna/infrastructure/utils/dimens.dart';

class UserListItem extends StatelessWidget {
  final String name;
  final int sex;
  final Function onClickUser;

  const UserListItem({
    super.key,
    required this.name,
    required this.sex,
    required this.onClickUser,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.pink,
      child: InkWell(
        splashColor: Colors.amber,
        highlightColor: Colors.pink[200],
        onTap: () => onClickUser.call(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.marginLarge, vertical: Dimens.marginNormal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: Dimens.fontSizeXLarge,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: Dimens.marginLarge),
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      ImageHelper().moonImage,
                      height: 38,
                      color: sex == SexType.female.index ? Colors.pink : Colors.blue,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
