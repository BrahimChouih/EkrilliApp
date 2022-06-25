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

  var titleKey = GlobalKey<FormState>(
    debugLabel: 'titleKey',
  );

  var descriptionKey = GlobalKey<FormState>(
    debugLabel: 'descriptionKey',
  );

  var locationKey = GlobalKey<FormState>(
    debugLabel: 'locationKey',
  );

  var roomsKey = GlobalKey<FormState>(
    debugLabel: 'roomsKey',
  );

  var cityKey = GlobalKey<FormState>(
    debugLabel: 'cityKey',
  );

  var municipalityKey = GlobalKey<FormState>(
    debugLabel: 'municipalityKey',
  );

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController municipalityController = TextEditingController();
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
      municipality = widget.house!.municipality;
      city = widget.house!.municipality!.city;
      municipalityController.text = widget.house!.municipality!.name!;
      cityController.text = widget.house!.municipality!.city!.name!;
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
      municipality: municipality,
      pictures: pictures,
    );
  }

  Future<void> submit() async {
    final bool titleValidate = titleKey.currentState?.validate() ?? false;
    final bool descriptionValidate =
        descriptionKey.currentState?.validate() ?? false;
    final bool locationValidate = locationKey.currentState?.validate() ?? false;
    final bool roomsValidate = roomsKey.currentState?.validate() ?? false;
    final bool cityValidate = cityKey.currentState?.validate() ?? false;
    final bool municipalityValidate =
        municipalityKey.currentState?.validate() ?? false;
    final bool picturesValidate = pictures.isNotEmpty;
    if (!(titleValidate &&
        descriptionValidate &&
        locationValidate &&
        roomsValidate &&
        cityValidate &&
        municipalityValidate &&
        picturesValidate)) {
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
                      formKey: titleKey,
                      controller: titleController,
                      title: 'Title',
                      maxChars: 25,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      child: addressInput(),
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
                      formKey: descriptionKey,
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
        key: roomsKey,
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

  Widget addressInput() => Form(
        // key: addressKey,
        autovalidateMode: AutovalidateMode.always,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addressField<City>(
              "City",
              cityController,
              formKey: cityKey,
              items: houseController.cities,
              onSelected: (value) {
                if (city == null || value.id != city!.id) {
                  city = value;
                  cityController.text = value.name!;
                  municipality = null;
                  municipalityController.text = '';
                  houseController.getMunicipalities(cityId: city!.id!);
                }
              },
            ),
            SizedBox(width: Get.width * 0.05),
            GetBuilder<HouseController>(
              id: houseController.municipalitiesId,
              builder: (context) => addressField<Municipality>(
                "Municipality",
                municipalityController,
                formKey: municipalityKey,
                items: houseController.municipalities,
                enabled: city != null,
                onSelected: (value) {
                  municipality = value;
                  municipalityController.text = value.name!;
                },
              ),
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
          key: locationKey,
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

  Widget addressField<T>(
    String title,
    TextEditingController controller, {
    Function(T)? onSelected,
    required List<T> items,
    bool enabled = true,
    GlobalKey? formKey,
  }) =>
      Expanded(
        child: IgnorePointer(
          ignoring: !enabled,
          child: PopupMenuButton<T>(
            itemBuilder: (BuildContext context) => items
                .map(
                  (e) => PopupMenuItem<T>(
                    value: e,
                    child: Text(e.toString()),
                  ),
                )
                .toList(),
            onSelected: onSelected,
            child: IgnorePointer(
              ignoring: true,
              child: TextFielWithTitle(
                title: title,
                controller: controller,
                formKey: formKey,
                textInputType: TextInputType.number,
                validator: (value) {
                  // if (readOnly) return null;
                  if (value == null || value == '') {
                    return '';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );
}
