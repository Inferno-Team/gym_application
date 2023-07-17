import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/gym.dart';
import 'package:gym_application/ui/custom_widget/custom_gym_widget.dart';
import 'package:gym_application/ui/custom_widget/custom_text.dart';
import 'package:gym_application/ui/gyms/gyms_viewmodel.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GymPage extends GetView<GymsController> {
  const GymPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomGym(gym: controller.selectedGym),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: size.height - 400,
            margin: const EdgeInsets.all(20),
            child: MapboxMap(
              styleString: MapboxStyles.MAPBOX_STREETS,
              accessToken:
                  "pk.eyJ1IjoibW9oYW1tZWRpc3NhIiwiYSI6ImNrd2NnajFvaDEycGkydXFsdmRxaW1wNm4ifQ.9isSyfCXqGrAN2-AjM46hA",
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.convertGym2LatLng(controller.selectedGym),
                zoom: 15
              ),
            ),
          )
        ],
      ),
    );
  }
}
