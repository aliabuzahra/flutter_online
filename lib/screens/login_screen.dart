import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل الدخول")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "البريد الإلكتروني"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "كلمة المرور"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() => loading = true);
                      try {
                        if (isLogin) {
                          await auth.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        } else {
                          await auth.register(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('❌ ${e.toString()}')),
                        );
                      }
                      setState(() => loading = false);
                    },
                    child: Text(isLogin ? "تسجيل الدخول" : "إنشاء حساب"),
                  ),
            TextButton(
              onPressed: () {
                setState(() => isLogin = !isLogin);
              },
              child:
                  Text(isLogin ? "إنشاء حساب جديد" : "لديك حساب؟ تسجيل الدخول"),
            )
          ],
        ),
      ),
    );
  }
}
