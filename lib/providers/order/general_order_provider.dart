// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/models/general/general_uoms/general_uoms_response.dart';
import 'package:sail_in_co/data/models/general/order/general_order_draft_item.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/services/lockstock_service.dart';
import 'package:sail_in_co/ui/widgets/app_snackbar.dart';

enum OrderPriceMode { lockedFromMaster, editable }

enum OrderType { salesOrder, returnOrder, quickSales }

class GeneralOrderProvider extends ChangeNotifier {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController priceUIController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController currentStockController = TextEditingController();
  final TextEditingController qtyDefaultController = TextEditingController();
  final TextEditingController uomDefaultController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  OrderPriceMode priceMode = OrderPriceMode.lockedFromMaster;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> oldInventoryIds = [];

  InventoryItem? inventorySelected;
  UOMItem? uomSelected;
  UOMItem? uomSelectedDefauld;

  int totalPrice = 0;
  bool isEditingPriceUI = false;

  OrderType orderType = OrderType.quickSales;

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
    final pricePCS = _parseInt(priceController.text);
    final multiplier = _parseInt(uomSelected?.value ?? '1');
    final discount = _parseInt(discountController.text);

    // UI hanya refleksi
    priceUIController.text = (pricePCS * multiplier).toString();

    final subtotal = qty * multiplier * pricePCS;
    final discountTotal = discount * qty;
    // * multiplier;

    totalPrice = (subtotal - discountTotal).clamp(0, 999999999);
    notifyListeners();
  }

  // void _calculateTotalPrice() {
  //   final qty = _parseInt(qtyController.text);
  //   final price = _parseInt(priceController.text);
  //   final multiplier = _parseInt(uomSelected?.value ?? '1');
  //   final discount = _parseInt(discountController.text);

  //   priceUIController.text = (multiplier * price).toString();

  //   // total sebelum diskon → originPrice
  //   final subtotal = qty * multiplier * price;

  //   // total setelah diskon → totalPrice
  //   final discountTotal = discount * qty; // atau qtyDefault
  //   totalPrice = (subtotal - discountTotal).clamp(0, 999999999);

  //   notifyListeners();
  // }

  void _updateQtyDefault() {
    final qty = _parseInt(qtyController.text);
    final multiplier = _parseInt(uomSelected?.value ?? "1");
    qtyDefaultController.text = (qty * multiplier).toString();
  }

  // ==============================
  // SETTERS
  // ==============================
  // void setInventorySelected(InventoryItem? item) {
  //   inventorySelected = item;

  //   formKey.currentState?.reset();

  //   if (item == null) {
  //     clearSelection();
  //     return;
  //   }

  //   qtyController.clear();
  //   qtyDefaultController.clear();
  //   discountController.clear();
  //   totalPrice = 0;

  //   priceController.text = item.price?.toString() ?? "0";
  //   priceUIController.text = item.price?.toString() ?? "0";
  //   currentStockController.text = item.currentStock.toString().replaceAll(RegExp(r'\.0$'), '');

  //   final defaultUom = _getDefaultUom(item);
  //   uomSelected = defaultUom;
  //   uomSelectedDefauld = defaultUom;
  //   uomDefaultController.text = defaultUom.uomName;

  //   print('inventorySelected: ${inventorySelected?.inventoryId}, defaultUom: ${uomSelectedDefauld?.uomName}');

  //   _calculateTotalPrice();
  // }

  void setInventorySelected(InventoryItem? item) {
    inventorySelected = item;
    formKey.currentState?.reset();

    if (item == null) {
      clearSelection();
      return;
    }

    qtyController.clear();
    qtyDefaultController.clear();
    discountController.clear();
    totalPrice = 0;

    final int masterPrice = _parseInt(item.price?.toString());

    // price per PCS (logic)
    priceController.text = masterPrice.toString();

    // price UI = PCS × multiplier
    final multiplier = _parseInt(_getDefaultUom(item).value);
    priceUIController.text = (masterPrice * multiplier).toString();

    currentStockController.text = item.currentStock.toString().replaceAll(RegExp(r'\.0$'), '');

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
    priceUIController.text = '';
    uomSelected = item;

    final multiplier = _parseInt(item?.value ?? "1");
    final pricePCS = _parseInt(priceController.text);

    priceUIController.text = (pricePCS * multiplier).toString();

    if (priceMode == OrderPriceMode.editable) {
      discountController.text = '';
    }

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

  void setPriceMode(OrderPriceMode mode) {
    priceMode = mode;
    notifyListeners();
  }

  void setPrice(String value) {
    if (priceMode == OrderPriceMode.lockedFromMaster) return;

    priceController.text = _parseInt(value).toString();
    _calculateTotalPrice();
  }

  void setType(OrderType type) {
    orderType = type;
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

  void submit(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final isStockLocked = await LockStockService.getBool(LockStockKey.kunciStock.value);
    final isUnlockSO = await LockStockService.getBool(LockStockKey.bukaKunciStockSO.value);
    formKey.currentState?.save();
    formKey.currentState?.reset();
    if (formKey.currentState?.validate() ?? false) {
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

      // diskon per PCS
      final int discount = _parseInt(discountController.text);
      final int discountTotal = discount * qtyInput;

      final int subTotal = ((qtyDefault * smallUnitPrice) - discountTotal).clamp(0, 999999999);
      // total akhir
      final int grandTotal = ((qtyDefault * smallUnitPrice) - discountTotal).clamp(0, 999999999);

      final currentStock = _parseInt(inventorySelected?.currentStock.toString().replaceAll(RegExp(r'\.0$'), ''));
      // stok kosong
      if (currentStock <= 0) {
        AppSnackBar.show(context, message: "Stok kosong!", color: Colors.red);
        return;
      }
      // cek stok hanya berlaku selain return order, pricemode == localkedFromMaster artinya bukan return order
      if (orderType == OrderType.quickSales) {
        if (isStockLocked == true) {
          if (_parseInt(qtyDefaultController.text) > currentStock) {
            AppSnackBar.show(context, message: "Stok tidak mencukupi!", color: Colors.red);
            return;
          }
        }
      } else if (orderType == OrderType.salesOrder) {
        if (isStockLocked == true && isUnlockSO == false) {
          if (_parseInt(qtyDefaultController.text) > currentStock) {
            AppSnackBar.show(context, message: "Stok tidak mencukupi!", color: Colors.red);
            return;
          }
        }
      }

      if (discount > _parseInt(priceUIController.text)) {
        AppSnackBar.show(context, message: "Diskon tidak boleh lebih besar dari harga!", color: Colors.red);
        return;
      }

      // duplikasi
      if (oldInventoryIds.contains(inventorySelected?.inventoryId)) {
        AppSnackBar.show(context, message: "${l?.messages_duplicateInventory} ${inventorySelected?.inventoryName}", color: Colors.red);
        return;
      }

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
      log('GeneralOrderDraftItem result: ${result.toJson()}');
      Navigator.of(context).pop(result);
      return;
    } else {
      AppSnackBar.show(context, message: "Form belum lengkap!", color: Colors.red);
    }
  }

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
