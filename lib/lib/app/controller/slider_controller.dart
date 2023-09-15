import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/backend/model/slider_model.dart';
import 'package:homeservice/app/backend/parse/slider_parse.dart';

class SliderController extends GetxController implements GetxService {
  final SliderParser parser;
  int current = 0;

  List<Item> imgList = const <Item>[
   Item('assets/images/211.gif', 'Welcome to Freelancer',
        'Become a Service Provider.'),
    Item('assets/images/211.gif', 'Home Service',
        'Get home care services.'),
    Item('assets/images/211.gif', 'Qualified ',
        'Get Experienced freelancers.'),
  ];

  final CarouselController controller = CarouselController();

  SliderController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    update();
  }

  void updateSliderIndex(int index) {
    current = index;
    update();
  }

  void saveLanguage(String code) {
    parser.saveLanguage(code);
    update();
  }
}
