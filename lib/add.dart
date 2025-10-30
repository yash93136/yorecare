import 'package:adminpanel/login.dart';
import 'package:adminpanel/products.dart';
import 'package:flutter/material.dart';

class BlazeAdminDashboard extends StatefulWidget {
  const BlazeAdminDashboard({super.key});
  @override
  State<BlazeAdminDashboard> createState() => _BlazeAdminDashboardState();
}

class _BlazeAdminDashboardState extends State<BlazeAdminDashboard> {
  int _selectedIndex = 1;
  int _currentPage = 1;
  String _searchQuery = '';
  List<Map<String, dynamic>> _allCoupons = [];
  List<Map<String, dynamic>> _filteredCoupons = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeCoupons();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeCoupons() {
    _allCoupons = List.generate(49, (index) {
      final bool isFreeDelivery = index % 3 == 0;
      final String promoCode = [
        'Summer50',
        'FUN2022',
        'DISCOVER90',
        'NBA3',
        'SAM30',
        '22NEWYEAR',
        'HOTWINGS',
        'WINTER22',
        'SAVE10',
        'MEGAOFF',
        'SPRINGSALE',
        'AUTUMN23',
        'FLASHDEAL',
        'HAPPYDAY',
        'GIVEME5',
        'BIGSAVER',
        'WOWDEAL',
        'JUMBOFF',
        'NEWUSER',
        'WELCOME15',
        'GETFREE',
        'BUNDLESAVE',
        'FRESHLOOK',
        'DAILYOFFER',
        'WEEKEND',
        'SHOPNOW',
        'TOPDEAL',
        'MAXSAVE',
        'LIMITED',
        'SPECIAL20',
        'SUPER30',
        'GRANDSALE',
        'ECOFRIENDLY',
        'HEALTHYCHOICE',
        'FASTSHIP',
        'PREMIUM',
        'BESTBUY',
        'SMARTCHOICE',
        'EVERGREEN',
        'GLOBALDISCOUNT',
        'EASYBUY',
        'QUICKSALE',
        'SEASONAL',
        'VALUEPACK',
        'URBANSTYLE',
        'MODERNFIT',
        'CLASSIC25',
        'TRENDYLOOK',
        'FUTURETECH',
      ][index % 49];

      final String description =
          'Get ${50 - (index % 10) * 2}% off on all items till ${22 + (index % 5)} March 2022';

      final String imageUrl =
          'https://via.placeholder.com/60/${_getRandomColorHex(index)}/FFFFFF?text=${promoCode.substring(0, 2)}';

      return {
        'NO': index + 1,
        'logo': imageUrl,
        'name': promoCode,
        'description': description,
        'location': 'Cityville, State',
        'ditels': isFreeDelivery,
      };
    });
    _applySearchFilter();
  }

  String _getRandomColorHex(int index) {
    final colors = ['FF5733', '33FF57', '3357FF', 'FF33E9', 'FFC300'];
    return colors[index % colors.length];
  }

  void _applySearchFilter() {
    setState(() {
      if (_searchQuery.isEmpty) {
        _filteredCoupons = List.from(_allCoupons);
      } else {
        final query = _searchQuery.toLowerCase();
        _filteredCoupons = _allCoupons.where((coupon) {
          return (coupon['name'] as String).toLowerCase().contains(query) ||
              coupon['NO'].toString().contains(query) ||
              (coupon['description'] as String).toLowerCase().contains(query) ||
              (coupon['location'] as String).toLowerCase().contains(query);
        }).toList();
      }
      _currentPage = 1;
    });
  }

  List<Map<String, dynamic>> get _currentCoupons {
    final start = (_currentPage - 1) * 10;
    final end = (start + 10).clamp(0, _filteredCoupons.length);
    return _filteredCoupons.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _selectedIndex == 1
                  ? _buildStoreContent()
                  : Center(
                      child: Text(
                        'Content for ${_getSidebarItemTitle(_selectedIndex)}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/logo.jpg',
              height: 32,
              errorBuilder: (_, __, ___) => Container(
                width: 32,
                height: 32,
                color: Colors.amber,
                child: const Icon(
                  Icons.flash_on,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'yorecare',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildSidebarItem(Icons.group, 'Users', 0),
          _buildSidebarItem(Icons.store, 'Stores', 1),
          const Spacer(),
          _buildSidebarItem(Icons.logout, 'Logout', 2),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    final bool isSelected = _selectedIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(colors: [Colors.indigo, Colors.blue])
            : null,
        color: isSelected ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (index == 2) {
              // If Logout is clicked
              Navigator.pushAndRemoveUntil(
                // Use pushAndRemoveUntil to clear navigation stack
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false, // Remove all previous routes
              );
            } else {
              setState(() {
                _selectedIndex = index;
                _currentPage = 1;
                _searchQuery = '';
                _applySearchFilter();
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.grey[700],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getSidebarItemTitle(int index) {
    return switch (index) {
      0 => 'usrers',
      1 => 'Stores',
      2 => 'Logout',
      _ => '',
    };
  }

  Widget _buildStoreContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(),
          const SizedBox(height: 24),
          _buildCouponCards(),
          const SizedBox(height: 20),
          _buildPagination(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Stores  (${_filteredCoupons.length})',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          width: 360,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search stores...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        setState(() => _searchQuery = '');
                        _applySearchFilter();
                      },
                    )
                  : null,
            ),
            onChanged: (v) {
              _searchQuery = v;
              _applySearchFilter();
            },
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () => _showAddNewCouponDialog(context),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add New Store'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildCouponCards() {
    if (_currentCoupons.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            children: [
              Icon(Icons.store_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No stores found',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _currentCoupons.length,
      itemBuilder: (context, index) {
        final coupon = _currentCoupons[index];

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        coupon['logo'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: const Icon(Icons.store, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coupon['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            coupon['description'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                coupon['location'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.indigo),
                          onPressed: () {
                            _showEditCouponDialog(
                              context,
                              coupon,
                            ); // Pass the current coupon data
                          },
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => _confirmDelete(coupon['NO']),
                          tooltip: 'Delete',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPagination() {
    final totalItems = _filteredCoupons.length;
    final totalPages = totalItems == 0 ? 1 : (totalItems / 10).ceil();
    if (_currentPage > totalPages) _currentPage = totalPages;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing ${_currentCoupons.length} of $totalItems entries',
          style: TextStyle(color: Colors.grey[600]),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _currentPage > 1
                  ? () => setState(() => _currentPage--)
                  : null,
            ),
            ...List.generate(totalPages, (i) {
              final page = i + 1;
              return GestureDetector(
                onTap: () => setState(() => _currentPage = page),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _currentPage == page
                        ? Colors.indigo
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$page',
                    style: TextStyle(
                      color: _currentPage == page
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _currentPage < totalPages
                  ? () => setState(() => _currentPage++)
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  void _showAddNewCouponDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final imageCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final locCtrl = TextEditingController();
    bool freeDelivery = false;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, dialogSetState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Add New Stores',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              width: 420,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      decoration: _inputDecoration('Stores Name', Icons.store),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: imageCtrl,
                      decoration: _inputDecoration('Image URL', Icons.image),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descCtrl,
                      maxLines: 3,
                      decoration: _inputDecoration(
                        'Description',
                        Icons.description,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: locCtrl,
                      decoration: _inputDecoration(
                        'Location',
                        Icons.location_on,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                onPressed: () {
                  final name = nameCtrl.text.trim();
                  final img = imageCtrl.text.trim();
                  final desc = descCtrl.text.trim();
                  final loc = locCtrl.text.trim();

                  if (name.isEmpty ||
                      img.isEmpty ||
                      desc.isEmpty ||
                      loc.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields.')),
                    );
                    return;
                  }

                  final newNo = _allCoupons.isEmpty
                      ? 1
                      : _allCoupons
                                .map((e) => e['NO'] as int)
                                .reduce((a, b) => a > b ? a : b) +
                            1;

                  setState(() {
                    _allCoupons.add({
                      'NO': newNo,
                      'logo': img,
                      'name': name,
                      'description': desc,
                      'location': loc,
                      'ditels': freeDelivery,
                    });
                    _searchQuery = '';
                    _applySearchFilter();
                  });

                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Store added!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Add Stores',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    ).then((_) {
      nameCtrl.dispose();
      imageCtrl.dispose();
      descCtrl.dispose();
      locCtrl.dispose();
    });
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.grey[50],
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: const Icon(Icons.warning, color: Colors.red, size: 32),
        title: const Text('Delete Store?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _allCoupons.removeWhere((c) => c['NO'] == id);
                _applySearchFilter();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Store deleted!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showEditCouponDialog(
    BuildContext context,
    Map<String, dynamic> couponToEdit,
  ) {
    final nameCtrl = TextEditingController(text: couponToEdit['name']);
    final imageCtrl = TextEditingController(text: couponToEdit['logo']);
    final descCtrl = TextEditingController(text: couponToEdit['description']);
    final locCtrl = TextEditingController(text: couponToEdit['location']);
    bool freeDelivery =
        couponToEdit['ditels']; // Assuming 'ditels' is free delivery

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, dialogSetState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Edit Store',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              width: 420,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      decoration: _inputDecoration('Store Name', Icons.store),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: imageCtrl,
                      decoration: _inputDecoration('Image URL', Icons.image),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descCtrl,
                      maxLines: 3,
                      decoration: _inputDecoration(
                        'Description',
                        Icons.description,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: locCtrl,
                      decoration: _inputDecoration(
                        'Location',
                        Icons.location_on,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Free Delivery'),
                      value: freeDelivery,
                      onChanged: (bool value) {
                        dialogSetState(() {
                          freeDelivery = value;
                        });
                      },
                      activeColor: Colors.indigo,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                onPressed: () {
                  final name = nameCtrl.text.trim();
                  final img = imageCtrl.text.trim();
                  final desc = descCtrl.text.trim();
                  final loc = locCtrl.text.trim();

                  if (name.isEmpty ||
                      img.isEmpty ||
                      desc.isEmpty ||
                      loc.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields.')),
                    );
                    return;
                  }

                  setState(() {
                    final index = _allCoupons.indexWhere(
                      (c) => c['NO'] == couponToEdit['NO'],
                    );
                    if (index != -1) {
                      _allCoupons[index] = {
                        'NO': couponToEdit['NO'], // Keep the original ID
                        'logo': img,
                        'name': name,
                        'description': desc,
                        'location': loc,
                        'ditels': freeDelivery,
                      };
                    }
                    _applySearchFilter(); // Re-apply filter to update UI
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Store updated!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    ).then((_) {
      nameCtrl.dispose();
      imageCtrl.dispose();
      descCtrl.dispose();
      locCtrl.dispose();
    });
  }
}
