import 'package:ekrilli_app/controllers/house_controller.dart';
import 'package:ekrilli_app/helpers/location_helper.dart';
import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/municipality.dart';
import 'package:ekrilli_app/models/picture.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../components/custom_app_bar.dart';
import '../components/house_picture_picker.dart';
import '../components/text_field_with_title.dart';

class CreateHouseScreen extends StatefulWidget {
  CreateHouseScreen({
    Key? key,
    this.house,
    this.isUpdate = false,
  }) : super(key: key);
  House? house;
  bool isUpdate;

  @override
  State<CreateHouseScreen> createState() => _CreateHouseScreenState();
}

class _CreateHouseScreenState extends State<CreateHouseScreen> {
  HouseController houseController = Get.find<HouseController>();

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

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bedroomController = TextEditingController(text: '1');
  TextEditingController bathroomController = TextEditingController(text: '1');
  TextEditingController kitchenController = TextEditingController(text: '1');

  TextEditingController locationLatitudeController = TextEditingController(
    text: '0.0',
  );

  TextEditingController locationLongitudeController = TextEditingController(
    text: '0.0',
  );
  City? city;
  Municipality? municipality;
  List<Picture> pictures = <Picture>[];
  List<Picture> deletedPictures = <Picture>[];
  House? house;
  @override
  void initState() {
    if (widget.isUpdate && widget.house != null) {
      titleController.text = widget.house!.title!;
      descriptionController.text = widget.house!.description!;
      bedroomController.text = widget.house!.bedrooms!.toString();
      bathroomController.text = widget.house!.bathrooms!.toString();
      kitchenController.text = widget.house!.kitchens!.toString();
      locationLatitudeController.text =
          widget.house!.locationLatitude!.toString();
      locationLongitudeController.text =
          widget.house!.locationLongitude!.toString();

      pictures = widget.house!.pictures;
    }
    initHouse();
    super.initState();
  }

  initHouse() {
    house = House(
      title: titleController.text,
      description: descriptionController.text,
      bedrooms: int.parse(bedroomController.text),
      bathrooms: int.parse(bathroomController.text),
      kitchens: int.parse(kitchenController.text),
      locationLatitude: double.parse(locationLatitudeController.text),
      locationLongitude: double.parse(locationLongitudeController.text),
      pictures: pictures,
    );
  }

  Future<void> submit() async {
    final bool houseTitleValidate =
        houseTitleKey.currentState?.validate() ?? false;
    final bool houseDescriptionValidate =
        houseDescriptionKey.currentState?.validate() ?? false;
    final bool houseLocationValidate =
        houseLocationKey.currentState?.validate() ?? false;
    final bool houseRoomsValidate =
        houseRoomsKey.currentState?.validate() ?? false;
    final bool housePicturesValidate = pictures.isNotEmpty;
    if (!(houseTitleValidate &&
        houseDescriptionValidate &&
        houseLocationValidate &&
        houseRoomsValidate &&
        housePicturesValidate)) {
      Get.snackbar(
        '',
        '',
        messageText: const Text('Your data in not valid'),
        titleText: const SizedBox(),
      );
      return;
    }
    await publish();
  }

  Future publish() async {
    initHouse();
    house!.municipality = Municipality(id: 1);
    if (!widget.isUpdate) {
      await houseController.createHouse(house!);
    } else {
      await houseController.updateHouseInfo(
        houseId: widget.house!.id!,
        house: house!,
        deletedPictures: deletedPictures,
      );
    }
    Get.back();
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
                title: 'New House',
                backButton: true,
                trailing: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.black54,
                  ),
                  onTap: submit,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    TextFielWithTitle(
                      formKey: houseTitleKey,
                      controller: titleController,
                      title: 'Title',
                      maxChars: 25,
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
                      controller: descriptionController,
                      title: 'Description',
                      maxLines: 10,
                      maxChars: 1000,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    HousePicturePicker(
                      pictures: pictures,
                      onRemove: (pic) {
                        if (pic.isUrl) deletedPictures.add(pic);
                      },
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
              bedroomController,
            ),
            const SizedBox(width: 5),
            numberField(
              'Bathroom',
              bathroomController,
            ),
            const SizedBox(width: 5),
            numberField(
              'Kitchen',
              kitchenController,
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
        child: Form(
          key: houseLocationKey,
          autovalidateMode: AutovalidateMode.always,
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
