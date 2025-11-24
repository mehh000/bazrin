import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class LOGINSCREEN extends StatefulWidget {
  const LOGINSCREEN({super.key});

  @override
  State<LOGINSCREEN> createState() => _LOGINSCREENState();
}

class _LOGINSCREENState extends State<LOGINSCREEN> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  dynamic phoneNumber;

  bool _isSwitched = true;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    if (_isSwitched) {
      phoneNumber = LocalStorage.box.get('usernameorphone') ?? '';
      // usernameController.text = LocalStorage.box.get('usernameorphone') ?? '';
      passwordController.text = LocalStorage.box.get('password') ?? '';
    }
  }

  void login() async {
    setState(() {
      _isloading = true;
    });
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiAddress.HOST_AUTH,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    try {
      final response = await dio.post(
        '/api/auth/login',
        data: {"identifier": phoneNumber, "password": passwordController.text},
      );

      final accessToken = response.data['accessToken'];
      final refreshToken = response.data['refreshToken'];

      await LocalStorage.box.put('accessToken', accessToken);
      await LocalStorage.box.put('refreshToken', refreshToken);
      if (_isSwitched) {
        await LocalStorage.box.put('usernameorphone', phoneNumber);
        await LocalStorage.box.put('password', passwordController.text);
      }

      if (accessToken != null) {
        Navigator.of(context).push(
          SlidePageRoute(
            page: const HomeScreen(),
            direction: SlideDirection.right,
          ),
        );
        setState(() {
          _isloading = false;
        });
        TostMessage.showToast(
          context,
          message: "Login Successfully done",
          isSuccess: true,
        );
      }
    } on DioError catch (e) {
      // print('DioError: ${e.response?.statusCode}');
      // print('Response data: ${e.response?.data}');
      setState(() {
        _isloading = false;
      });
      TostMessage.showToast(
        context,
        message: " ${e.response?.data['identifier']}",
        isSuccess: false,
      );
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      // print('Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Keyboard detection
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // Make status bar icons white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // 🔵 HEADER SECTION
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90),
                  ),
                  color: AppColors.Colorprimary,
                ),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: isKeyboardVisible
                      ? 0.8
                      : 1.0, // shrink when keyboard opens
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const Text(
                        'Welcome to Bazrin',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Create a free account and get full access to all features for 30-days. Get started in 1 minute.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 300,
                        height: isKeyboardVisible
                            ? 80
                            : 120, // shrink image height
                        child: Image.asset(
                          'assets/images/pos-system.png',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //  LOGIN FORM SECTION
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: isKeyboardVisible ? 0.8 : 1.0,
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.Colortext.withOpacity(0.93),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // LOGIN INPUTS
                    Column(
                      children: [
                        PhoneInputWidget(
                          isBoldText: false,
                          label: "Email or phone number",
                          insialNumber: phoneNumber,
                          phonecontrollerl: phonecontroller,
                          data: (e) {
                            setState(() {
                              phoneNumber = e;
                            });
                          },
                        ),

                        const SizedBox(height: 10),
                        INPUTCONTAINER(
                          label: 'Password',
                          hint: 'Enter password',
                          passwordController: passwordController,
                          ispass: true,
                        ),

                        // Remember + Forgot
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.5,
                                  child: Switch(
                                    value: _isSwitched,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _isSwitched = newValue;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    activeTrackColor: AppColors.Colorprimary,
                                    inactiveThumbColor: Colors.black,
                                    inactiveTrackColor: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: ButtonEv(
                            title: 'Login',
                            colorData: AppColors.Colorprimary,
                            buttonFunction: login,
                            isloading: _isloading,
                          ),
                        ),
                      ],
                    ),

                    // Divider with "or"
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 1.5,
                            color: const Color(0xFFE5E5E5),
                          ),
                        ),
                        const Text(
                          'or',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9C9CA4),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 1.5,
                            color: const Color(0xFFE5E5E5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Social icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icons/google.png',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          'assets/images/icons/fb.png',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          'assets/images/icons/wa.png',
                          width: 18,
                          height: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Bio Auth icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/icons/face.svg'),
                        const SizedBox(width: 40),
                        SvgPicture.asset('assets/images/icons/finger.svg'),
                      ],
                    ),

                    // const SizedBox(height: 35),
                    // Center(
                    //   child: Text(
                    //     'Copyright © 2025. All rights reserved.',
                    //     style: TextStyle(
                    //       fontSize: 9,
                    //       fontWeight: FontWeight.w300,
                    //       color: Colors.blue,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
