import 'package:d_liv/blocs/auth/auth_bloc.dart';
import 'package:d_liv/blocs/auth/auth_event.dart';
import 'package:d_liv/shared/constants/keys.dart';
import 'package:d_liv/shared/constants/routes.dart';
import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/models/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class OnboardingPageModel {
  final String title;
  final String description;
  final String image;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
    this.bgColor = DLivColors.primary,
    this.textColor = Colors.white
  });
}

class OnboardingPage extends StatefulWidget {

  OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final StorageData _storageData = Get.find<StorageData>();
  late bool isFistTime;
  final PageController _pageController = PageController(initialPage: 0);
  // Store the currently visible page
  late int _currentPage = 0;
  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: 'Envoyez en toute sécurité',
      description:
      'Envoyez vos colis en toute sécurité et suivez-les en temps réel.',
      image: 'assets/images/onboarding/image0.png',
    ),
    OnboardingPageModel(
      title: 'Colis en temps réel',
      description: 'Suivez vos colis en temps réel et soyez informé à chaque étape.',
      image: 'assets/images/onboarding/image1.png',
    ),
    OnboardingPageModel(
      title: 'Enregistrez vos endroits favoris',
      description:
      'Gardez une trace de vos endroits favoris pour une livraison plus rapide.',
      image: 'assets/images/onboarding/image2.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // check if is firstTime
    context.read<AuthBloc>().add(CheckIfIsFirstTime());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              item.image,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme.headlineMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: item.textColor,
                                    ),
                                    textAlign: TextAlign.center
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                      color: item.textColor,
                                    )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pages
                    .map((item) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _currentPage == pages.indexOf(item)
                      ? 20
                      : 4,
                  height: 4,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/onboarding');
                          Get.offAndToNamed(Routes.auth);
                        },
                        child: const Text(
                          "Passer",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                      onPressed: () {
                        if (_currentPage == pages.length - 1) {
                          // This is the last page
                          // Navigator.pushNamed(context, '/onboarding');
                          Get.offAndToNamed(Routes.auth);
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Text(
                        _currentPage == pages.length - 1
                            ? "Commencer"
                            : "Suivant",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}