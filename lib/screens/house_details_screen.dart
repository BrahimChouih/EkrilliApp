import 'dart:ui';

import 'package:ekrilli_app/components/description_viewer.dart';
import 'package:ekrilli_app/components/map_apps.dart';
import 'package:ekrilli_app/components/pictures_slider.dart';
import 'package:ekrilli_app/components/rating_widget.dart';
import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/components/rooms_number_widget.dart';
import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/components/title_widget.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/controllers/house_controller.dart';
import 'package:ekrilli_app/controllers/offers_controller.dart';
import 'package:ekrilli_app/models/chat_item_model.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/picture.dart';
import 'package:ekrilli_app/screens/chatting_screen.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

import '../components/custom_app_bar.dart';
import '../controllers/favorite_controller.dart';

class HouseDetailsScreen extends StatefulWidget {
  HouseDetailsScreen({
    Key? key,
    required this.offer,
    this.isPreview = false,
  }) : super(key: key);

  Offer offer;
  bool isPreview;

  @override
  State<HouseDetailsScreen> createState() => _HouseDetailsScreenState();
}

class _HouseDetailsScreenState extends State<HouseDetailsScreen> {
  OfferController offerController = Get.find<OfferController>();
  FavoriteController favoriteController = Get.find<FavoriteController>();

  EdgeInsets margin = EdgeInsets.symmetric(
    horizontal: Get.width * 0.03,
    vertical: Get.height * 0.01,
  );

  GlobalKey startChattingButton = GlobalKey();

  RxDouble startChattingButtonHeight = 0.0.obs;

  @override
  void initState() {
    if (!widget.isPreview) {
      offerController.getOfferInfo(widget.offer.id!, returnOffer: (ofr) {
        widget.offer = ofr;
      });
    }
    WidgetsBinding.instance?.addPostFrameCallback((d) {
      startChattingButtonHeight.value =
          (startChattingButton.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
      print(startChattingButtonHeight);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            widget.isPreview
                ? CustomAppBar(title: 'Preview')
                : CustomAppBar(
                    title: 'House',
                    backButton: true,
                    trailing: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: GetBuilder<FavoriteController>(
                        id: favoriteController.favoriteIconId,
                        builder: (context) {
                          return Icon(
                            favoriteController.contains(widget.offer.id!)
                                ? Icons.favorite_rounded
                                : Icons.favorite_border,
                            color: favoriteController.contains(widget.offer.id!)
                                ? primaryColor
                                : deepPrimaryColor,
                          );
                        },
                      ),
                      onTap: () async {
                        if (widget.offer.id != null) {
                          await favoriteController
                              .addFavorite(widget.offer.id!);
                        }
                      },
                    ),
                  ),
            Expanded(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      if (!widget.isPreview) {
                        offerController.getOfferInfo(widget.offer.id!,
                            returnOffer: (ofr) {
                          widget.offer = ofr;
                        });
                      }
                    },
                    child: SingleChildScrollView(
                      child: GetBuilder<OfferController>(
                          id: offerController.offerInfoWidgetId,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03,
                                    vertical: Get.height * 0.02,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.offer.house.title ?? '',
                                    style: Get.theme.textTheme.headline5
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                PicturesSlider(
                                  pictures: widget
                                          .offer.house.pictures.isNotEmpty
                                      ? widget.offer.house.pictures
                                      : [
                                          Picture(
                                            isUrl: false,
                                            picture: 'assets/vectors/house.svg',
                                          )
                                        ],
                                ),
                                SizedBox(height: Get.height * 0.03),
                                Container(
                                  margin: margin,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            widget.offer.house.owner?.picture !=
                                                    null
                                                ? NetworkImage(
                                                    widget.offer.house.owner
                                                            ?.picture ??
                                                        '',
                                                  )
                                                : null,
                                        child:
                                            widget.offer.house.owner?.picture ==
                                                    null
                                                ? SvgPicture.asset(
                                                    'assets/vectors/person.svg',
                                                  )
                                                : null,
                                        radius: Get.width * 0.07,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        widget.offer.house.owner?.username ??
                                            '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      StarsWidget(
                                        stars: widget.offer.house.stars ?? 0,
                                        numReviews:
                                            widget.offer.house.numReviews ?? 1,
                                        type: StarsWidgetType.digital,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: margin,
                                  child: RoomsNumberWidget(
                                    kitchens: widget.offer.house.kitchens ?? 1,
                                    bathrooms:
                                        widget.offer.house.bathrooms ?? 1,
                                    bedrooms: widget.offer.house.bedrooms ?? 1,
                                    color: Colors.black54,
                                    size: 25,
                                    textStyle: Get.theme.textTheme.headline5,
                                  ),
                                ),
                                Container(
                                  margin: margin,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          if (widget.offer.house
                                                      .locationLatitude !=
                                                  null &&
                                              widget.offer.house
                                                      .locationLongitude !=
                                                  null) {
                                            Get.bottomSheet(
                                              MapApps(
                                                coords: Coords(
                                                  widget.offer.house
                                                      .locationLatitude!,
                                                  widget.offer.house
                                                      .locationLongitude!,
                                                ),
                                              ),
                                              elevation: 0,
                                              barrierColor: Colors.transparent,
                                            );
                                          }
                                        },
                                        child: Row(
                                          children: const [
                                            FaIcon(
                                              FontAwesomeIcons.locationDot,
                                              color: primaryColor,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Open Map',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.offer.pricePerDay.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'DA/Day',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TitleWidget(
                                  title: 'Description:',
                                  margin: margin.copyWith(
                                    bottom: 0,
                                    top: Get.height * 0.04,
                                  ),
                                  textStyle: Get.textTheme.headline6?.copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: margin,
                                  child: DescriptionViewer(
                                      text:
                                          widget.offer.house.description ?? ''),
                                ),
                                RatingWidget(offer: widget.offer),
                                Obx(
                                  () => SizedBox(
                                    height: startChattingButtonHeight.value,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  widget.isPreview ||
                          widget.offer.house.owner!.id ==
                              Get.find<AuthController>().currentUser!.id
                      ? const SizedBox()
                      : Positioned(
                          width: Get.width,
                          bottom: 0,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 6,
                                sigmaY: 6,
                              ),
                              child: Center(
                                child: SubmitButton(
                                  key: startChattingButton,
                                  text: 'Start Chatting',
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 25,
                                  ),
                                  onTap: () => Get.to(
                                    () => ChattingScreen(
                                      chatItemModel: ChatItemModel(
                                        offer: widget.offer,
                                        user: Get.find<AuthController>()
                                            .currentUser,
                                      ),
                                    ),
                                    transition: Transition.downToUp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
