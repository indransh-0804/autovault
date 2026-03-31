import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/data/models/purchase_model.dart';
import 'package:autovault/features/purchase/providers/purchase_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/add_on_model.dart';

class SaleDetailsStep extends ConsumerStatefulWidget {
  const SaleDetailsStep({super.key});

  @override
  ConsumerState<SaleDetailsStep> createState() => _SaleDetailsStepState();
}

class _SaleDetailsStepState extends ConsumerState<SaleDetailsStep> {
  final _discountCtr = TextEditingController();
  final _downPayCtr = TextEditingController();
  final _customNameCtr = TextEditingController();
  final _customPriceCtr = TextEditingController();
  bool _showCustomForm = false;

  @override
  void dispose() {
    _discountCtr.dispose();
    _downPayCtr.dispose();
    _customNameCtr.dispose();
    _customPriceCtr.dispose();
    super.dispose();
  }

  void _addCustomAddOn() {
    final name = _customNameCtr.text.trim();
    final price = double.tryParse(_customPriceCtr.text.trim()) ?? 0;
    if (name.isEmpty || price <= 0) return;

    ref.read(purchaseFormNotifierProvider.notifier).addCustomAddOn(
          AddOnModel(
            id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
            name: name,
            price: price,
            isCustom: true,
          ),
        );
    _customNameCtr.clear();
    _customPriceCtr.clear();
    setState(() => _showCustomForm = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final form = ref.watch(purchaseFormNotifierProvider);
    final notifier = ref.read(purchaseFormNotifierProvider.notifier);

    // Merge predefined + custom add-ons for display
    final allAddOns = [
      ...predefinedAddOns,
      ...form.selectedAddOns.where((a) => a.isCustom),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section A: Add-ons ─────────────────────────────────────────
        _SectionTitle('A  Add-ons & Accessories', theme, cs),
        const SizedBox(height: 8),
        ...allAddOns.map((addOn) {
          final checked = form.selectedAddOns.any((a) => a.id == addOn.id);
          return _AddOnRow(
            addOn: addOn,
            checked: checked,
            onChanged: (_) => notifier.toggleAddOn(addOn),
            theme: theme,
            cs: cs,
          );
        }),
        const SizedBox(height: 8),

        // Custom add-on form
        if (_showCustomForm) ...[
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _customNameCtr,
                  decoration: _fieldDeco(cs, 'Item name'),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _customPriceCtr,
                  decoration: _fieldDeco(cs, '₹ Price'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.check_circle_rounded, color: cs.primary),
                onPressed: _addCustomAddOn,
              ),
              IconButton(
                icon: Icon(Icons.cancel_outlined,
                    color: cs.onSurface.withOpacity(0.4)),
                onPressed: () => setState(() => _showCustomForm = false),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],

        TextButton.icon(
          onPressed: () => setState(() => _showCustomForm = true),
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('Add Custom Item'),
          style: TextButton.styleFrom(
            foregroundColor: cs.primary,
            padding: EdgeInsets.zero,
          ),
        ),

        const SizedBox(height: 20),
        _Divider(cs),
        const SizedBox(height: 20),

        // ── Section B: Discount ────────────────────────────────────────
        _SectionTitle('B  Discount', theme, cs),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Apply Discount', style: theme.textTheme.bodyMedium),
            Switch(
              value: form.discountEnabled,
              onChanged: notifier.setDiscountEnabled,
            ),
          ],
        ),

        if (form.discountEnabled) ...[
          const SizedBox(height: 10),
          // Segmented control: Flat / Percentage
          Row(
            children: [
              _SegmentBtn(
                label: 'Flat Amount',
                selected: form.discountType == DiscountType.flat,
                onTap: () => notifier.setDiscountType(DiscountType.flat),
                cs: cs,
                theme: theme,
              ),
              const SizedBox(width: 8),
              _SegmentBtn(
                label: 'Percentage',
                selected: form.discountType == DiscountType.percentage,
                onTap: () => notifier.setDiscountType(DiscountType.percentage),
                cs: cs,
                theme: theme,
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _discountCtr,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            ],
            onChanged: (v) =>
                notifier.setDiscountValue(double.tryParse(v) ?? 0),
            decoration: _fieldDeco(
              cs,
              form.discountType == DiscountType.flat
                  ? 'Discount amount (₹)'
                  : 'Discount percentage (%)',
            ),
          ),
          if (form.discountAmount > 0) ...[
            const SizedBox(height: 6),
            Text(
              'Discount: ${inrFormatter.format(form.discountAmount)}',
              style: theme.textTheme.bodySmall!.copyWith(
                color: const Color(0xFF4CAF50),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],

        const SizedBox(height: 20),
        _Divider(cs),
        const SizedBox(height: 20),

        // ── Section C: Payment Method ──────────────────────────────────
        _SectionTitle('C  Payment Method', theme, cs),
        const SizedBox(height: 12),

        _PaymentMethodCard(
          icon: Icons.payments_outlined,
          title: 'Full Payment',
          subtitle: 'Customer pays the full amount today',
          selected: form.paymentMethod == PaymentMethod.fullPayment,
          onTap: () => notifier.setPaymentMethod(PaymentMethod.fullPayment),
          cs: cs,
          theme: theme,
        ),
        const SizedBox(height: 10),
        _PaymentMethodCard(
          icon: Icons.account_balance_outlined,
          title: 'Loan / EMI',
          subtitle: 'Customer pays via financing — configure in next step',
          selected: form.paymentMethod == PaymentMethod.loan,
          onTap: () => notifier.setPaymentMethod(PaymentMethod.loan),
          cs: cs,
          theme: theme,
        ),
        const SizedBox(height: 10),
        _PaymentMethodCard(
          icon: Icons.call_split_rounded,
          title: 'Part Payment',
          subtitle: 'Customer pays a portion now, remainder via loan',
          selected: form.paymentMethod == PaymentMethod.partPayment,
          onTap: () => notifier.setPaymentMethod(PaymentMethod.partPayment),
          cs: cs,
          theme: theme,
        ),

        // Down payment field for Part Payment
        if (form.paymentMethod == PaymentMethod.partPayment) ...[
          const SizedBox(height: 14),
          TextField(
            controller: _downPayCtr,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            ],
            onChanged: (v) => notifier.setDownPayment(double.tryParse(v) ?? 0),
            decoration: _fieldDeco(cs, 'Down Payment Amount (₹)'),
          ),
          if (form.downPayment > 0) ...[
            const SizedBox(height: 6),
            Text(
              'Loan Amount: ${inrFormatter.format(form.loanAmount)}',
              style: theme.textTheme.bodySmall!.copyWith(
                color: const Color(0xFF1E88E5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],

        const SizedBox(height: 16),
      ],
    );
  }

  InputDecoration _fieldDeco(ColorScheme cs, String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: cs.surfaceVariant.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outline.withOpacity(0.2)),
        ),
      );
}

// ─── Add-on row ───────────────────────────────────────────────────────────────

class _AddOnRow extends StatelessWidget {
  const _AddOnRow({
    required this.addOn,
    required this.checked,
    required this.onChanged,
    required this.theme,
    required this.cs,
  });
  final AddOnModel addOn;
  final bool checked;
  final void Function(bool?) onChanged;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: onChanged,
            activeColor: cs.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          Expanded(
            child: Text(addOn.name,
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: checked
                        ? cs.onSurface
                        : cs.onSurface.withOpacity(0.6))),
          ),
          Text(
            inrFormatter.format(addOn.price),
            style: theme.textTheme.bodySmall!.copyWith(
              color: checked ? cs.primary : cs.onSurface.withOpacity(0.4),
              fontWeight: checked ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      );
}

// ─── Payment method card ──────────────────────────────────────────────────────

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    required this.cs,
    required this.theme,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? cs.primary.withOpacity(0.08) : cs.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? cs.primary : cs.outline.withOpacity(0.2),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected
                      ? cs.primary.withOpacity(0.15)
                      : cs.surfaceVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon,
                    color:
                        selected ? cs.primary : cs.onSurface.withOpacity(0.5),
                    size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: selected ? cs.primary : cs.onSurface,
                        )),
                    Text(subtitle,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: cs.onSurface.withOpacity(0.5))),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check_circle_rounded, color: cs.primary, size: 20),
            ],
          ),
        ),
      );
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, this.theme, this.cs);
  final String text;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: theme.textTheme.labelMedium!.copyWith(
          color: cs.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      );
}

class _Divider extends StatelessWidget {
  const _Divider(this.cs);
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) =>
      Divider(color: cs.outline.withOpacity(0.15));
}

class _SegmentBtn extends StatelessWidget {
  const _SegmentBtn({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.cs,
    required this.theme,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? cs.primary : cs.surfaceVariant.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: theme.textTheme.labelMedium!.copyWith(
              color: selected ? cs.onPrimary : cs.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
