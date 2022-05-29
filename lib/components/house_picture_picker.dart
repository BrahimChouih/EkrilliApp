import 'dart:io';

import 'package:flutter/material.dart';

import '../helpers/file_helper.dart';
import '../models/picture.dart';
import '../utils/constants.dart';

class HousePicturePicker extends StatefulWidget {
  HousePicturePicker({
    Key? key,
    this.onChange,
    this.onRemove,
    this.pictures = const [],
  }) : super(key: key);
  final Function(List<Picture>)? onChange;
  final Function(Picture)? onRemove;
  List<Picture> pictures;

  @override
  State<HousePicturePicker> createState() => _HousePicturePickerState();
}

class _HousePicturePickerState extends State<HousePicturePicker> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      primary: false,
      itemCount: widget.pictures.length + 1,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: deepPrimaryColor.withOpacity(0.1),
            borderRadius: borderRadius,
            image: index != widget.pictures.length
                ? widget.pictures[index].isUrl
                    ? DecorationImage(
                        image: NetworkImage(widget.pictures[index].picture),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: FileImage(File(widget.pictures[index].picture)),
                        fit: BoxFit.cover,
                      )
                : null,
          ),
          child: index == widget.pictures.length
              ? InkWell(
                  onTap: () async {
                    String? image = await FilePickerHelper.imagePicker()
                        .then((value) => value);
                    if (image != null) {
                      Picture picture = Picture(picture: image, isUrl: false);
                      widget.pictures.add(picture);
                      if (widget.onChange != null) {
                        widget.onChange!(widget.pictures);
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
                      if (widget.onRemove != null) {
                        widget.onRemove!(widget.pictures[index]);
                      }
                      widget.pictures.removeAt(index);
                      if (widget.onChange != null) {
                        widget.onChange!(widget.pictures);
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
