import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sibagjaapps/utils/wrappers/mainwrapper.dart';
import 'package:sibagjaapps/views/Billing/billingContainer.dart';
import 'package:sibagjaapps/views/home/homes.dart';
import 'package:sibagjaapps/views/login/V_login.dart';
import 'package:sibagjaapps/views/patients/add_patients.dart';
import 'package:sibagjaapps/views/rekam_medis/components/DetailsPatients.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/FormCTD/CatatanDokter.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/FormPKP/Formspengkajian.dart';

import 'package:sibagjaapps/views/rekam_medis/mainRM.dart';
import 'package:sibagjaapps/views/Billing/billingPages.dart';

import 'package:sibagjaapps/views/Billing/keuanganViews.dart';
import 'package:sibagjaapps/views/splashscreens/splashscreens.dart';

import '../../views/home/children/subhomes.dart';
import '../../views/Billing/masterbiaya.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = "/";

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');
  static final _shellNavigatorPatients =
      GlobalKey<NavigatorState>(debugLabel: 'shellPatients');
        static final _shellNavigatorRM =
      GlobalKey<NavigatorState>(debugLabel: 'shellPatientsz');
       static final _shellNavigatorctd =
      GlobalKey<NavigatorState>(debugLabel: 'catatan');
  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
  
    routes: [
      /// MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          /// Brach Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: "Home",
                 pageBuilder: (context, state) => CustomTransitionPage<void>(
                      
                      child:     HomeView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                routes: [
                  GoRoute(
                    path: 'subHome',
                    name: 'subHome',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child:  SubHomeView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// Brach Setting
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettings,
            routes: <RouteBase>[
              GoRoute(
                path: "/settings",
                name: "Settings",
                builder: (BuildContext context, GoRouterState state) =>
                    const BillingContainer(),
                routes: [
                  GoRoute(
                    path: "keuangan",
                    name: "keuangan",
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const KeuanganModules(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      );

                      
                    },
                  ),

                           GoRoute(
                    path: "checkout/:idtagihan",
                    name: "checkout",
                    pageBuilder: (context, state) {
                       final String idtagihan = state.pathParameters['idtagihan'] ?? '';
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child:           CheckoutPage(idTagihan: idtagihan,),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                      
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _shellNavigatorPatients,
            routes: <RouteBase>[
              GoRoute(
                path: "/patients",
                name: "Patients",
                pageBuilder: (context, state) {
             
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child:  AddPatients(norekam: '-',),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
               
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _shellNavigatorRM,
            routes: <RouteBase>[
              GoRoute(
                path: "/rekamMedis",
                name: "rekamMedis",
                pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child:  MainRekam(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                routes: [
              GoRoute(
                path: 'detailsPatient/:data',
                name: 'detailsPatient',
                pageBuilder: (context, state) {
                  final rm = state.pathParameters['data'] ?? '';
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: DetailsPatient(rm: rm),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  );
                },
              ),
                   GoRoute(
                    path: 'pengkajianPsikiater/:data/:idrequest',
                    name: 'pengkajianPsikiater',
                    pageBuilder: (context, state) {
    final rm = state.pathParameters['data'] ?? '';
   final idForms = state.pathParameters['idrequest'] ?? '';
      return  CustomTransitionPage<void>(
                      
                      key: state.pageKey,
                      child:  PengkajianPsikiater(Norekam:rm, IdForms: idForms,),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    );
                    } 
                  ),

                   GoRoute(
                    path: 'CatatanDokkter/:data/:idrequest/:name/:date',
                    name: 'CatatanDokkter',
                    pageBuilder: (context, state) {
    final rm = state.pathParameters['data'] ?? '';
    final idForms = state.pathParameters['idrequest'] ?? '';
    final name = state.pathParameters['name'] ?? '';
    final date = state.pathParameters['date'] ?? '';
      return  CustomTransitionPage<void>(
                      
                      key: state.pageKey,
                      child:  CatatanDokter(rm: rm, name: name, idforms: idForms, date:date,),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    );
                    } 
                  ),

                  GoRoute(
                path: 'editUsers/:norekam',
                name: 'editUsers',
                pageBuilder: (context, state) {
                  final rm = state.pathParameters['norekam'] ?? '';
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: AddPatients(norekam: rm),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  );
                },
              ),
                ],
              ),
            ],
          )
        ],
      ),


GoRoute(path: '/',builder: (BuildContext context, GoRouterState state)  {

  return  SplashScreens();
},)
      
    ],
  );
}