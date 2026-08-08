import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/hospital.dart';
import '../../../services/firebase_hospital_service.dart';
import 'hospital_details_screen.dart';

class ExploreHospitalsScreen extends StatefulWidget {
  const ExploreHospitalsScreen({super.key});

  @override
  State<ExploreHospitalsScreen> createState() =>
      _ExploreHospitalsScreenState();
}

class _ExploreHospitalsScreenState
    extends State<ExploreHospitalsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String? _selectedLocation;
  String? _selectedSpecialty;
  String? _selectedPackage;

  // ============================================================
  // FILTER HOSPITALS
  // ============================================================

  List<Hospital> _filterHospitals(
    List<Hospital> hospitals,
  ) {
    final query =
        _searchController.text.trim().toLowerCase();

    return hospitals.where((hospital) {
      // --------------------------------------------------------
      // SEARCH
      // --------------------------------------------------------

      final matchesSearch =
          query.isEmpty ||
          hospital.name.toLowerCase().contains(query) ||
          hospital.city.toLowerCase().contains(query) ||
          hospital.state.toLowerCase().contains(query) ||
          hospital.specialties.any(
            (specialty) =>
                specialty.toLowerCase().contains(query),
          ) ||
          hospital.packages.any(
            (package) =>
                package.title.toLowerCase().contains(query),
          );

      // --------------------------------------------------------
      // LOCATION
      // --------------------------------------------------------

      final matchesLocation =
          _selectedLocation == null ||
          hospital.city == _selectedLocation ||
          hospital.state == _selectedLocation;

      // --------------------------------------------------------
      // SPECIALTY
      // --------------------------------------------------------

      final matchesSpecialty =
          _selectedSpecialty == null ||
          hospital.specialties.contains(
            _selectedSpecialty,
          );

      // --------------------------------------------------------
      // PACKAGE
      // --------------------------------------------------------

      final matchesPackage =
          _selectedPackage == null ||
          hospital.packages.any(
            (package) =>
                package.title == _selectedPackage,
          );

      return matchesSearch &&
          matchesLocation &&
          matchesSpecialty &&
          matchesPackage;
    }).toList();
  }

  // ============================================================
  // LOCATIONS
  // ============================================================

  List<String> _getLocations(
    List<Hospital> hospitals,
  ) {
    final locations = hospitals
        .map(
          (hospital) => hospital.city.trim().isNotEmpty
              ? hospital.city.trim()
              : hospital.state.trim(),
        )
        .where((location) => location.isNotEmpty)
        .toSet()
        .toList();

    locations.sort();

    return locations;
  }

  // ============================================================
  // SPECIALTIES
  // ============================================================

  List<String> _getSpecialties(
    List<Hospital> hospitals,
  ) {
    final specialties = hospitals
        .expand(
          (hospital) => hospital.specialties,
        )
        .map((specialty) => specialty.trim())
        .where((specialty) => specialty.isNotEmpty)
        .toSet()
        .toList();

    specialties.sort();

    return specialties;
  }

  // ============================================================
  // PACKAGES
  // ============================================================

  List<String> _getPackages(
    List<Hospital> hospitals,
  ) {
    final packages = hospitals
        .expand(
          (hospital) => hospital.packages,
        )
        .map((package) => package.title.trim())
        .where((title) => title.isNotEmpty)
        .toSet()
        .toList();

    packages.sort();

    return packages;
  }

  // ============================================================
  // CLEAR FILTERS
  // ============================================================

  void _clearFilters() {
    setState(() {
      _searchController.clear();

      _selectedLocation = null;
      _selectedSpecialty = null;
      _selectedPackage = null;
    });
  }

  bool get _hasFilters {
    return _searchController.text.trim().isNotEmpty ||
        _selectedLocation != null ||
        _selectedSpecialty != null ||
        _selectedPackage != null;
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: StreamBuilder<List<Hospital>>(
          stream:
              FirebaseHospitalService().getHospitals(),
          builder: (context, snapshot) {
            // ==================================================
            // LOADING
            // ==================================================

            if (snapshot.connectionState ==
                    ConnectionState.waiting &&
                !snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            // ==================================================
            // ERROR
            // ==================================================

            if (snapshot.hasError) {
              return _ErrorState(
                error: snapshot.error.toString(),
              );
            }

            final hospitals =
                snapshot.data ?? <Hospital>[];

            final locations =
                _getLocations(hospitals);

            final specialties =
                _getSpecialties(hospitals);

            final packages =
                _getPackages(hospitals);

            final filteredHospitals =
                _filterHospitals(hospitals);

            return CustomScrollView(
              slivers: [
                // ==================================================
                // HEADER
                // ==================================================

                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(
                      20,
                      22,
                      20,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.primary,
                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),
                              ),
                              child: const Icon(
                                Icons
                                    .local_hospital_rounded,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    'Explore Hospitals',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight:
                                          FontWeight.w800,
                                      color: AppColors
                                          .textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Healthcare across Malaysia',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors
                                          .textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 26),

                        // ==========================================
                        // HERO
                        // ==========================================

                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius:
                                BorderRadius.circular(26),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: -20,
                                bottom: -25,
                                child: Icon(
                                  Icons
                                      .health_and_safety_outlined,
                                  size: 125,
                                  color: Colors.white
                                      .withValues(
                                    alpha: 0.07,
                                  ),
                                ),
                              ),

                              const Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    'Find the right care\nfor you.',
                                    style: TextStyle(
                                      fontSize: 26,
                                      height: 1.15,
                                      fontWeight:
                                          FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  Text(
                                    'Discover trusted hospitals, specialists and treatment packages.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.5,
                                      color:
                                          Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ==========================================
                        // SEARCH
                        // ==========================================

                        TextField(
                          controller:
                              _searchController,
                          onChanged: (_) {
                            setState(() {});
                          },
                          decoration:
                              InputDecoration(
                            hintText:
                                'Search hospital, specialty or package',
                            hintStyle:
                                const TextStyle(
                              fontSize: 12,
                              color: AppColors
                                  .textSecondary,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color:
                                  AppColors.primary,
                            ),
                            suffixIcon:
                                _searchController
                                        .text
                                        .isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _searchController
                                                .clear();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons
                                              .close_rounded,
                                        ),
                                      )
                                    : null,
                            filled: true,
                            fillColor: Colors.white,
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                              borderSide:
                                  const BorderSide(
                                color:
                                    AppColors.border,
                              ),
                            ),
                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                              borderSide:
                                  const BorderSide(
                                color:
                                    AppColors.border,
                              ),
                            ),
                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                              borderSide:
                                  const BorderSide(
                                color:
                                    AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ==========================================
                        // FILTER TITLE
                        // ==========================================

                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Filter Healthcare',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      FontWeight.w800,
                                  color: AppColors
                                      .textPrimary,
                                ),
                              ),
                            ),

                            if (_hasFilters)
                              TextButton(
                                onPressed:
                                    _clearFilters,
                                child: const Text(
                                  'Clear all',
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // ==========================================
                        // FILTERS
                        // ==========================================

                        SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal,
                          child: Row(
                            children: [
                              _FilterButton(
                                icon: Icons
                                    .location_on_outlined,
                                label:
                                    _selectedLocation ??
                                        'Location',
                                active:
                                    _selectedLocation !=
                                        null,
                                onTap: () {
                                  _showFilterSheet(
                                    context: context,
                                    title:
                                        'Select Location',
                                    items: locations,
                                    selected:
                                        _selectedLocation,
                                    onSelected:
                                        (value) {
                                      setState(() {
                                        _selectedLocation =
                                            value;
                                      });
                                    },
                                  );
                                },
                              ),

                              const SizedBox(width: 10),

                              _FilterButton(
                                icon: Icons
                                    .medical_services_outlined,
                                label:
                                    _selectedSpecialty ??
                                        'Specialty',
                                active:
                                    _selectedSpecialty !=
                                        null,
                                onTap: () {
                                  _showFilterSheet(
                                    context: context,
                                    title:
                                        'Select Specialty',
                                    items: specialties,
                                    selected:
                                        _selectedSpecialty,
                                    onSelected:
                                        (value) {
                                      setState(() {
                                        _selectedSpecialty =
                                            value;
                                      });
                                    },
                                  );
                                },
                              ),

                              const SizedBox(width: 10),

                              _FilterButton(
                                icon: Icons
                                    .inventory_2_outlined,
                                label:
                                    _selectedPackage ??
                                        'Package',
                                active:
                                    _selectedPackage !=
                                        null,
                                onTap: () {
                                  _showFilterSheet(
                                    context: context,
                                    title:
                                        'Select Package',
                                    items: packages,
                                    selected:
                                        _selectedPackage,
                                    onSelected:
                                        (value) {
                                      setState(() {
                                        _selectedPackage =
                                            value;
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 26),

                        // ==========================================
                        // RESULTS
                        // ==========================================

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                filteredHospitals
                                        .length ==
                                    1
                                    ? '1 hospital found'
                                    : '${filteredHospitals.length} hospitals found',
                                style:
                                    const TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeight.w700,
                                  color: AppColors
                                      .textPrimary,
                                ),
                              ),
                            ),

                            Text(
                              '${hospitals.length} total',
                              style:
                                  const TextStyle(
                                fontSize: 10,
                                color: AppColors
                                    .textSecondary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),

                // ==================================================
                // EMPTY
                // ==================================================

                if (filteredHospitals.isEmpty)
                  SliverToBoxAdapter(
                    child: _EmptyState(
                      onClear: _clearFilters,
                    ),
                  )

                // ==================================================
                // HOSPITAL LIST
                // ==================================================

                else
                  SliverPadding(
                    padding:
                        const EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      120,
                    ),
                    sliver: SliverList.separated(
                      itemCount:
                          filteredHospitals.length,
                      separatorBuilder:
                          (context, index) =>
                              const SizedBox(
                        height: 16,
                      ),
                      itemBuilder:
                          (context, index) {
                        return _HospitalCard(
                          hospital:
                              filteredHospitals[
                                  index],
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // FILTER BOTTOM SHEET
  // ============================================================

  void _showFilterSheet({
    required BuildContext context,
    required String title,
    required List<String> items,
    required String? selected,
    required ValueChanged<String?> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight:
                MediaQuery.of(context).size.height *
                    0.72,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),

              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  12,
                  12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.w800,
                          color:
                              AppColors.textPrimary,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(
                          sheetContext,
                        );
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.fromLTRB(
                    12,
                    10,
                    12,
                    30,
                  ),
                  children: [
                    ListTile(
                      leading: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: selected == null
                              ? AppColors
                                  .primaryLight
                              : AppColors
                                  .background,
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: const Icon(
                          Icons.apps_rounded,
                          size: 19,
                          color:
                              AppColors.primary,
                        ),
                      ),
                      title: const Text(
                        'All',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      trailing: selected == null
                          ? const Icon(
                              Icons
                                  .check_circle_rounded,
                              color:
                                  AppColors.primary,
                            )
                          : null,
                      onTap: () {
                        onSelected(null);

                        Navigator.pop(
                          sheetContext,
                        );
                      },
                    ),

                    ...items.map(
                      (item) => ListTile(
                        title: Text(item),
                        trailing:
                            selected == item
                                ? const Icon(
                                    Icons
                                        .check_circle_rounded,
                                    color: AppColors
                                        .primary,
                                  )
                                : null,
                        onTap: () {
                          onSelected(item);

                          Navigator.pop(
                            sheetContext,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// HOSPITAL CARD
// ============================================================================

class _HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const _HospitalCard({
    required this.hospital,
  });

  // ============================================================
  // LOWEST PACKAGE PRICE
  // ============================================================

  double? get lowestPackagePrice {
    if (hospital.packages.isEmpty) {
      return null;
    }

    final validPrices = hospital.packages
        .map((package) => package.price)
        .where((price) => price > 0)
        .toList();

    if (validPrices.isEmpty) {
      return null;
    }

    return validPrices.reduce(
      (a, b) => a < b ? a : b,
    );
  }

  // ============================================================
  // PRICE FORMAT
  // ============================================================

  String _formatPrice(double price) {
    final rounded = price.round().toString();

    final formatted = rounded.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );

    return 'RM $formatted';
  }

  @override
  Widget build(BuildContext context) {
    final price = lowestPackagePrice;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                HospitalDetailsScreen(
              hospital: hospital,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.035,
              ),
              blurRadius: 20,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // ==================================================
            // IMAGE
            // ==================================================

            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 190,
                    child:
                        hospital.imageUrl.isNotEmpty
                            ? Image.network(
                                hospital.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                ) {
                                  return const _ImageFallback();
                                },
                              )
                            : const _ImageFallback(),
                  ),

                  // ==============================================
                  // PACKAGE BADGE
                  // ==============================================

                  if (hospital.packages.isNotEmpty)
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withValues(
                            alpha: 0.94,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons
                                  .inventory_2_outlined,
                              size: 14,
                              color:
                                  AppColors.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${hospital.packages.length} ${hospital.packages.length == 1 ? 'Package' : 'Packages'}',
                              style:
                                  const TextStyle(
                                fontSize: 10,
                                fontWeight:
                                    FontWeight.w700,
                                color: AppColors
                                    .textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ==================================================
            // DETAILS
            // ==================================================

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    hospital.name,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                      color:
                          AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons
                            .location_on_outlined,
                        size: 17,
                        color: AppColors
                            .textSecondary,
                      ),

                      const SizedBox(width: 4),

                      Expanded(
                        child: Text(
                          hospital.city.isNotEmpty
                              ? hospital.city
                              : hospital.state,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors
                                .textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ==================================================
                  // SPECIALTIES
                  // ==================================================

                  if (hospital
                      .specialties.isNotEmpty) ...[
                    const SizedBox(height: 14),

                    Wrap(
                      spacing: 7,
                      runSpacing: 7,
                      children: hospital
                          .specialties
                          .take(3)
                          .map(
                            (specialty) =>
                                Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 9,
                                vertical: 6,
                              ),
                              decoration:
                                  BoxDecoration(
                                color: AppColors
                                    .primaryLight,
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  20,
                                ),
                              ),
                              child: Text(
                                specialty,
                                style:
                                    const TextStyle(
                                  fontSize: 9,
                                  fontWeight:
                                      FontWeight.w600,
                                  color: AppColors
                                      .primary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],

                  const SizedBox(height: 18),

                  Divider(
                    height: 1,
                    color: AppColors.border,
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // PACKAGE PRICE
                  // ==================================================

                  Row(
                    children: [
                      Expanded(
                        child: price != null
                            ? Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  const Text(
                                    'Packages from',
                                    style:
                                        TextStyle(
                                      fontSize: 9,
                                      color: AppColors
                                          .textSecondary,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 3,
                                  ),

                                  Text(
                                    _formatPrice(
                                      price,
                                    ),
                                    style:
                                        const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight
                                              .w800,
                                      color: AppColors
                                          .primary,
                                    ),
                                  ),
                                ],
                              )
                            : const Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    'Treatment',
                                    style:
                                        TextStyle(
                                      fontSize: 9,
                                      color: AppColors
                                          .textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'Enquire for options',
                                    style:
                                        TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      color: AppColors
                                          .textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              AppColors.primaryLight,
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'View',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight:
                                    FontWeight.w700,
                                color: AppColors
                                    .primary,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons
                                  .arrow_forward_rounded,
                              size: 15,
                              color:
                                  AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// FILTER BUTTON
// ============================================================================

class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterButton({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 190,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: active
              ? AppColors.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: active
                ? AppColors.primary
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: active
                  ? Colors.white
                  : AppColors.primary,
            ),

            const SizedBox(width: 7),

            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: active
                      ? Colors.white
                      : AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(width: 5),

            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 17,
              color: active
                  ? Colors.white
                  : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// IMAGE FALLBACK
// ============================================================================

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLight,
      child: const Center(
        child: Icon(
          Icons.local_hospital_rounded,
          size: 55,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

// ============================================================================
// EMPTY STATE
// ============================================================================

class _EmptyState extends StatelessWidget {
  final VoidCallback onClear;

  const _EmptyState({
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(20, 35, 20, 120),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius:
                    BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 36,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'No hospitals found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Try changing your search or filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 18),

            OutlinedButton(
              onPressed: onClear,
              child: const Text(
                'Clear Filters',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ERROR STATE
// ============================================================================

class _ErrorState extends StatelessWidget {
  final String error;

  const _ErrorState({
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 50,
              color: AppColors.primary,
            ),

            const SizedBox(height: 15),

            const Text(
              'Unable to load hospitals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}