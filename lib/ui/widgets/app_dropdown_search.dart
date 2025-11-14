import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class AppDropdownSearch extends StatefulWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final Color borderSideColor;

  const AppDropdownSearch({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.borderSideColor = AppColors.neutral300,
  });

  @override
  State<AppDropdownSearch> createState() => _AppDropdownSearchState();
}

class _AppDropdownSearchState extends State<AppDropdownSearch> {
  late TextEditingController _controller;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<String> _filteredItems = [];
  bool _isFocused = false;
  bool _isOverlayVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _filteredItems = widget.items;
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _filteredItems = widget.items.where((item) => item.toLowerCase().contains(_controller.text.toLowerCase())).toList();
    });

    // jika overlay belum tampil, langsung tampilkan
    if (!_isOverlayVisible && widget.enabled) {
      _showOverlay();
    } else {
      _refreshOverlay();
    }
  }

  void _toggleOverlay() {
    if (_isOverlayVisible) {
      _hideOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    if (!mounted || _overlayEntry != null) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _hideOverlay,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 4),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  child: ConstrainedBox(
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
                              final selected = item == widget.value;
                              return InkWell(
                                onTap: () {
                                  widget.onChanged(item);
                                  _controller.text = item;
                                  _hideOverlay();
                                  if (mounted) FocusScope.of(context).unfocus();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(color: selected ? AppColors.sky950 : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    item,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final overlay = Overlay.of(context);
    if (mounted) {
      overlay.insert(_overlayEntry!);
      setState(() => _isOverlayVisible = true);
    }
  }

  void _refreshOverlay() => _overlayEntry?.markNeedsBuild();

  void _hideOverlay() {
    if (!mounted) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() => _isOverlayVisible = false);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();

    // pastikan overlay dihapus tanpa akses context
    _overlayEntry?.remove();
    _overlayEntry = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() => _isFocused = hasFocus);
          if (!hasFocus) _hideOverlay();
        },
        child: TextFormField(
          enabled: widget.enabled,
          controller: _controller,
          validator: widget.validator,
          style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText ?? 'Pilih atau cari...',
            hintStyle: const TextStyle(color: AppColors.neutral400, fontSize: 13),
            labelStyle: AppTextStyles.body4Medium.copyWith(color: _isFocused ? AppColors.sky950 : AppColors.neutral400, fontSize: 13),
            floatingLabelStyle: AppTextStyles.body4Medium.copyWith(color: AppColors.sky950, fontWeight: FontWeight.w600),
            filled: true,
            fillColor: widget.enabled ? AppColors.white : AppColors.neutral100,
            suffixIcon: IconButton(
              icon: Icon(_isOverlayVisible ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: AppColors.sky950),
              onPressed: _toggleOverlay,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.borderSideColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.sky950, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
