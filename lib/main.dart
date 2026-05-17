import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Flow Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2F55CF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00D389)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/onboarding1': (context) => const OnboardingPage(
              title: 'Enjoy a seamless\nexperience.',
              nextRoute: '/onboarding2',
            ),
        '/onboarding2': (context) => const OnboardingPage(
              title: 'Simplify your\ndaily life.',
              nextRoute: '/onboarding3',
            ),
        '/onboarding3': (context) => const OnboardingPage(
              title: 'Access benefits.',
              nextRoute: '/welcome',
            ),
        '/welcome': (context) => const WelcomePage(),
        '/register': (context) => const RegisterPage(),
        '/verify': (context) => const VerifyPage(),
        '/prefs': (context) => const PreferencesPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    this.title,
  });

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 320,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF2F55CF),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/onboarding1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      child: Column(
        children: [
          CircularProgressIndicator(color: Color(0xFF00D389)),
          SizedBox(height: 20),
          Text(
            'Please wait...',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.nextRoute,
  });

  final String title;
  final String nextRoute;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D389),
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, nextRoute),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Welcome',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D389),
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text('Login'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF122A80),
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        '/verify',
        arguments: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InputTitle('Username'),
            _CustomField(
              controller: _usernameController,
              hintText: 'name',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username kiriting';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            _InputTitle('Password'),
            _CustomField(
              controller: _passwordController,
              hintText: '******',
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Kamida 6 ta belgi';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            _InputTitle('Email'),
            _CustomField(
              controller: _emailController,
              hintText: 'name@email.com',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return 'To\'g\'ri email kiriting';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF122A80),
                foregroundColor: Colors.white,
              ),
              onPressed: _goNext,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = (ModalRoute.of(context)?.settings.arguments as String?) ??
        'your email';

    return AppShell(
      child: Column(
        children: [
          const Text(
            'We sent you a link.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            email,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Resend',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D389),
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, '/prefs'),
            child: const Text('Go to Preferences'),
          ),
        ],
      ),
    );
  }
}

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final List<bool> _selected = List.generate(8, (_) => false);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Choose your\npreferences',
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: GridView.builder(
              itemCount: _selected.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final isOn = _selected[index];
                return GestureDetector(
                  onTap: () => setState(() => _selected[index] = !isOn),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isOn ? Colors.white : Colors.white54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D389),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      child: Center(
        child: Icon(Icons.home_rounded, color: Colors.white, size: 90),
      ),
    );
  }
}

class _InputTitle extends StatelessWidget {
  const _InputTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

class _CustomField extends StatelessWidget {
  const _CustomField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    );
  }
}
