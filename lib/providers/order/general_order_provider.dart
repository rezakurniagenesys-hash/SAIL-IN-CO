import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/models/general/general_uoms/general_uoms_response.dart';
import 'package:sail_in_co/data/models/general/order/general_order_draft_item.dart';
import 'package:sail_in_co/ui/widgets/app_snackbar.dart';

class GeneralOrderProvider extends ChangeNotifier {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController priceUIController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController currentStockController = TextEditingController();
  final TextEditingController qtyDefaultController = TextEditingController();
  final TextEditingController uomDefaultController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> oldInventoryIds = [];

  InventoryItem? inventorySelected;
  UOMItem? uomSelected;
  UOMItem? uomSelectedDefauld;

  int totalPrice = 0;

  int _parseInt(String? value) => int.tryParse(value ?? '') ?? 0;

  UOMItem _getDefaultUom(InventoryItem item) {
    return item.uoms?.firstWhere(
          (u) => u.isDefault == 1,
          orElse: () => UOMItem(uomId: '', uomName: '', value: '1', isDefault: 1, inventoryId: '', notes: ''),
        ) ??
        UOMItem(uomId: '', uomName: '', value: '1', isDefault: 1, inventoryId: '', notes: '');
  }

  // ==============================
  // CALCULATE TOTAL
  // ==============================
  void _calculateTotalPrice() {
    final qty = _parseInt(qtyController.text);
    final price = _parseInt(priceController.text);
    final multiplier = _parseInt(uomSelected?.value ?? '1');
    final discount = _parseInt(discountController.text);

    priceUIController.text = (multiplier * price).toString();

    // total sebelum diskon → originPrice
    final subtotal = qty * multiplier * price;

    // total setelah diskon → totalPrice
    final discountTotal = discount * qty; // atau qtyDefault
    totalPrice = (subtotal - discountTotal).clamp(0, 999999999);

    notifyListeners();
  }

  void _updateQtyDefault() {
    final qty = _parseInt(qtyController.text);
    final multiplier = _parseInt(uomSelected?.value ?? "1");
    qtyDefaultController.text = (qty * multiplier).toString();
  }

  // ==============================
  // SETTERS
  // ==============================
  void setInventorySelected(InventoryItem? item) {
    inventorySelected = item;

    if (item == null) {
      clearSelection();
      return;
    }

    qtyController.clear();
    qtyDefaultController.clear();
    discountController.clear();
    totalPrice = 0;

    priceController.text = item.price?.toString() ?? "0";
    priceUIController.text = item.price?.toString() ?? "0";
    currentStockController.text = item.currentStock.toString();

    final defaultUom = _getDefaultUom(item);
    uomSelected = defaultUom;
    uomSelectedDefauld = defaultUom;
    uomDefaultController.text = defaultUom.uomName;

    _calculateTotalPrice();
  }

  void setQty(String value) {
    qtyController.text = _parseInt(value).toString();
    _updateQtyDefault();
    _calculateTotalPrice();
  }

  void setUomSelected(UOMItem? item) {
    uomSelected = item;
    _updateQtyDefault();
    _calculateTotalPrice();
  }

  void setDiscount(String value) {
    discountController.text = _parseInt(value).toString();
    _calculateTotalPrice();
  }

  void setNotes(String value) {
    notesController.text = value;
    notifyListeners();
  }

  void setOldInventoryIds(List<String> ids) {
    oldInventoryIds = ids;
    notifyListeners();
  }

  // ==============================
  // INIT EDIT
  // ==============================
  void initEdit(GeneralOrderDraftItem item) {
    inventorySelected = item.inventory;
    uomSelected = item.uom;

    priceController.text = item.price.toString();
    qtyController.text = item.qty2.toString();
    uomSelectedDefauld = _getDefaultUom(item.inventory);
    qtyDefaultController.text = item.qty.toString();
    uomDefaultController.text = item.defaultUomName;
    priceUIController.text = (int.parse(item.uom.value) * item.price).toString();
    discountController.text = item.discount.toString();
    notesController.text = item.notes;
    currentStockController.text = item.inventory.currentStock.toString();
    _updateQtyDefault();
    _calculateTotalPrice();
    notifyListeners();
  }

  // ==============================
  // SUBMIT
  // ==============================

  void submit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      // stok kosong
      if (_parseInt(inventorySelected?.currentStock.toString()) <= 0) {
        AppSnackBar.show(context, message: "Stok kosong!", color: Colors.red);
        return;
      }

      // cek stok
      if (_parseInt(qtyDefaultController.text) > _parseInt(inventorySelected?.currentStock.toString())) {
        AppSnackBar.show(context, message: "Stok tidak mencukupi!", color: Colors.red);
        return;
      }

      // duplikasi
      // if (oldInventoryIds.contains(inventorySelected?.inventoryId)) {
      //   AppSnackBar.show(context, message: "Produk sudah ada dalam daftar!", color: Colors.red);
      //   return;
      // }

      // ==============================
      // HITUNG QTY
      // ==============================
      final int qtyInput = _parseInt(qtyController.text); // qty2
      final int multiplier = _parseInt(uomSelected?.value ?? "1");
      final int qtyDefault = qtyInput * multiplier; // qty (PCS)

      // ==============================
      // HITUNG HARGA
      // ==============================
      final int smallUnitPrice = _parseInt(priceController.text); // harga per PCS

      // subtotal sebelum diskon
      final int subTotal = qtyDefault * smallUnitPrice;

      // diskon per PCS
      final int discount = _parseInt(discountController.text);
      final int discountTotal = discount * qtyDefault;

      // total akhir
      final int grandTotal = (subTotal - discountTotal).clamp(0, 999999999);

      // ==============================
      // SIMPAN KE MODEL
      // ==============================
      final result = GeneralOrderDraftItem(
        inventory: inventorySelected!,
        uom: uomSelected!,

        voidValue: 0,
        user_record: '',

        uom_id: uomSelectedDefauld!.uomId, // DEFAULT UOM
        uom_id2: uomSelected!.uomId, // SELECTED UOM

        qty: qtyDefault, // small unit qty
        qty2: qtyInput, // input UI qty
        defaultUomName: uomDefaultController.text,

        discount: discount,
        notes: notesController.text,

        price: smallUnitPrice,
        sub_total: subTotal,
        grand_total: grandTotal,

        index: 0,
      );

      Navigator.of(context).pop(result);
      return;
    }

    AppSnackBar.show(context, message: "Form belum lengkap!", color: Colors.red);
  }

  // void submit(BuildContext context) {
  //   print('Qty: ${qtyController.text}, UoM: ${uomSelected?.uomName}, Price: ${priceController.text}, Discount: ${discountController.text}');
  //   if (formKey.currentState?.validate() ?? false) {
  //     // stock kosong
  //     if (_parseInt(inventorySelected?.currentStock.toString()) <= 0) {
  //       AppSnackBar.show(context, message: "Stok kosong!", color: Colors.red);
  //       return;
  //     }

  //     if (_parseInt(qtyDefaultController.text) > _parseInt(inventorySelected?.currentStock.toString())) {
  //       AppSnackBar.show(context, message: "Stok tidak mencukupi!", color: Colors.red);
  //       return;
  //     }

  //     if (oldInventoryIds.contains(inventorySelected?.inventoryId)) {
  //       AppSnackBar.show(context, message: "Produk sudah ada dalam daftar!", color: Colors.red);
  //       return;
  //     }

  //     final qty = _parseInt(qtyController.text);
  //     final price = _parseInt(priceController.text);
  //     final multiplier = _parseInt(uomSelected?.value ?? "1");
  //     final discount = _parseInt(discountController.text);

  //     final originPrice = qty * multiplier * price; // sebelum diskon
  //     final totalAfterDiscount = (originPrice - (discount * qty * multiplier)).clamp(0, 999999999);

  //     final result = GeneralOrderDraftItem(
  //       inventory: inventorySelected!,
  //       uom: uomSelected!,
  //       price: originPrice,
  //       qty: qty * multiplier,
  //       qty2: qty,
  //       defaultUomName: uomDefaultController.text,
  //       uom_id2: uomSelected!.uomId,
  //       uom_id: uomSelectedDefauld!.uomId,
  //       // idDefaultUom
  //       discount: discount,
  //       notes: notesController.text,
  //       user_record: '',
  //       voidValue: 0,
  //       sub_total: originPrice,
  //       grand_total: totalAfterDiscount,
  //       index: 0,
  //     );

  //     Navigator.of(context).pop(result);
  //     return;
  //   }

  //   AppSnackBar.show(context, message: "Form belum lengkap!", color: Colors.red);
  // }

  // ==============================
  // CLEAR
  // ==============================
  void clearSelection() {
    inventorySelected = null;
    uomSelected = null;
    uomSelectedDefauld = null;

    priceController.clear();
    priceUIController.clear();
    qtyController.clear();
    qtyDefaultController.clear();
    uomDefaultController.clear();
    discountController.clear();
    notesController.clear();
    currentStockController.clear();

    oldInventoryIds.clear();
    totalPrice = 0;

    notifyListeners();
  }
}
