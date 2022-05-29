import 'package:ekrilli_app/helpers/location_helper.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/picture.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../components/custom_app_bar.dart';
import '../components/house_picture_picker.dart';
import '../components/text_field_with_title.dart';

class CreateHouseScreen extends StatelessWidget {
  CreateHouseScreen({
    Key? key,
    this.house,
    this.isUpdate = false,
  }) : super(key: key);
  House? house;
  bool isUpdate;

  var houseTitleKey = GlobalKey<FormState>(
    debugLabel: 'houseTitleKey',
  );
  var houseDescriptionKey = GlobalKey<FormState>(
    debugLabel: 'houseDescriptionKey',
  );

  var houseLocationKey = GlobalKey<FormState>(
    debugLabel: 'houseLocationKey',
  );

  var houseRoomsKey = GlobalKey<FormState>(
    debugLabel: 'houseRoomsKey',
  );

  TextEditingController locationLatitudeController = TextEditingController(
    text: '0.0',
  );
  TextEditingController locationLongitudeController = TextEditingController(
    text: '0.0',
  );

  List<Picture> pictures = <Picture>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: 'New House',
                backButton: true,
                trailing: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.black54,
                  ),
                  onTap: () {
                    houseTitleKey.currentState?.validate();
                    houseDescriptionKey.currentState?.validate();
                    houseLocationKey.currentState?.validate();
                    houseRoomsKey.currentState?.validate();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    TextFielWithTitle(
                      formKey: houseTitleKey,
                      controller: TextEditingController(),
                      title: 'Title',
                      maxChars: 25,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFielWithTitle(
                      formKey: houseLocationKey,
                      controller: TextEditingController(),
                      title: 'Address',
                      maxChars: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      child: roomsNumberInput(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      child: locationCoordinates(),
                    ),
                    TextFielWithTitle(
                      formKey: houseDescriptionKey,
                      controller: TextEditingController(),
                      title: 'Description',
                      maxLines: 10,
                      maxChars: 1000,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    HousePicturePicker(
                      onChange: (pcts) {
                        pictures = pictures;
                      },
                    ),
                    SizedBox(height: Get.height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget roomsNumberInput() => Form(
        key: houseRoomsKey,
        autovalidateMode: AutovalidateMode.always,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            numberField(
              'Bedroom',
              TextEditingController(text: '1'),
            ),
            const SizedBox(width: 5),
            numberField(
              'Bathroom',
              TextEditingController(text: '1'),
            ),
            const SizedBox(width: 5),
            numberField(
              'Kitchen',
              TextEditingController(text: '1'),
            ),
          ],
        ),
      );

  Widget locationCoordinates() {
    RxDouble height = 0.0.obs;
    return InkWell(
      onTap: () async {
        try {
          LocationHelper locationHelper = LocationHelper();
          Position? position = await locationHelper.getCurrentLocation();
          locationLatitudeController.text = position?.latitude.toString() ?? '';
          locationLongitudeController.text =
              position?.longitude.toString() ?? '';
          print(position?.latitude);
          print(position?.longitude);
        } catch (e) {
          Get.snackbar(
            '',
            e.toString(),
            titleText: const SizedBox(),
          );
        }
      },
      child: IgnorePointer(
        ignoring: true,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                numberField(
                  'Latitude',
                  locationLatitudeController,
                  readOnly: true,
                ),
                SizedBox(width: Get.width * 0.1),
                numberField(
                  'Longitude',
                  locationLongitudeController,
                  readOnly: true,
                ),
              ],
            ),
            Column(
              children: [
                const Text(''),
                Icon(
                  FontAwesomeIcons.locationDot,
                  color: deepPrimaryColor,
                  size: Get.height * 0.05,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget numberField(
    String title,
    TextEditingController controller, {
    bool readOnly = false,
  }) =>
      Expanded(
        child: TextFielWithTitle(
          title: title,
          readOnly: readOnly,
          controller: controller,
          textInputType: TextInputType.number,
          validator: (value) {
            // if (readOnly) return null;
            if (value == null || value == '') {
              return '';
            }
            return null;
          },
        ),
      );
}
