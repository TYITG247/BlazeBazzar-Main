import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerWidget extends StatefulWidget {
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List _bannerImage = [];

  getBanners() {
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImage.add(doc['image']);
        });
      });
    });
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: FlexColor.mandyRedLightPrimaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: PageView.builder(
        itemCount: _bannerImage.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: _bannerImage[index],
              placeholder: (context, url) => Shimmer(
                duration: Duration(seconds: 3),
                interval:
                    Duration(seconds: 5),
                color: FlexColor.mandyRedLightPrimary,
                colorOpacity: 0,
                enabled: true,
                direction: ShimmerDirection.fromLTRB(), //Default Value
                child: Container(
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
