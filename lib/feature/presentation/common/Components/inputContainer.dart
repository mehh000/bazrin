import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class INPUTCONTAINER extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController passwordController;
  final bool ispass;
  const INPUTCONTAINER({
    super.key,
    required this.label,
    required this.hint,
    required this.passwordController,
    this.ispass = false,
  });

  @override
  State<INPUTCONTAINER> createState() => _INPUTCONTAINERState();
}

class _INPUTCONTAINERState extends State<INPUTCONTAINER> {
  bool password_show = true;

  void _isEYe_open() {
    setState(() {
      password_show = !password_show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      spacing: 4,
      children: [
        Row(children: [SizedBox(width: 18), Text('${widget.label}')]),
        TextField(
          obscureText: widget.ispass ? password_show : widget.ispass,
          controller: widget.passwordController,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:  EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            hintText: "${widget.hint} ",
            filled: true,
            fillColor: Colors.white,
            suffixIcon: widget.ispass
                ? password_show
                      ? IconButton(
                          onPressed: () {
                            _isEYe_open();
                          },
                          icon: Icon(Icons.visibility_off),
                        )
                      : IconButton(
                          onPressed: () {
                            _isEYe_open();
                          },
                          icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                        )
                : SizedBox(),

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFAEB4C2), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFAEB4C2), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
