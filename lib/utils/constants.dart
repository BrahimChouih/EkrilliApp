import 'dart:ui';

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff3CCEA5);
const Color deepPrimaryColor = Color(0xff28745F);
// const Color backgroundColor = Color(0xffF5FFFC);
const Color backgroundColor = Color(0xffFFFFFF);
const picturesHeight = 260.0;
BorderRadius borderRadius = BorderRadius.circular(15);

ImageFilter blurEffect = ImageFilter.blur(
  sigmaX: 5,
  sigmaY: 5,
);

/// offer status
const statusPublished = 'PUBLISHED';
const statusWaittingForAccepte = 'WAITING_FOR_ACCEPTE';
const statusRented = 'RENTED';
const statusDone = 'DONE';

/// message type
const messageTypeRequest = 'REQUEST';
const messageTypeResponse = 'RESPONSE';

/// message content type
const messageContentTypeMessage = 'MESSAGE';
const messageContentTypeAction = 'ACTION';
const messageContentTypeOfferInfo = 'OFFER_INFO';
const messageContentTypeImage = 'IMAGE';

//// date format
const dateTimeFormat = "yyyy/MM/dd – HH:mm";
