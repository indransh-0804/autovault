import 'package:autovault/core/utils/app_constants.dart';
import 'package:autovault/core/utils/formatters.dart';
import 'package:autovault/features/purchase/widgets/repayment_schedule_table.dart';
import 'package:autovault/features/purchase/providers/purchase_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanConfigStep extends ConsumerStatefulWidget {
  const LoanConfigStep({super.key});

  @override
  ConsumerState<LoanConfigStep> createState() => _LoanConfigStepState();
}

class _LoanConfigStepState extends ConsumerState<LoanConfigStep> {
  final _interestCtr = TextEditingController();
  final _processingCtr = TextEditingController();
  final _guarantorName = TextEditingController();
  final _guarantorPhone = TextEditingController();
  final _guarantorRel = TextEditingController();
  bool _showGuarantor = false;

  @override
  void initState() {
    super.initState();
    final config = ref.read(purchaseFormNotifierProvider).loanConfig;
    if (config != null) {
      _interestCtr.text = config.interestRate.toString();
      _processingCtr.text = config.processingFee.toInt().toString();
      _guarantorName.text = config.guarantorName;
      _guarantorPhone.text = config.guarantorPhone;
      _guarantorRel.text = config.guarantorRelationship;
      if (config.guarantorName.isNotEmpty) _showGuarantor = true;
    }
  }

  @override
  void dispose() {
    _interestCtr.dispose();
    _processingCtr.dispose();
    _guarantorName.dispose();
    _guarantorPhone.dispose();
    _guarantorRel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final form = ref.watch(purchaseFormNotifierProvider);
    final notifier = ref.read(purchaseFormNotifierProvider.notifier);
    final config = form.loanConfig;

    if (config == null) {
      return Center(
        child: Text('Select a loan-based payment method first.',
            style: theme.textTheme.bodyMedium!
                .copyWith(color: cs.onSurface.withOpacity(0.5))),
      );
    }

    final schedule = config.repaymentSchedule;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Loan amount (read-only) ─────────────────────────────────────
        _ReadOnlyField(
          label: 'Loan Amount',
          value: inrFormatter.format(config.loanAmount),
          theme: theme,
          cs: cs,
        ),
        const SizedBox(height: 14),

        // ── Interest rate ─────────────────────────────────────────────
        TextField(
          controller: _interestCtr,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
          ],
          onChanged: (v) => notifier.setInterestRate(
              double.tryParse(v) ?? AppConstants.defaultInterestRate),
          decoration: _deco(cs, 'Interest Rate (% per annum)'),
        ),
        const SizedBox(height: 14),

        // ── Loan term ─────────────────────────────────────────────────
        Text('Loan Term',
            style: theme.textTheme.labelMedium!.copyWith(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.loanTermOptions.map((months) {
            final sel = config.termMonths == months;
            return ChoiceChip(
              label: Text('$months mo'),
              selected: sel,
              onSelected: (_) => notifier.setTermMonths(months),
              selectedColor: cs.primary,
              backgroundColor: Colors.transparent,
              labelStyle: TextStyle(
                color: sel ? cs.onPrimary : cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
              side: BorderSide(
                  color: sel ? cs.primary : cs.outline.withOpacity(0.4)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),

        // ── Processing fee ────────────────────────────────────────────
        TextField(
          controller: _processingCtr,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (v) => notifier.setProcessingFee(
              double.tryParse(v) ?? AppConstants.defaultProcessingFee),
          decoration: _deco(cs, 'Processing Fee (₹)'),
        ),
        const SizedBox(height: 14),

        // ── Loan start date ───────────────────────────────────────────
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: config.startDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 90)),
            );
            if (picked != null) notifier.setLoanStartDate(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: cs.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outline.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 18, color: cs.onSurfaceVariant),
                const SizedBox(width: 10),
                Text('Loan Start: ${dateFormatter.format(config.startDate)}',
                    style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // ── EMI Calculator Panel ──────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.primary.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('EMI Calculator',
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  )),
              const SizedBox(height: 14),
              // Big EMI amount
              Center(
                child: Column(
                  children: [
                    Text('Monthly EMI',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: cs.onSurface.withOpacity(0.5))),
                    const SizedBox(height: 4),
                    Text(
                      inrFormatter.format(config.emiAmount.round()),
                      style: theme.textTheme.headlineMedium!.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text('per month × ${config.termMonths} months',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: cs.onSurface.withOpacity(0.45))),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: cs.outline.withOpacity(0.15)),
              const SizedBox(height: 10),
              _CalcRow('Total Interest Payable',
                  inrFormatter.format(config.totalInterest.round()), theme, cs),
              const SizedBox(height: 6),
              _CalcRow('Processing Fee',
                  inrFormatter.format(config.processingFee.round()), theme, cs),
              const SizedBox(height: 6),
              _CalcRow(
                'Total Amount Payable',
                inrFormatter.format(config.totalPayable.round()),
                theme,
                cs,
                bold: true,
                valueColor: cs.primary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Repayment schedule ────────────────────────────────────────
        Text('Repayment Schedule Preview',
            style: theme.textTheme.titleSmall!
                .copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        RepaymentScheduleTable(schedule: schedule, previewRows: 6),
        const SizedBox(height: 20),

        // ── Guarantor section ─────────────────────────────────────────
        GestureDetector(
          onTap: () => setState(() => _showGuarantor = !_showGuarantor),
          child: Row(
            children: [
              Icon(
                _showGuarantor
                    ? Icons.expand_less_rounded
                    : Icons.add_circle_outline_rounded,
                color: cs.primary,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                _showGuarantor ? 'Remove Guarantor' : '＋ Add Guarantor',
                style: theme.textTheme.labelLarge!.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (_showGuarantor) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _guarantorName,
            onChanged: (v) => notifier.setGuarantor(
                v, _guarantorPhone.text, _guarantorRel.text),
            decoration: _deco(cs, 'Guarantor Name'),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _guarantorPhone,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            onChanged: (v) => notifier.setGuarantor(
                _guarantorName.text, v, _guarantorRel.text),
            decoration: _deco(cs, 'Guarantor Phone').copyWith(
              prefixText: '+91 ',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _guarantorRel,
            onChanged: (v) => notifier.setGuarantor(
                _guarantorName.text, _guarantorPhone.text, v),
            decoration: _deco(cs, 'Relationship (e.g. Father, Spouse)'),
            textCapitalization: TextCapitalization.words,
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  InputDecoration _deco(ColorScheme cs, String label) => InputDecoration(
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

class _CalcRow extends StatelessWidget {
  const _CalcRow(this.label, this.value, this.theme, this.cs,
      {this.bold = false, this.valueColor});
  final String label, value;
  final ThemeData theme;
  final ColorScheme cs;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: cs.onSurface.withOpacity(0.6))),
          Text(value,
              style: theme.textTheme.bodySmall!.copyWith(
                color: valueColor ?? cs.onSurface.withOpacity(0.85),
                fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
              )),
        ],
      );
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField(
      {required this.label,
      required this.value,
      required this.theme,
      required this.cs});
  final String label, value;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cs.surfaceVariant.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outline.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: cs.onSurface.withOpacity(0.5))),
            ),
            Text(value,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(width: 4),
            Icon(Icons.lock_outline_rounded,
                size: 14, color: cs.onSurface.withOpacity(0.3)),
          ],
        ),
      );
}
