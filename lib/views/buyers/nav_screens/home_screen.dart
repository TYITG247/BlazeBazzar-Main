import 'package:blazebazzar/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:blazebazzar/views/buyers/nav_screens/widgets/category_text.dart';
import 'widgets/search_input_widget.dart';
import 'widgets/welcome_text_widget.dart';
import 'package:blazebazzar/config/app_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 15,
        right: 15,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeText(),
            const Gap(10),
            const SearchInputWidget(),
            BannerWidget(),
            CategoryText(),
          ],
        ),
      ),
    );
  }
}
