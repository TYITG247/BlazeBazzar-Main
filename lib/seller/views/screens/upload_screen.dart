import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/attributes_tab_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/general_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/shipping_screen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('General'),
              ),
              Tab(
                child: Text('Shipping'),
              ),
              Tab(
                child: Text('Attributes'),
              ),
              Tab(
                child: Text('Images'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GeneralScreen(),
            ShippingScreen(),
            AttributesTabScreen(),
            ImagesTabScreen(),
          ],
        ),
      ),
    );
  }
}
