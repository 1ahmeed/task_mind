import 'package:intl/intl.dart';


String? token;


bool checkArabic() {
  return Intl.getCurrentLocale() == 'ar';
}