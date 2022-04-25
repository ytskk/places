import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_network_repository.dart';

class DioTestScreen extends StatefulWidget {
  const DioTestScreen({Key? key}) : super(key: key);

  @override
  State<DioTestScreen> createState() => _DioTestScreenState();
}

class _DioTestScreenState extends State<DioTestScreen> {
  @override
  void initState() {
    super.initState();
    parsePlaces();
  }

  Future<void> parsePlaces() async {
    // final response = await PlaceInteractor(
    //   placeRepository: PlaceNetworkRepository(),
    // ).getPlaceDetails(id: 31);

    final response =
        await PlaceInteractor(placeRepository: PlaceNetworkRepository())
            .getPlaces(
      radius: 100000.0,
      types: ['park', 'museum'],
    );

    print('response in ui: ${response.take(3)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dio test'),
      ),
    );
  }
}
