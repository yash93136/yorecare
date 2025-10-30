import 'package:adminpanel/add.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  // Animation Controllers
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _titleScale;
  late Animation<Offset> _usernameSlide;
  late Animation<Offset> _passwordSlide;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();

    // Master Controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    // 1. Title: Fall + Bounce + Scale
    _titleSlide = Tween<Offset>(begin: Offset(0, -3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.bounceOut)),
    );
    _titleScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.elasticOut)),
    );

    // 2. Username: Slide from Left
    _usernameSlide = Tween<Offset>(begin: Offset(-1.5, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.7, curve: Curves.easeOutBack)),
    );

    // 3. Password: Slide from Right
    _passwordSlide = Tween<Offset>(begin: Offset(1.5, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.8, curve: Curves.easeOutBack)),
    );

    // 4. Button: Scale + Pulse
    _buttonScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.7, 1.0, curve: Curves.elasticOut)),
    );

  _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.3, 1.0)),
    );

    // Start Animation
    Future.delayed(Duration(milliseconds: 400), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Image.asset(
              'assets/logo.jpg', 
              width: 150,
              height: 100,
            ),
            SizedBox(height: 20),
                // 1. TITLE: Girta hua + Scale
                SlideTransition(
                  position: _titleSlide,
                  child: ScaleTransition(
                    scale: _titleScale,
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                        fontFamily: 'Montserrat',
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(offset: Offset(0, 4), blurRadius: 10, color: Colors.black26),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // FORM CARD
                FadeTransition(
                  opacity: _fade,
                  child: Container(
                    padding: const EdgeInsets.all(28.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 8,
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 2. USERNAME: Left se aayega
                          SlideTransition(
                            position: _usernameSlide,
                            child: TextFormField(
                              controller: _usernameController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                hintText: 'Enter your username',
                                prefixIcon: Icon(Icons.person, color: Colors.blueGrey[700]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.blueGrey[50],
                                contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                              ),
                              validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(height: 22),

                          // 3. PASSWORD: Right se aayega
                          SlideTransition(
                            position: _passwordSlide,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                prefixIcon: Icon(Icons.lock, color: Colors.blueGrey[700]),
                                suffixIcon: IconButton(
                                  icon: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
                                    child: Icon(
                                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                      key: ValueKey(_obscurePassword),
                                      color: Colors.blueGrey[600],
                                    ),
                                  ),
                                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.blueGrey[50],
                                contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                              ),
                              validator: (v) => v!.isEmpty ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // 4. LOGIN BUTTON: Scale + Pulse
                          ScaleTransition(
                            scale: _buttonScale,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) => BlazeAdminDashboard()),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.deepPurple,
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  elevation: 8,
                                  shadowColor: Colors.deepPurple.withOpacity(0.4),
                                ),
                                child: Text('LOGIN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ),
                ),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}