import 'package:go_router/go_router.dart';

class G {
  
 static R(context,routes){
     GoRouter.of(context).go(routes);
  }
}