import 'package:blazebazzar/config/app_ui.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Shopping Cart is Empty",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(15),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: FlexColor.mandyRedLightPrimary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "Continue Shopping",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
