import 'package:flutter/material.dart';

class Product {
  final int no;
  final String name;
  final String sku;
  final String details;
  final double mrp;
  final double discountPercentage;
  final String imageAsset;

  Product({
    required this.no,
    required this.name,
    this.sku = '',
    required this.details,
    required this.mrp,
    required this.discountPercentage,
    this.imageAsset = '',
    // Removed the 'price' parameter from the constructor as it was redundant
    // and not being used to store a separate value.
  });

 double get totalPrice => mrp * (1 - discountPercentage / 100);
double get price => totalPrice;

}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeProducts();
    _filteredProducts = _allProducts;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _initializeProducts() {
    _allProducts = [
      // Removed 'price' parameter from product instantiation, it will now be calculated by the getter
      Product(no: 1, name: 'Nike Air Max 270', sku: 'NIKE270', details: 'Men\'s running, black/white, lightweight', mrp: 12999.00, discountPercentage: 30, imageAsset: 'https://picsum.photos/id/1/100/100'),
      Product(no: 2, name: 'Samsung 4K TV', sku: 'SAMTV55', details: '55-inch Smart LED TV with HDR support', mrp: 49999.00, discountPercentage: 24, imageAsset: 'https://picsum.photos/id/10/100/100'),
      Product(no: 3, name: 'Esha Cotton Shirt', sku: 'ESHSHIRT', details: 'Blue, size M, 100% breathable cotton fabric', mrp: 1499.00, discountPercentage: 10, imageAsset: 'https://picsum.photos/id/100/100/100'),
      Product(no: 4, name: 'Esha Leather Wallet', sku: 'ESHWALLET', details: 'Genuine brown leather wallet with multiple card slots', mrp: 599.00, discountPercentage: 27, imageAsset: 'https://picsum.photos/id/1000/100/100'),
      Product(no: 5, name: 'HP Spectre x360', sku: 'HPSPECTRE', details: '13.3" 2-in-1 Laptop, i7 processor, 16GB RAM', mrp: 99999.00, discountPercentage: 15, imageAsset: 'https://picsum.photos/id/1002/100/100'),
      Product(no: 6, name: 'Sony WH-1000XM4', sku: 'SONY1000', details: 'Industry-leading noise cancelling headphones with premium sound', mrp: 29999.00, discountPercentage: 20, imageAsset: 'https://picsum.photos/id/1003/100/100'),
      Product(no: 7, name: 'Instant Pot Duo', sku: 'INSTPOT6', details: '7-in-1 Electric Pressure Cooker, 6 Quart', mrp: 7999.00, discountPercentage: 18, imageAsset: 'https://picsum.photos/id/1004/100/100'),
      Product(no: 8, name: 'Kindle Paperwhite', sku: 'KINDLEPW', details: 'Waterproof E-reader with a built-in adjustable light', mrp: 10999.00, discountPercentage: 12, imageAsset: 'https://picsum.photos/id/1005/100/100'),
      Product(no: 9, name: 'Logitech MX Master 3', sku: 'LOGIMX3', details: 'Advanced Wireless Mouse with MagSpeed scrolling', mrp: 9999.00, discountPercentage: 8, imageAsset: 'https://picsum.photos/id/1006/100/100'),
      Product(no: 10, name: 'Google Nest Hub', sku: 'NESTHUB', details: 'Smart Display with Google Assistant and 7" screen', mrp: 6999.00, discountPercentage: 14, imageAsset: 'https://picsum.photos/id/1008/100/100'),
      Product(no: 11, name: 'Apple Watch Series 7', sku: 'AWATCH7', details: 'GPS + Cellular, Aluminium Case, Midnight color', mrp: 41900.00, discountPercentage: 10, imageAsset: 'https://picsum.photos/id/101/100/100'),
      Product(no: 12, name: 'Dyson V11 Absolute', sku: 'DYSV11', details: 'Cordless Vacuum Cleaner with powerful suction', mrp: 52900.00, discountPercentage: 15, imageAsset: 'https://picsum.photos/id/1011/100/100'),
      Product(no: 13, name: 'Bose QuietComfort Earbuds', sku: 'BOSECQ', details: 'Noise Cancelling, True Wireless with secure fit', mrp: 26900.00, discountPercentage: 18, imageAsset: 'https://picsum.photos/id/1012/100/100'),
      Product(no: 14, name: 'GoPro HERO10 Black', sku: 'GOPRO10', details: 'Waterproof Action Camera with 5.3K video', mrp: 44900.00, discountPercentage: 22, imageAsset: 'https://picsum.photos/id/1013/100/100'),
      Product(no: 15, name: 'Nintendo Switch OLED', sku: 'NINTDOLED', details: '7-inch OLED Screen, brighter colors, enhanced audio', mrp: 34900.00, discountPercentage: 5, imageAsset: 'https://picsum.photos/id/1014/100/100'),
      Product(no: 16, name: 'Fitbit Charge 5', sku: 'FITBITC5', details: 'Advanced Fitness Tracker with EDA Sensor', mrp: 14900.00, discountPercentage: 20, imageAsset: 'https://picsum.photos/id/1015/100/100'),
      Product(no: 17, name: 'Echo Dot (4th Gen)', sku: 'ECHODOT4', details: 'Smart Speaker with Alexa, charcoal fabric', mrp: 4499.00, discountPercentage: 25, imageAsset: 'https://picsum.photos/id/1016/100/100'),
      Product(no: 18, name: 'Razer DeathAdder V2', sku: 'RAZERDV2', details: 'Ergonomic Gaming Mouse, 20K DPI optical sensor', mrp: 5999.00, discountPercentage: 10, imageAsset: 'https://picsum.photos/id/1018/100/100'),
      Product(no: 19, name: 'Philips Hue Starter Kit', sku: 'PHILHUE', details: 'Smart Lighting, White & Color Ambiance', mrp: 8999.00, discountPercentage: 12, imageAsset: 'https://picsum.photos/id/1019/100/100'),
      Product(no: 20, name: 'Sony PlayStation 5', sku: 'PS5DISK', details: 'Disc Edition Console, next-gen gaming experience', mrp: 49990.00, discountPercentage: 0, imageAsset: 'https://picsum.photos/id/102/100/100'),
    ];
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.details.toLowerCase().contains(query) ||
            product.sku.toLowerCase().contains(query);
      }).toList();
      _currentPage = 1; // Reset to first page on search
    });
  }

  List<Product> get _productsToShow {
    final start = (_currentPage - 1) * _itemsPerPage;
    final end = (start + _itemsPerPage).clamp(0, _filteredProducts.length);
    return _filteredProducts.sublist(start.clamp(0, _filteredProducts.length), end);
  }

  int get _totalPages => (_filteredProducts.length / _itemsPerPage).ceil();

  void _goToPage(int page) {
    if (page > 0 && page <= _totalPages && page != _currentPage) {
      setState(() {
        _currentPage = page;
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    }
  }

  void _confirmAndDeleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Confirm Deletion', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to delete "${product.name}"? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color for delete button
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  _allProducts.removeWhere((p) => p.no == product.no);
                  _onSearchChanged(); // Re-filter and update pagination after deletion
                  if (_productsToShow.isEmpty && _currentPage > 1) {
                    _currentPage--; // Go to previous page if current page becomes empty
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} deleted!'), backgroundColor: Colors.red));
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // --- Sticky Search + Add Product Header ---
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: AnimatedPhysicalModel(
                duration: const Duration(milliseconds: 200),
                color: Colors.grey[50]!,
                elevation: _scrollController.hasClients && _scrollController.offset > 0 ? 4 : 0,
                shadowColor: Colors.black,
                shape: BoxShape.rectangle,
                child: _buildHeaderAndSearchBar(),
              ),
            ),
          ),

          // --- Product List ---
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = _productsToShow[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  child: _buildProductCardItem(product),
                );
              },
              childCount: _productsToShow.length,
            ),
          ),

          // --- No Product Case ---
          if (_productsToShow.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('No products found', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                    ],
                  ),
                ),
              ),
            ),

          // --- Pagination at bottom ---
          if (_filteredProducts.isNotEmpty)
            SliverToBoxAdapter(child: _buildPagination()),
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
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/logo.jpg',
              height: 34,
              errorBuilder: (_, __, ___) => Container(
                width: 34,
                height: 34,
                color: Colors.amber,
                child: const Icon(Icons.flash_on, color: Colors.white, size: 18),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Yorecare',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 1.2),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildProductCardItem(Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageAsset,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(product.details, style: TextStyle(fontSize: 13, color: Colors.grey[600]), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildPriceChip('MRP', '₹${product.mrp.toStringAsFixed(0)}', Colors.grey),
                      const SizedBox(width: 8),
                      // Now using product.totalPrice, which is the actual price after discount
                      _buildPriceChip('Price', '₹${product.totalPrice.toStringAsFixed(0)}', Colors.green),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: product.discountPercentage > 20 ? Colors.green[50] : Colors.orange[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: product.discountPercentage > 20 ? Colors.green[300]! : Colors.orange[300]!,
                ),
              ),
              child: Text(
                '${product.discountPercentage.toInt()}% OFF',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: product.discountPercentage > 20 ? Colors.green[700] : Colors.orange[700],
                ),
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.indigo),
              onPressed: () => _showEditProductDialog(context, product),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _confirmAndDeleteProduct(product),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderAndSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Products (${_filteredProducts.length})',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const Spacer(), // Pushes search and add button to the right
              SizedBox(
                width: 300, // Fixed width for search bar
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged();
                      },
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => _showAddProductDialog(context),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add New Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceChip(String label, String price, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 12),
          children: [
            TextSpan(text: '$label: ', style: TextStyle(color: Colors.grey[700])),
            TextSpan(text: price, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    final start = ((_currentPage - 1) * _itemsPerPage + 1).clamp(1, _filteredProducts.length);
    final end = (_currentPage * _itemsPerPage).clamp(0, _filteredProducts.length);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing $start to $end of ${_filteredProducts.length} entries',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _currentPage > 1 ? () => _goToPage(_currentPage - 1) : null,
                icon: Icon(Icons.chevron_left, color: _currentPage > 1 ? Colors.indigo : Colors.grey),
              ),
              ...List.generate(_totalPages, (i) {
                final page = i + 1;
                return GestureDetector(
                  onTap: () => _goToPage(page),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _currentPage == page ? Colors.indigo : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _currentPage == page ? Colors.indigo : Colors.grey[300]!),
                    ),
                    child: Text(
                      '$page',
                      style: TextStyle(
                        color: _currentPage == page ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
              IconButton(
                onPressed: _currentPage < _totalPages ? () => _goToPage(_currentPage + 1) : null,
                icon: Icon(Icons.chevron_right, color: _currentPage < _totalPages ? Colors.indigo : Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- ADD PRODUCT DIALOG ---
  void _showAddProductDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final skuCtrl = TextEditingController(); // New SKU controller
    final imageCtrl = TextEditingController();
    final detailsCtrl = TextEditingController();
    final mrpCtrl = TextEditingController();
    // Removed priceCtrl as price is calculated
    final discountCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add New Product', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameCtrl, 'Product Name', Icons.inventory),
                const SizedBox(height: 16),
                _buildTextField(skuCtrl, 'SKU (Optional)', Icons.code), // New SKU field
                const SizedBox(height: 16),
                _buildTextField(imageCtrl, 'Image URL', Icons.image),
                const SizedBox(height: 16),
                _buildTextField(detailsCtrl, 'Details', Icons.description, maxLines: 3),
                const SizedBox(height: 16),
                _buildTextField(mrpCtrl, 'MRP (₹)', Icons.currency_rupee, keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                // Removed the Price field from the Add dialog
                _buildTextField(discountCtrl, 'Discount %', Icons.percent, keyboardType: TextInputType.number),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            onPressed: () {
              final name = nameCtrl.text.trim();
              final sku = skuCtrl.text.trim(); // Get SKU from controller
              final image = imageCtrl.text.trim();
              final details = detailsCtrl.text.trim();
              final mrpText = mrpCtrl.text.trim();
              final discountText = discountCtrl.text.trim();

              if (name.isEmpty || image.isEmpty || details.isEmpty || mrpText.isEmpty || discountText.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All fields required except SKU')));
                return;
              }

              final mrp = double.tryParse(mrpText) ?? 0;
              final discount = double.tryParse(discountText) ?? 0;

              if (mrp <= 0 || discount < 0 || discount > 100) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid values')));
                return;
              }

              final newProduct = Product(
                no: _allProducts.isEmpty ? 1 : _allProducts.last.no + 1,
                name: name,
                sku: sku.isNotEmpty ? sku : name.split(' ').take(2).map((e) => e[0].toUpperCase()).join(), // Use custom SKU or generate
                details: details,
                mrp: mrp,
                discountPercentage: discount,
                imageAsset: image,
                // The 'price' field is not passed directly, it's derived.
              );

              setState(() {
                _allProducts.add(newProduct);
                _onSearchChanged(); // Re-filter to include new product
                _currentPage = 1; // Go to first page to see the new product
              });

              _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added!'), backgroundColor: Colors.green));
              Navigator.pop(context);
            },
            child: const Text('Add Product', style: TextStyle(color: Colors.white)), // Text color added
          ),
        ],
      ),
    ).then((_) {
      nameCtrl.dispose();
      skuCtrl.dispose(); // Dispose SKU controller
      imageCtrl.dispose();
      detailsCtrl.dispose();
      mrpCtrl.dispose();
      // priceCtrl.dispose(); // Disposed if it existed
      discountCtrl.dispose();
    });
  }


  // --- EDIT PRODUCT DIALOG ---
  void _showEditProductDialog(BuildContext context, Product product) {
    final nameCtrl = TextEditingController(text: product.name);
    final skuCtrl = TextEditingController(text: product.sku); // New SKU controller, pre-filled
    final imageCtrl = TextEditingController(text: product.imageAsset);
    final detailsCtrl = TextEditingController(text: product.details);
    final mrpCtrl = TextEditingController(text: product.mrp.toStringAsFixed(0));
    final priceCtrl = TextEditingController(text: product.price.toStringAsFixed(0));
final discountCtrl = TextEditingController(text: product.discountPercentage.toStringAsFixed(0));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Product', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameCtrl, 'Product Name', Icons.inventory),
                const SizedBox(height: 16),
                _buildTextField(skuCtrl, 'SKU', Icons.code), // New SKU field
                const SizedBox(height: 16),
                _buildTextField(imageCtrl, 'Image URL', Icons.image),
                const SizedBox(height: 16),
                _buildTextField(detailsCtrl, 'Details', Icons.description, maxLines: 3),
                const SizedBox(height: 16),
                _buildTextField(mrpCtrl, 'MRP (₹)', Icons.currency_rupee, keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildTextField(priceCtrl, 'Price (₹)', Icons.currency_rupee, keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildTextField(discountCtrl, 'Discount %', Icons.percent, keyboardType: TextInputType.number),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white), // Added foregroundColor here too
            onPressed: () {
              final name = nameCtrl.text.trim();
              final sku = skuCtrl.text.trim(); // Get SKU from controller
              final image = imageCtrl.text.trim();
              final details = detailsCtrl.text.trim();
              final mrp = double.tryParse(mrpCtrl.text.trim()) ?? 0;

              final discount = double.tryParse(discountCtrl.text.trim()) ?? 0;

              if (name.isEmpty || sku.isEmpty || image.isEmpty || details.isEmpty || mrp <= 0 || discount < 0 || discount > 100) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid input')));
                return;
              }

              setState(() {
                final index = _allProducts.indexOf(product);
                if (index != -1) {
                _allProducts[index] = Product(
  no: product.no,
  name: name,
  sku: sku,
  details: details,
  mrp: mrp,
  discountPercentage: discount,
  imageAsset: image,
);

                }
                _onSearchChanged(); // Re-filter to reflect changes
              });

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated!'), backgroundColor: Colors.green));
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    ).then((_) {
      nameCtrl.dispose();
      skuCtrl.dispose(); // Dispose SKU controller
      imageCtrl.dispose();
      detailsCtrl.dispose();
      mrpCtrl.dispose();
      discountCtrl.dispose();
    });
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }
}
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child is PreferredSizeWidget
      ? (child as PreferredSizeWidget).preferredSize.height
      : 100; // allow more height

  @override
  double get minExtent => child is PreferredSizeWidget
      ? (child as PreferredSizeWidget).preferredSize.height
      : 100;

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) => false;
}