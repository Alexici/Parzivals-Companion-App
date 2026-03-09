import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../providers/character_draft_provider.dart';

// --- 2024 PHB Mock Database for Equipment ---
class ClassEquipment {
  final List<String> packageItems;
  final int packageGold;
  final int maxGold;

  const ClassEquipment(this.packageItems, this.packageGold, this.maxGold);
}

const Map<String, ClassEquipment> classGearDb = {
  'Barbarian': ClassEquipment(
    ['Greataxe', '4 Handaxes', "Explorer's Pack"],
    15,
    75,
  ),
  'Fighter': ClassEquipment(
    ['Chain Mail', 'Longsword', '2 Handaxes', "Dungeoneer's Pack"],
    9,
    150,
  ),
  'Wizard': ClassEquipment(
    ['Quarterstaff', 'Arcane Focus', "Scholar's Pack", 'Spellbook'],
    8,
    55,
  ),
  'Rogue': ClassEquipment(
    [
      'Leather Armor',
      '2 Daggers',
      'Shortsword',
      "Burglar's Pack",
      "Thieves' Tools",
    ],
    8,
    110,
  ),
};

class EquipmentStep extends ConsumerStatefulWidget {
  const EquipmentStep({super.key});

  @override
  ConsumerState<EquipmentStep> createState() => _EquipmentStepState();
}

class _EquipmentStepState extends ConsumerState<EquipmentStep> {
  final TextEditingController _customItemCtrl = TextEditingController();

  @override
  void dispose() {
    _customItemCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(characterDraftProvider);
    final notifier = ref.read(characterDraftProvider.notifier);

    // Fallback if they haven't picked a class yet
    final gearData =
        classGearDb[draft.characterClass] ?? const ClassEquipment([], 0, 0);
    final backgroundGold = 50; // 2024 Rule: All backgrounds give 50gp

    return DefaultTabController(
      length: 4, // Your 4 requested tabs
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Text(
              'Inventory & Wealth',
              style: GoogleFonts.medievalSharp(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // The Custom Tab Bar
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppColors.royalPurple,
            labelColor: AppColors.legendaryGold,
            unselectedLabelColor: Colors.white54,
            labelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Starting Gear'),
              Tab(text: 'Current Inventory'),
              Tab(text: 'Currency'),
              Tab(text: 'Compendium'),
            ],
          ),

          // The Tab Views
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                children: [
                  _buildStartingGearTab(
                    draft,
                    notifier,
                    gearData,
                    backgroundGold,
                  ),
                  _buildInventoryTab(draft, notifier),
                  _buildCurrencyTab(draft, notifier),
                  _buildCompendiumTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 1: STARTING GEAR CHOICES ---
  Widget _buildStartingGearTab(
    dynamic draft,
    dynamic notifier,
    ClassEquipment gear,
    int bgGold,
  ) {
    if (draft.characterClass.isEmpty) {
      return Center(
        child: Text(
          'Please select a Class in Step B first.',
          style: GoogleFonts.inter(color: Colors.white54),
        ),
      );
    }

    final totalPackageGold = gear.packageGold + bgGold;
    final totalMaxGold = gear.maxGold + bgGold;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your starting wealth based on your Class and Background (which grants a base 50 GP).',
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),

          // OPTION A: PACKAGE
          _buildGearOptionCard(
            title: 'Option A: Recommended Package',
            isSelected: draft.equipmentChoice == 'Package',
            items: gear.packageItems,
            gold: totalPackageGold,
            onTap: () => notifier.setEquipmentChoice(
              newChoice: 'Package',
              packageItems: gear.packageItems,
              startingGold: totalPackageGold,
            ),
          ),
          const SizedBox(height: 16),

          // OPTION B: GOLD
          _buildGearOptionCard(
            title: 'Option B: Starting Wealth',
            isSelected: draft.equipmentChoice == 'Gold',
            items: [
              'Buy your own custom weapons, armor, and gear from the Compendium.',
            ],
            gold: totalMaxGold,
            onTap: () => notifier.setEquipmentChoice(
              newChoice: 'Gold',
              packageItems: gear.packageItems,
              startingGold: totalMaxGold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGearOptionCard({
    required String title,
    required bool isSelected,
    required List<String> items,
    required int gold,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: GlassContainer(
        padding: 16,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.royalPurple : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.medievalSharp(
                      fontSize: 18,
                      color: isSelected ? AppColors.royalPurple : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.royalPurple,
                    ),
                ],
              ),
              const Divider(color: Colors.white24, height: 24),
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_right,
                        color: Colors.white54,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: GoogleFonts.inter(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: AppColors.legendaryGold,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$gold GP',
                    style: GoogleFonts.inter(
                      color: AppColors.legendaryGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- TAB 2: CURRENT INVENTORY ---
  Widget _buildInventoryTab(dynamic draft, dynamic notifier) {
    return Column(
      children: [
        // Add Custom Item Field
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _customItemCtrl,
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Add custom possession...',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.black.withValues(alpha: 0.2),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (val) {
                  notifier.addCustomItem(val);
                  _customItemCtrl.clear();
                },
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.royalPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                notifier.addCustomItem(_customItemCtrl.text);
                _customItemCtrl.clear();
              },
            ),
          ],
        ),
        const SizedBox(height: 16),

        // The List
        Expanded(
          child: draft.inventory.isEmpty
              ? Center(
                  child: Text(
                    'Your pack is empty.',
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : GlassContainer(
                  padding: 8,
                  child: ListView.separated(
                    itemCount: draft.inventory.length,
                    separatorBuilder: (_, _) =>
                        const Divider(color: Colors.white12, height: 1),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          draft.inventory[index],
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          onPressed: () => notifier.removeInventoryItem(index),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  // --- TAB 3: CURRENCY ---
  Widget _buildCurrencyTab(dynamic draft, dynamic notifier) {
    return SingleChildScrollView(
      child: GlassContainer(
        padding: 24,
        child: Column(
          children: [
            _buildCoinRow(
              'Platinum (PP)',
              draft.pp,
              (val) => notifier.updateCurrency(pp: val),
              Colors.blueGrey.shade100,
            ),
            _buildCoinRow(
              'Gold (GP)',
              draft.gp,
              (val) => notifier.updateCurrency(gp: val),
              AppColors.legendaryGold,
            ),
            _buildCoinRow(
              'Electrum (EP)',
              draft.ep,
              (val) => notifier.updateCurrency(ep: val),
              Colors.teal.shade200,
            ),
            _buildCoinRow(
              'Silver (SP)',
              draft.sp,
              (val) => notifier.updateCurrency(sp: val),
              Colors.grey.shade400,
            ),
            _buildCoinRow(
              'Copper (CP)',
              draft.cp,
              (val) => notifier.updateCurrency(cp: val),
              Colors.deepOrange.shade300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinRow(
    String label,
    int value,
    Function(int) onChanged,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.monetization_on, color: iconColor, size: 24),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.medievalSharp(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 80,
            child: TextFormField(
              initialValue: value.toString(),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withValues(alpha: 0.3),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => onChanged(int.tryParse(val) ?? 0),
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 4: COMPENDIUM (PLACEHOLDER) ---
  Widget _buildCompendiumTab() {
    return Center(
      child: GlassContainer(
        padding: 32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_stories, size: 64, color: Colors.white24),
            const SizedBox(height: 16),
            Text(
              'Item Compendium',
              style: GoogleFonts.medievalSharp(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Browse and add magical and mundane items from the official ruleset. Coming soon.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white54, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
