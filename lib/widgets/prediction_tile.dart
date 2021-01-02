import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/data_models/address.dart';
import 'package:cab_rider/data_models/prediction.dart';
import 'package:cab_rider/data_provider/app_data.dart';
import 'package:cab_rider/globalvariable.dart';
import 'package:cab_rider/helpers/request_helper.dart';
import 'package:cab_rider/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;

  PredictionTile({this.prediction});

  void getPlaceDetails(String placeID, context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Please wait...',
            ));
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$mapKey';
    var response = await RequestHelper.getRequest(url);
    Navigator.pop(context);
    if (response == 'failed') {
      return;
    }
    if (response['status'] == 'OK') {
      Address thisPlace = Address();
      thisPlace.placeId = placeID;
      thisPlace.placeName = response['result']['name'];
      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];
      thisPlace.placeFormattedAddress = response['result']['formatted_address'];
      Provider.of<AppData>(context, listen: false)
          .updateDestinationAddress(thisPlace);
      print(thisPlace);
      Navigator.pop(context, 'getDirection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => getPlaceDetails(prediction.placeId, context),
      padding: EdgeInsets.all(0),
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Icon(OMIcons.locationOn, color: BrandColors.colorDimText),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(prediction.mainText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 2),
                      Text(
                        prediction.secondaryText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12, color: BrandColors.colorDimText),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
