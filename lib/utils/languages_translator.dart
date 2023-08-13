import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageTranslator extends Translations {
  final Map<String, Map<String, String>> _keys = {
    "ar_SY": {
      Keys.LANGUAGE.name: 'English',
      Keys.LOGIN.name: 'تسجيل الدخول',
      Keys.REGISER.name: 'تسجيل الحساب',
      Keys.Email.name: 'بريد الكتروني',
      Keys.Name.name: 'اسم',
      Keys.Phone.name: 'رقم الهاتف (اختياري)',
      Keys.Password.name: 'كلمة المرور',
      Keys.NOT_CUSTOMER.name:
          "هذا الحساب ليس حساب مستخدم يرجى استخدام الموقع بدل من التطبيق",
      Keys.App_Name.name: "تطبيق النوادي",
      Keys.Gyms.name: "النوادي",
      Keys.My_diets.name: "حمياتي",
      Keys.Diets.name: "الحميات",
      Keys.TOGGLE_LANGUAGE.name: "اللغة",
      Keys.Logout.name: "تسجيل الخروج",
      Keys.MYLOCATION.name: "موقعي",
      Keys.ItemCount.name: "عدد العناصر",

      Keys.Id.name: "رقم تسلسلي",
      Keys.Ingredient.name: "مكون",
      Keys.Quantity.name: "الكمية",
      Keys.No_Fav.name: "يجب ان تقوم بالاعجاب ببعض الحميات والمحاولة لاحقا.",
      Keys.MySubscriptions.name: "اشتراكاتي",
      Keys.Attend.name: "تسجيل حضور",
      Keys.Active.name: "فعال",
      Keys.Not_Active.name: "غير فعال",
    },
    "en_US": {
      Keys.LANGUAGE.name: 'العربية',
      Keys.LOGIN.name: 'Login',
      Keys.REGISER.name: 'Register',
      Keys.Email.name: 'Email',
      Keys.Name.name: 'Name',
      Keys.Phone.name: 'Phone (Optional)',
      Keys.Password.name: 'Password',
      Keys.NOT_CUSTOMER.name: "you are not a customer please use our website.",
      Keys.App_Name.name: 'Gym Application',
      Keys.Gyms.name: 'Gyms',
      Keys.My_diets.name: 'My diets',
      Keys.Diets.name: 'Diets',
      Keys.TOGGLE_LANGUAGE.name: 'Language',
      Keys.Logout.name: 'Logout',
      Keys.MYLOCATION.name: 'My Location',
      Keys.ItemCount.name: "Item Count",
      Keys.Id.name: "Id",
      Keys.Ingredient.name: "Ingredient",
      Keys.Quantity.name: "Quantity",
      Keys.No_Fav.name: "You need to add some diets to your favourite and try again.",
      Keys.MySubscriptions.name: "My Subscriptions",
      Keys.Attend.name: "Attend",
      Keys.Active.name: "Active",
      Keys.Not_Active.name: "Not Active",

    }
  };

  @override
  Map<String, Map<String, String>> get keys => _keys;
}

enum Keys {
  LANGUAGE,
  TOGGLE_LANGUAGE,
  LOGIN,
  REGISER,
  Email,
  Phone,
  Name,
  Password,
  NOT_CUSTOMER,
  App_Name,
  Gyms,
  My_diets,
  Diets,
  Logout,
  MYLOCATION,
  ItemCount,
  Id,
  Ingredient,
  Quantity,
  No_Fav,
  MySubscriptions,
  Attend,
  Active,
  Not_Active
}
