import 'package:ekrilli_app/components/empty_screen.dart';
import 'package:ekrilli_app/controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../components/house_widget.dart';
import '../../components/swipe_help.dart';
import '../../utils/constants.dart';

class FavoriteTap extends StatefulWidget {
  FavoriteTap({Key? key}) : super(key: key);

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  FavoriteController favoriteController = Get.find<FavoriteController>();
  @override
  void initState() {
    if (favoriteController.isEmpty) {
      favoriteController.getFavorites();
    } else {
      favoriteController.changeLoadingState(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'Favorite'),
            SizedBox(height: Get.height * 0.01),
            Expanded(
              child: GetBuilder<FavoriteController>(
                builder: (context) {
                  return favoriteController.isLoading
                      ? const HouseLoader()
                      : Column(
                          children: [
                            favoriteController.isEmpty
                                ? const EmptyScreen(
                                    title: 'No favorite yet',
                                    icon: FontAwesomeIcons.heart,
                                  )
                                : Expanded(
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        RefreshIndicator(
                                          onRefresh: () async {
                                            await favoriteController
                                                .getFavorites();
                                          },
                                          child: SizedBox(
                                            height: double.infinity,
                                            child: ListView.builder(
                                              itemCount: favoriteController
                                                  .favorites.length,
                                              shrinkWrap: true,
                                              itemBuilder: (_, index) =>
                                                  Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.02,
                                                  vertical: 10,
                                                ),
                                                child: Dismissible(
                                                  key: ObjectKey(index),
                                                  background:
                                                      backgroundSwipping(
                                                          Alignment.centerLeft),
                                                  secondaryBackground:
                                                      backgroundSwipping(
                                                          Alignment
                                                              .centerRight),
                                                  onDismissed: (DismissDirection
                                                      dismissDirection) {},
                                                  confirmDismiss: (DismissDirection
                                                      dismissDirection) async {
                                                    return await favoriteController
                                                        .deleteFavoriteItem(
                                                            favoriteController
                                                                .favorites[
                                                                    index]
                                                                .id!);
                                                  },
                                                  child: HouseWidget(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          Get.width * 0.03,
                                                    ),
                                                    offer: favoriteController
                                                        .favorites[index]
                                                        .offer!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 5,
                                          child: SwipeHelp(
                                            text:
                                                'swipe on an item to delete or edit',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backgroundSwipping(AlignmentGeometry alignment) => Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: borderRadius,
        ),
        alignment: alignment,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Icon(
          FontAwesomeIcons.trashCan,
          color: Colors.white,
          size: Get.width * 0.08,
        ),
      );
}
