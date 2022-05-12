import 'package:ekrilli_app/helpers/location_helper.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/picture.dart';
import 'package:ekrilli_app/screens/house_details_screen.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../components/custom_app_bar.dart';
import '../components/house_picture_picker.dart';
import '../components/text_field_with_title.dart';
import '../models/offer.dart';

class CreateOfferScreen extends StatefulWidget {
  CreateOfferScreen({
    Key? key,
    required this.house,
  }) : super(key: key);
  House house;

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  Offer? offer;

  RxDouble pricePerDay = 0.0.obs;

  var pricePerDayKey = GlobalKey<FormState>(
    debugLabel: 'pricePerDayKey',
  );

  TextEditingController pricePerDayController = TextEditingController(
    text: '0.0',
  );

  @override
  void initState() {
    offer = Offer(
      house: widget.house,
    );
    pricePerDayController.addListener(() {
      try {
        pricePerDay.value = double.parse(pricePerDayController.text);
      } catch (e) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: 'New Offer',
                backButton: true,
                trailing: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: const Text(
                    'Publish',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    pricePerDayKey.currentState?.validate();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    TextFielWithTitle(
                      formKey: pricePerDayKey,
                      controller: pricePerDayController,
                      textInputType: TextInputType.number,
                      title: 'Price per day',
                      validator: (value) {
                        if (pricePerDayController.text.isEmpty) {
                          return 'You must fill in this field';
                        }
                        if (double.parse(pricePerDayController.text) == 0.0) {
                          return 'You have to change this field';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Center(
                child: Container(
                  height: Get.height * 0.75,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: deepPrimaryColor.withOpacity(0.5),
                    ),
                  ),
                  child: Obx(
                    () => HouseDetailsScreen(
                      offer: offer!..pricePerDay = pricePerDay.value,
                      isPreview: true,
                    ),
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
