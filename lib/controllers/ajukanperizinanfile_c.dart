import 'package:http/http.dart' as http;

class AjukanPerizinanFileC {
  Future<void> uploadDokumen(dynamic dokumen) async {
    try {
      // Assuming `dokumen` is a File object
      http.MultipartFile file = await http.MultipartFile.fromPath(
        'file',
        dokumen,
      );

      // Add your API endpoint and other necessary headers
      var uri = Uri.parse('YOUR_API_ENDPOINT_HERE');
      var request = http.MultipartRequest('POST', uri)..files.add(file);

      // You can add more fields if needed, for example:
      // request.fields['additionalField'] = 'value';

      // Send the request
      var response = await http.Response.fromStream(await request.send());

      // Handle the response
      if (response.statusCode == 200) {
        print('Document uploaded successfully');
        print('Response: ${response.body}');
      } else {
        print('Error uploading document. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
        // Handle the error as needed
      }
    } catch (e) {
      print('Error uploading document: $e');
      // Handle the error as needed
    }
  }
}
