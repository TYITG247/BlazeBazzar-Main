import 'package:blazebazzar/buyers/views/authentication/login_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/seller/views/authentication/seller_authentication_screen.dart';

class SwitchScreen extends StatelessWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: FlexColor.pinkM3LightPrimary,
            toolbarHeight: 550,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlexColor.redLightPrimary,
                        FlexColor.mandyRedLightPrimary,
                      ],
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 50),
                        child: Text(
                          "Hello, ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          "Choose what To Be?",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Gap(15),
                    ],
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(50),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                        color: FlexColor.mandyRedLightPrimary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Buyer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SellerAuthenticationScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: const Border(
                            top: BorderSide(),
                            bottom: BorderSide(),
                            right: BorderSide(),
                            left: BorderSide(),
                          )),
                      child: Center(
                        child: Text(
                          "Seller",
                          style: TextStyle(
                            color: FlexColor.mandyRedLightPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
