// features/auth/widgets/otp_input_row.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputRow extends StatefulWidget {
  const OtpInputRow({
    super.key,
    required this.onCompleted,
    required this.onChanged,
  });

  /// Called when all 6 digits are entered.
  final void Function(String otp) onCompleted;

  /// Called on any change with current value (may be partial).
  final void Function(String partial) onChanged;

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  static const _len = 6;

  final _controllers = List.generate(_len, (_) => TextEditingController());
  final _focusNodes  = List.generate(_len, (_) => FocusNode());
  final _values      = List.filled(_len, '');

  String get _otp => _values.join();

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes)  f.dispose();
    super.dispose();
  }

  void _onType(int index, String value) {
    if (value.length > 1) {
      // Paste scenario — distribute across boxes
      _handlePaste(value);
      return;
    }

    _values[index] = value.isEmpty ? '' : value[0];
    widget.onChanged(_otp);

    if (value.isNotEmpty && index < _len - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (_otp.length == _len) {
      widget.onCompleted(_otp);
    }
    setState(() {});
  }

  void _onBackspace(int index) {
    if (_values[index].isNotEmpty) {
      _values[index] = '';
      setState(() {});
      widget.onChanged(_otp);
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
      _values[index - 1] = '';
      setState(() {});
      widget.onChanged(_otp);
    }
  }

  void _handlePaste(String pasted) {
    final digits = pasted.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return;

    for (int i = 0; i < _len; i++) {
      _values[i] = i < digits.length ? digits[i] : '';
      _controllers[i].text = _values[i];
    }
    setState(() {});
    widget.onChanged(_otp);

    if (digits.length >= _len) {
      _focusNodes[_len - 1].requestFocus();
      widget.onCompleted(_otp);
    } else {
      _focusNodes[digits.length.clamp(0, _len - 1)].requestFocus();
    }
  }

  Future<void> _tryPasteFromClipboard(int index) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) _handlePaste(data!.text!);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_len, (i) {
        final isFocused = _focusNodes[i].hasFocus;
        final isFilled  = _values[i].isNotEmpty;

        return GestureDetector(
          onLongPress: () => _tryPasteFromClipboard(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 46,
            height: 54,
            decoration: BoxDecoration(
              color: isFilled
                  ? cs.primary.withOpacity(0.1)
                  : cs.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isFocused
                    ? cs.primary
                    : isFilled
                        ? cs.primary.withOpacity(0.5)
                        : cs.outline.withOpacity(0.25),
                width: isFocused ? 2 : 1.5,
              ),
              boxShadow: isFocused
                  ? [
                      BoxShadow(
                        color: cs.primary.withOpacity(0.2),
                        blurRadius: 8,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: _OtpField(
                controller: _controllers[i],
                focusNode:  _focusNodes[i],
                value:      _values[i],
                onChanged:  (v) => _onType(i, v),
                onBackspace: () => _onBackspace(i),
                theme:      theme,
                cs:         cs,
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ─── Individual invisible text field per box ──────────────────────────────────

class _OtpField extends StatelessWidget {
  const _OtpField({
    required this.controller,
    required this.focusNode,
    required this.value,
    required this.onChanged,
    required this.onBackspace,
    required this.theme,
    required this.cs,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String value;
  final void Function(String) onChanged;
  final VoidCallback onBackspace;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (e) {
          if (e is KeyDownEvent &&
              e.logicalKey == LogicalKeyboardKey.backspace) {
            onBackspace();
          }
        },
        child: TextField(
          controller:   controller,
          focusNode:    focusNode,
          textAlign:    TextAlign.center,
          maxLength:    2, // allow 2 chars briefly for detection
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration:   const InputDecoration(
            counterText: '',
            border:      InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          style: theme.textTheme.titleLarge!.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w800,
          ),
          onChanged: onChanged,
          onTap: () => controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          ),
        ),
      );
}
