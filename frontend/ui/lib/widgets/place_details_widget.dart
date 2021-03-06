import 'package:flutter/material.dart';
import 'package:tripmeout/model/place.dart';
import 'package:tripmeout/widgets/contact_info_widget.dart';

class PlaceDetailsWidget extends StatelessWidget {
  PlaceWrapper details;

  PlaceDetailsWidget(this.details);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Row(children: formatTypes(details.types)),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContactInfoWidget(details),
          Row(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Row(children: getDollarSigns(details.priceLevel)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Row(children: getStars(details.rating)),
            ),
          ]),
        ],
      ),
      Container(
        height: 450,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: getPhotos(details.photos),
        ),
      ),
    ]);
  }

  List<Widget> getDollarSigns(num numSigns) {
    if (numSigns == null) {
      return [Text('no price info found')];
    }
    List<Icon> dollarSigns = [];
    while (numSigns > 0) {
      dollarSigns.add(Icon(Icons.attach_money, color: Colors.green));
      numSigns--;
    }
    return dollarSigns;
  }

  List<Widget> getStars(num numStars) {
    if (numStars == null) {
      return [Text('no ratings found')];
    }
    num originalNumStars = numStars;
    int totalStars = 5;
    List<Widget> stars = [];
    while (numStars > 1) {
      stars.add(Icon(Icons.star, color: Colors.amber));
      numStars--;
      totalStars--;
    }
    if (numStars > 0.25 && numStars < 0.75) {
      stars.add(Icon(Icons.star_half, color: Colors.amber));
      totalStars--;
    } else if (numStars >= 0.75) {
      stars.add(Icon(Icons.star, color: Colors.amber));
      totalStars--;
    }

    while (totalStars > 0) {
      stars.add(Icon(Icons.star_border, color: Colors.amber));
      totalStars--;
    }

    stars.add(Text(originalNumStars.toStringAsFixed(1)));

    return stars;
  }

  List<Widget> formatTypes(List<String> types) {
    List<Text> formattedTypes = [];
    for (int i = 0; i < types.length; i++) {
      String type;
      if (i == types.length - 1) {
        type = types[i];
      } else {
        type = types[i] + ", ";
      }
      formattedTypes.add(Text(
        type,
        style: TextStyle(fontStyle: FontStyle.italic),
      ));
    }
    return formattedTypes;
  }

  List<Widget> getPhotos(List<String> photos) {
    List<Widget> imageWidgets = [];
    for (int i = 0; i < photos.length; i++) {
      imageWidgets.add(Card(child: Image(image: NetworkImage(photos[i]))));
    }
    return imageWidgets;
  }
}
