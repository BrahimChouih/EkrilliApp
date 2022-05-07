import 'dart:io';

import 'package:flutter/material.dart';

import '../helpers/file_helper.dart';
import '../models/picture.dart';
import '../utils/constants.dart';

class HousePicturePicker extends StatefulWidget {
  HousePicturePicker({
    Key? key,
    this.onChange,
  }) : super(key: key);
  final Function(List<Picture>)? onChange;

  @override
  State<HousePicturePicker> createState() => _HousePicturePickerState();
}

class _HousePicturePickerState extends State<HousePicturePicker> {
  List<Picture> pictures = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      primary: false,
      itemCount: pictures.length + 1,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: deepPrimaryColor.withOpacity(0.1),
            borderRadius: borderRadius,
            image: index != pictures.length
                ? pictures[index].isUrl
                    ? DecorationImage(
                        image: NetworkImage(pictures[index].picture),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: FileImage(File(pictures[index].picture)),
                        fit: BoxFit.cover,
                      )
                : null,
          ),
          child: index == pictures.length
              ? InkWell(
                  onTap: () async {
                    String? image = await FilePickerHelper.imagePicker()
                        .then((value) => value);
                    if (image != null) {
                      Picture picture = Picture(picture: image, isUrl: false);
                      pictures.add(picture);
                      if (widget.onChange != null) {
                        widget.onChange!(pictures);
                      }
                      setState(() {});
                    }
                  },
                  child: const Icon(
                    Icons.add,
                    color: deepPrimaryColor,
                  ),
                )
              : Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      pictures.removeAt(index);
                      if (widget.onChange != null) {
                        widget.onChange!(pictures);
                      }

                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
