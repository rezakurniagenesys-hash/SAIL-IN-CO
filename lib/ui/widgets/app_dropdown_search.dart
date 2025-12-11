import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class AppDropdownSearch<T> extends StatefulWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? hintText;
  final String? Function(T?)? validator;
  final bool enabled;
  final Color borderSideColor;
  final String Function(T item) display;
  final bool Function(T a, T b)? compare;

  const AppDropdownSearch({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.display,
    this.label,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.borderSideColor = AppColors.neutral300,
    this.compare,
  });

  @override
  State<AppDropdownSearch<T>> createState() => _AppDropdownSearchState<T>();
}

class _AppDropdownSearchState<T> extends State<AppDropdownSearch<T>> {
  late TextEditingController _controller; // display only
  late TextEditingController _searchController; // search in overlay

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  List<T> _filteredItems = [];
  bool _isFocused = false;
  bool _overlayVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.value == null ? '' : widget.display(widget.value as T));

    _searchController = TextEditingController();

    _filteredItems = widget.items;

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(covariant AppDropdownSearch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update items jika berubah
    if (oldWidget.items != widget.items) {
      setState(() {
        _filteredItems = widget.items;
      });
    }

    // Update value jika berubah
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value == null ? '' : widget.display(widget.value as T);
    }
  }

  bool isEqual(T a, T b) {
    if (widget.compare != null) return widget.compare!(a, b);
    return a == b;
  }

  void _onSearchChanged() {
    setState(() {
      _filteredItems = widget.items.where((item) => widget.display(item).toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    });

    _refreshOverlay();
  }

  // ------------------ OVERLAY -------------------

  void _showOverlay(FormFieldState<T> field) {
    if (!mounted || _overlayEntry != null || !widget.enabled) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(child: GestureDetector(onTap: _hideOverlay)),

          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, size.height + 4),
              showWhenUnlinked: false,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SEARCH INPUT IN OVERLAY
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Cari...",
                          hintStyle: const TextStyle(color: AppColors.neutral400, fontSize: 12),
                          prefixIcon: const Icon(Icons.search, size: 18),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        style: AppTextStyles.body4Reguler.copyWith(fontSize: 12),
                      ),
                    ),

                    // LIST ITEMS
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 220),
                      child: _filteredItems.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text("Tidak ada hasil", style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral400, fontSize: 12)),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: _filteredItems.length,
                              itemBuilder: (_, index) {
                                final item = _filteredItems[index];
                                final selected = widget.value != null && isEqual(item, widget.value as T);

                                return InkWell(
                                  onTap: () {
                                    field.didChange(item); // ✔ FIX: beri tahu FormField bahwa value berubah
                                    widget.onChanged(item); // provider update
                                    _controller.text = widget.display(item);

                                    setState(() {
                                      _filteredItems = widget.items;
                                    });

                                    _hideOverlay();
                                    FocusScope.of(context).unfocus();
                                  },

                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(color: selected ? AppColors.sky950 : Colors.transparent),
                                    child: Text(
                                      widget.display(item),
                                      style: AppTextStyles.body4Reguler.copyWith(
                                        color: selected ? AppColors.white : AppColors.textPrimary,
                                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _overlayVisible = true);
  }

  void _refreshOverlay() => _overlayEntry?.markNeedsBuild();

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    setState(() {
      _overlayVisible = false;
      _searchController.clear(); // reset search setiap tutup dropdown
      _filteredItems = widget.items;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  // ------------------ WIDGET UTAMA -------------------
  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: widget.validator,
      initialValue: widget.value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                onTap: () => _showOverlay(field),
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextField(
                    controller: _controller,
                    readOnly: true,
                    enabled: widget.enabled,
                    style: AppTextStyles.body4Reguler.copyWith(color: widget.enabled ? AppColors.textPrimary : AppColors.neutral400, fontSize: 13),
                    decoration: InputDecoration(
                      labelText: widget.label,
                      hintText: widget.hintText ?? "Pilih...",
                      labelStyle: AppTextStyles.body4Medium.copyWith(color: _isFocused ? AppColors.sky950 : AppColors.neutral400, fontSize: 13),
                      floatingLabelStyle: AppTextStyles.body4Medium.copyWith(color: AppColors.sky950, fontWeight: FontWeight.w600),
                      filled: true,
                      fillColor: widget.enabled ? AppColors.white : AppColors.neutral100,
                      suffixIcon: Icon(_overlayVisible ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: AppColors.sky950),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

                      // BORDER NORMAL (tidak berubah saat error)
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: widget.borderSideColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.sky950, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      // errorStyle tinggi 0 agar tidak merusak layout
                      errorStyle: const TextStyle(height: 0),

                      // HAPUS errorBorder & focusedErrorBorder
                    ),
                  ),
                ),
              ),
            ),

            // ==== ERROR TEXT DITAMPILKAN MANUAL ====
            if (field.errorText != null && _controller.text.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(field.errorText!, style: const TextStyle(color: Colors.red, fontSize: 11)),
              ),
          ],
        );
      },
    );
  }
}
