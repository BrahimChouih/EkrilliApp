import 'package:ekrilli_app/components/empty_screen.dart';
import 'package:ekrilli_app/controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../components/house_widget.dart';

class FavoriteTap extends StatelessWidget {
  FavoriteTap({Key? key}) : super(key: key);
  FavoriteController favoriteController = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'Favorite'),
            SizedBox(height: Get.height * 0.01),
            favoriteController.isEmpty
                ? const EmptyScreen(
                    title: 'No favorite yet',
                    icon: FontAwesomeIcons.heart,
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (_, index) => Stack(
                        children: [
                          HouseWidget(
                            offer: favoriteController.favorites.first.offer!
                              ..id = index,
                          ),
                          Positioned(
                            right: 20,
                            top: 10,
                            child: IconButton(
                              onPressed: () {},
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: const FaIcon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
