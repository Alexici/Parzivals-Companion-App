import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../providers/character_draft_provider.dart';

const List<String> abilities = ['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA'];
const List<int> standardArray = [15, 14, 13, 12, 10, 8];
const Map<int, int> pointBuyCosts = {
  8: 0,
  9: 1,
  10: 2,
  11: 3,
  12: 4,
  13: 5,
  14: 7,
  15: 9,
};

class AbilitiesStep extends ConsumerStatefulWidget {
  const AbilitiesStep({super.key});

  @override
  ConsumerState<AbilitiesStep> createState() => _AbilitiesStepState();
}

class _AbilitiesStepState extends ConsumerState<AbilitiesStep> {
  String? _plusTwoStat;
  String? _plusOneStat;

  // Controllers for Manual Input
  final Map<String, TextEditingController> _ctrls = {
    'STR': TextEditingController(),
    'DEX': TextEditingController(),
    'CON': TextEditingController(),
    'INT': TextEditingController(),
    'WIS': TextEditingController(),
    'CHA': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    // Initialize manual text fields if they have existing data
    final draft = ref.read(characterDraftProvider);
    for (var stat in abilities) {
      int val = _getBaseStat(draft, stat);
      if (val > 0) _ctrls[stat]!.text = val.toString();
    }
  }

  @override
  void dispose() {
    for (var ctrl in _ctrls.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(characterDraftProvider);
    final notifier = ref.read(characterDraftProvider.notifier);

    // Sync external changes (like pressing the Roll button) to the TextFields
    ref.listen(characterDraftProvider, (prev, next) {
      for (var stat in abilities) {
        int nextVal = _getBaseStat(next, stat);
        if (nextVal != _getBaseStat(prev, stat) &&
            nextVal.toString() != _ctrls[stat]!.text) {
          _ctrls[stat]!.text = nextVal == 0 ? '' : nextVal.toString();
        }
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. GENERATION METHOD
          Text(
            'Core Attributes',
            style: GoogleFonts.medievalSharp(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GlassContainer(
            padding: 8,
            child: Row(
              children: ['Standard Array', 'Manual/Rolled', 'Point Buy'].map((
                method,
              ) {
                final isSelected = draft.generationMethod == method;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => notifier.updateGenerationMethod(method),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.royalPurple
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        method.split('/')[0],
                        style: GoogleFonts.inter(
                          color: isSelected ? Colors.white : Colors.white54,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // 2. THE DYNAMIC ENGINE
          GlassContainer(
            padding: 20,
            child: _buildGenerationView(draft, notifier),
          ),
          const SizedBox(height: 24),

          // 3. BACKGROUND BONUSES (2024 PHB Rules)
          Text(
            'Background Bonuses',
            style: GoogleFonts.medievalSharp(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GlassContainer(
            padding: 20,
            child: Column(
              children: [
                Text(
                  'Your 2024 Background grants a +2 and a +1 to your abilities.',
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildBonusDropdown(
                        '+2 Stat',
                        _plusTwoStat,
                        _plusOneStat,
                        (val) {
                          setState(() => _plusTwoStat = val);
                          _applyBonuses(notifier);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildBonusDropdown(
                        '+1 Stat',
                        _plusOneStat,
                        _plusTwoStat,
                        (val) {
                          setState(() => _plusOneStat = val);
                          _applyBonuses(notifier);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 4. THE CALCULATIONS TABLE
          Text(
            'Final Scores',
            style: GoogleFonts.medievalSharp(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GlassContainer(
            padding: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Table(
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1.2),
                },
                children: [
                  _buildTableHeader(),
                  _buildTableRow('STR', draft.baseStr, draft.bonusStr),
                  _buildTableRow('DEX', draft.baseDex, draft.bonusDex),
                  _buildTableRow('CON', draft.baseCon, draft.bonusCon),
                  _buildTableRow('INT', draft.baseInt, draft.bonusInt),
                  _buildTableRow('WIS', draft.baseWis, draft.bonusWis),
                  _buildTableRow('CHA', draft.baseCha, draft.bonusCha),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- ENGINE ROUTER ---
  Widget _buildGenerationView(dynamic draft, dynamic notifier) {
    switch (draft.generationMethod) {
      case 'Point Buy':
        return _buildPointBuyView(draft, notifier);
      case 'Manual/Rolled':
        return _buildManualRolledView(draft, notifier);
      case 'Standard Array':
      default:
        return _buildStandardArrayView(draft, notifier);
    }
  }

  // --- 1. STANDARD ARRAY ---
  // --- 1. STANDARD ARRAY ---
  Widget _buildStandardArrayView(dynamic draft, dynamic notifier) {
    List<int> usedScores = [];
    for (var stat in abilities) {
      int val = _getBaseStat(draft, stat);
      if (val > 0) usedScores.add(val);
    }

    return Column(
      children: abilities.map((stat) {
        final currentVal = _getBaseStat(draft, stat);
        final available = standardArray
            .where((val) => !usedScores.contains(val) || val == currentVal)
            .toList();

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  stat,
                  style: GoogleFonts.medievalSharp(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: DropdownButtonFormField<int?>(
                  initialValue: currentVal == 0 ? null : currentVal,
                  dropdownColor: AppColors.midnightBlue,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                  decoration: _inputDeco(),
                  items: [
                    // Added a Clear option so players can free up a score!
                    const DropdownMenuItem<int?>(
                      value: null,
                      child: Text('-', style: TextStyle(color: Colors.white54)),
                    ),
                    ...available.map(
                      (val) => DropdownMenuItem<int?>(
                        value: val,
                        child: Text(val.toString()),
                      ),
                    ),
                  ],
                  onChanged: (val) {
                    notifier.updateBaseStat(stat: stat, value: val ?? 0);
                  },
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // --- 2. MANUAL / ROLLED ---
  Widget _buildManualRolledView(dynamic draft, dynamic notifier) {
    return Column(
      children: abilities.map((stat) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  stat,
                  style: GoogleFonts.medievalSharp(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _ctrls[stat],
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  decoration: _inputDeco(label: 'Score'),
                  onChanged: (val) {
                    int? parsed = int.tryParse(val);
                    if (parsed != null && parsed >= 3 && parsed <= 18) {
                      notifier.updateBaseStat(stat: stat, value: parsed);
                    } else if (val.isEmpty) {
                      notifier.updateBaseStat(stat: stat, value: 0);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.royalPurple.withValues(alpha: 0.8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.casino, size: 18, color: Colors.white),
                label: Text(
                  'Roll',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  final result = _roll4d6DropLowest();
                  notifier.updateBaseStat(stat: stat, value: result);

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      // Fixed the color to high-contrast white70
                      content: Text(
                        'Rolled $stat: $result (4d6 drop lowest)',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      backgroundColor: AppColors.midnightBlue,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  int _roll4d6DropLowest() {
    final random = Random();
    List<int> rolls = List.generate(4, (_) => random.nextInt(6) + 1);
    rolls.sort();
    return rolls[1] + rolls[2] + rolls[3];
  }

  // --- 3. POINT BUY ---
  Widget _buildPointBuyView(dynamic draft, dynamic notifier) {
    int pointsSpent = 0;
    for (String stat in abilities) {
      pointsSpent += pointBuyCosts[_getBaseStat(draft, stat)] ?? 0;
    }
    int pointsRemaining = 27 - pointsSpent;
    bool isOverLimit = pointsRemaining < 0;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isOverLimit
                ? Colors.red.withValues(alpha: 0.2)
                : AppColors.royalPurple.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isOverLimit ? Colors.red : AppColors.royalPurple,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Points Remaining',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$pointsRemaining / 27',
                style: GoogleFonts.medievalSharp(
                  fontSize: 22,
                  color: isOverLimit
                      ? Colors.redAccent
                      : AppColors.legendaryGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        ...abilities.map((stat) {
          final currentVal = _getBaseStat(draft, stat);
          final costOfNext = pointBuyCosts[currentVal + 1] ?? 99;
          final currentCost = pointBuyCosts[currentVal] ?? 0;
          final diff = costOfNext - currentCost;
          final canAfford = pointsRemaining >= diff;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    stat,
                    style: GoogleFonts.medievalSharp(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.white54,
                  ),
                  onPressed: currentVal > 8
                      ? () => notifier.updateBaseStat(
                          stat: stat,
                          value: currentVal - 1,
                        )
                      : null,
                ),

                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      currentVal.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: canAfford && currentVal < 15
                        ? AppColors.royalPurple
                        : Colors.white24,
                  ),
                  onPressed: canAfford && currentVal < 15
                      ? () => notifier.updateBaseStat(
                          stat: stat,
                          value: currentVal + 1,
                        )
                      : null,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // --- ASI HELPERS ---
  Widget _buildBonusDropdown(
    String label,
    String? currentValue,
    String? disabledValue,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: currentValue,
      dropdownColor: AppColors.midnightBlue,
      decoration: _inputDeco(label: label),
      items: abilities.map((stat) {
        bool isDisabled = stat == disabledValue;
        return DropdownMenuItem(
          value: isDisabled ? null : stat,
          child: Text(
            stat,
            style: TextStyle(color: isDisabled ? Colors.white24 : Colors.white),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  void _applyBonuses(dynamic notifier) {
    notifier.clearBonuses();
    if (_plusTwoStat != null) {
      notifier.updateBonusStat(stat: _plusTwoStat!, value: 2);
    }
    if (_plusOneStat != null) {
      notifier.updateBonusStat(stat: _plusOneStat!, value: 1);
    }
  }

  // --- CALCULATIONS TABLE HELPERS ---
  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4)),
      children: [
        _tableCell('Ability', isHeader: true),
        _tableCell('Base', isHeader: true),
        _tableCell('Bonus', isHeader: true),
        _tableCell('Total', isHeader: true),
        _tableCell('Mod', isHeader: true),
      ],
    );
  }

  TableRow _buildTableRow(String stat, int base, int bonus) {
    int total = base + bonus;
    int mod = ((total - 10) / 2).floor();
    String modString = mod >= 0 ? '+$mod' : '$mod';

    return TableRow(
      children: [
        _tableCell(stat, isBold: true),
        _tableCell(base == 0 ? '-' : base.toString()),
        _tableCell(
          bonus > 0 ? '+$bonus' : '-',
          color: bonus > 0 ? AppColors.legendaryGold : Colors.white54,
        ),
        _tableCell(total == 0 ? '-' : total.toString(), isBold: true),
        Container(
          padding: const EdgeInsets.all(12),
          color: AppColors.royalPurple.withValues(alpha: 0.2),
          alignment: Alignment.center,
          child: Text(
            total == 0 ? '-' : modString,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tableCell(
    String text, {
    bool isHeader = false,
    bool isBold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: isHeader
            ? GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )
            : GoogleFonts.inter(
                color: color ?? Colors.white,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
      ),
    );
  }

  // --- UTILS ---
  int _getBaseStat(dynamic draft, String stat) {
    switch (stat) {
      case 'STR':
        return draft.baseStr;
      case 'DEX':
        return draft.baseDex;
      case 'CON':
        return draft.baseCon;
      case 'INT':
        return draft.baseInt;
      case 'WIS':
        return draft.baseWis;
      case 'CHA':
        return draft.baseCha;
      default:
        return 0;
    }
  }

  InputDecoration _inputDeco({String? label}) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.royalPurple, width: 2),
      ),
    );
  }
}
