import 'package:latlong2/latlong.dart';

class GasStation {
  final LatLng location;
  final String address, image, name;
  final double price;

  GasStation(
      {required this.image,
      required this.name,
      required this.price,
      required this.address,
      required this.location});
}

List<GasStation> gasStations = [
  GasStation(
      name: 'SPKLU Trunojoyo',
      location: const LatLng(-6.2437078, 106.783587),
      price: 1380,
      image: 'assets/1.jpeg',
      address: 'Jl. Trunojoyo No.135, RT.6/RW.2, Melawai, Kebayoran Baru'),
  GasStation(
      name: 'SPKLU Gambir',
      location: const LatLng(-6.1805417, 106.8301407),
      image: 'assets/2.jpeg',
      price: 1400,
      address: '7, RT.7/RW.1, Gambir, Central Jakarta City, Jakarta 10110'),
  GasStation(
      name: 'SPKLU Tebet',
      location: const LatLng(-6.2422038, 106.8525117),
      image: 'assets/3.jpeg',
      price: 1500,
      address: 'Jl. Tebet Bar., RT.10/RW.5, Tebet Bar., Kec. Tebet 12810'),
  GasStation(
      name: 'EVCuzz Charging Station',
      location: const LatLng(-6.2214197, 106.8125567),
      image: 'assets/4.jpeg',
      price: 1700,
      address: 'Jl. Gatot Subroto No.1, RT.1/RW.4, Karet Semanggi 12930'),
  GasStation(
      name: 'Senayan EV Charging Station',
      location: const LatLng(-6.2246824, 106.8039709),
      image: 'assets/5.jpeg',
      price: 1800,
      address:
          'Sequis Center, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan 12190')
];
