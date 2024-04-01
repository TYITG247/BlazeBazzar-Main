import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class InvoiceData {
  final String buyerName;
  final List<InvoiceItem> items;
  final double totalAmount;

  InvoiceData(
      {required this.buyerName,
      required this.items,
      required this.totalAmount});
}

class InvoiceItem {
  final String itemName;
  final int quantity;
  final double price;

  InvoiceItem(
      {required this.itemName, required this.quantity, required this.price});
}

Future<void> generateInvoice(InvoiceData invoiceData) async {
  // PdfDocument pdfDocument = PdfDocument();
  // final page = pdfDocument.pages.add();

  // page.graphics.drawString(
  //   "Invoice",
  //   PdfStandardFont(
  //     PdfFontFamily.helvetica,
  //     36,
  //   ),
  // );
  // page.graphics.drawString(
  //   "Buyer Name: ${invoiceData.buyerName}",
  //   PdfStandardFont(
  //     PdfFontFamily.helvetica,
  //     24,
  //   ),
  // );
  // page.graphics.drawString(
  //   "Items Bought:",
  //   PdfStandardFont(
  //     PdfFontFamily.helvetica,
  //     24,
  //   ),
  // );
  // page.graphics.drawString(
  //   "Invoice",
  //   PdfStandardFont(
  //     PdfFontFamily.helvetica,
  //     24,
  //   ),
  // );
  // page.graphics.drawString(
  //   "Invoice",
  //   PdfStandardFont(
  //     PdfFontFamily.helvetica,
  //     24,
  //   ),
  // );

  // for (var item in invoiceData.items) {
  //   page.graphics.drawString(
  //     "${item.itemName}: ${item.quantity} x Rs. ${item.price.toStringAsFixed(2)}",
  //     PdfStandardFont(
  //       PdfFontFamily.helvetica,
  //       24,
  //     ),
  //   );
  // }

  // page.graphics.drawString(
  //   "Total Amount: Rs. ${invoiceData.totalAmount.toStringAsFixed(2)}",
  //   PdfStandardFont(
  //     PdfFontFamily.helvetica,
  //     24,
  //   ),
  // );

  // List<int> bytes = await pdfDocument.save();
  // pdfDocument.dispose();

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Invoice",
              style: pw.TextStyle(
                fontSize: 36,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "Buyer Name: ${invoiceData.buyerName}",
              style: pw.TextStyle(
                fontSize: 24,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "Items Bought:",
              style: pw.TextStyle(
                fontSize: 24,
              ),
            ),
            for (var item in invoiceData.items)
              pw.Text(
                "${item.itemName}: ${item.quantity} x Rs. ${item.price.toStringAsFixed(2)}",
                style: pw.TextStyle(
                  fontSize: 24,
                ),
              ),
            pw.SizedBox(height: 20),
            pw.Text(
              "Total Amount: Rs. ${invoiceData.totalAmount.toStringAsFixed(2)}",
              style: pw.TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        );
      },
    ),
  );

  // Get downloads directory path
  final downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;

  // Generate a unique filename using current timestamp
  final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  final fileName = 'invoice_$timestamp.pdf';

  // Construct file path
  final filePath = '${downloadsDirectory!.path}/$fileName';

  // Save the PDF to a file
  final file = File(filePath);
  var savedPdf = await pdf.save();
  await file.writeAsBytes(savedPdf, flush: true);
  // await file.writeAsBytes(bytes, flush: true);

  OpenFilex.open(filePath);

  print('Invoice PDF generated at: $filePath');
}
