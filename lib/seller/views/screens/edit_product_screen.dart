import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/seller/views/screens/edit_products_tabs/published_tab.dart';
import 'package:blazebazzar/seller/views/screens/edit_products_tabs/unpublished_tab.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          title: Text(
            "Manage Products",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text("Published"),
              ),
              Tab(
                child: Text("UnPublished"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedTab(),
            UnPublishedTab(),
          ],
        ),
      ),
    );
  }
}
