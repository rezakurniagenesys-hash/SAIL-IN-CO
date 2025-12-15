import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/models/general/general_uoms/general_uoms_response.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/generals/general_providers.dart';
import 'package:sail_in_co/providers/order/general_order_provider.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_search.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class AddEditInventory extends StatelessWidget {
  const AddEditInventory({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Consumer2<GeneralOrderProvider, GeneralProviders>(
      builder: (context, generalOrderProvider, generalProvider, _) {
        return Form(
          key: generalOrderProvider.formKey,
          child: Column(
            spacing: 12,
            children: [
              AppDropdownSearch<InventoryItem>(
                label: l?.order_inventory,
                hintText: l?.order_inventory,
                value: generalOrderProvider.inventorySelected,
                items: generalProvider.inventoryData,
                validator: (value) {
                  if (value == null) {
                    return 'Please select an inventory item';
                  }
                  return null;
                },
                onChanged: (value) {
                  generalOrderProvider.setInventorySelected(value);
                },
                display: (InventoryItem item) => item.inventoryName,
              ),
              AppInputField(
                height: 44,
                readOnly: true,
                label: l?.order_currentStock,
                hintText: l?.order_currentStock,
                borderSideColor: AppColors.neutral400,
                type: AppInputType.number,
                controller: generalOrderProvider.currentStockController,
                onChanged: (value) {
                  // handle search logic here
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: AppInputField(
                      height: 44,
                      label: l?.order_qty,
                      hintText: l?.order_qty,
                      borderSideColor: AppColors.neutral400,
                      type: AppInputType.number,
                      controller: generalOrderProvider.qtyController,
                      onChanged: (value) {
                        generalOrderProvider.setQty(value);
                      },
                      validator: (_) {
                        final value = generalOrderProvider.qtyController.text;
                        if (value.isEmpty) {
                          return 'Please enter quantity';
                        }
                        final qty = int.tryParse(value);
                        if (qty == null || qty <= 0) {
                          return 'Please enter a valid quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppDropdownSearch<UOMItem>(
                      label: l?.order_uom,
                      hintText: l?.order_uom,
                      value: generalOrderProvider.uomSelected,
                      items: generalOrderProvider.inventorySelected?.uoms ?? [],
                      onChanged: (value) {
                        generalOrderProvider.setUomSelected(value);
                      },
                      display: (UOMItem item) => item.uomName,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a UoM';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AppInputField(
                      height: 44,
                      readOnly: true,
                      label: l?.order_qtyDefault,
                      hintText: l?.order_qtyDefault,
                      borderSideColor: AppColors.neutral400,
                      type: AppInputType.number,
                      controller: generalOrderProvider.qtyDefaultController,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppInputField(
                      height: 44,
                      readOnly: true,
                      label: l?.order_uomDefault,
                      hintText: l?.order_uomDefault,
                      borderSideColor: AppColors.neutral400,
                      controller: generalOrderProvider.uomDefaultController,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              AppInputField(
                label: l?.order_price,
                hintText: l?.order_price,
                type: AppInputType.number,
                borderSideColor: AppColors.neutral400,
                controller: generalOrderProvider.priceUIController,
                readOnly: generalOrderProvider.priceMode != OrderPriceMode.editable,
                onChanged: (value) {
                  generalOrderProvider.setPrice(value);
                },
              ),
              AppInputField(
                label: l?.order_discount,
                hintText: l?.order_discount,
                type: AppInputType.number,
                borderSideColor: AppColors.neutral400,
                controller: generalOrderProvider.discountController,
                onChanged: (value) {
                  generalOrderProvider.setDiscount(value);
                },
              ),
              AppInputField(
                label: l?.order_notes,
                hintText: l?.order_notes,
                type: AppInputType.textarea,
                borderSideColor: AppColors.neutral400,
                controller: generalOrderProvider.notesController,
                onChanged: (value) {
                  generalOrderProvider.setNotes(value);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l?.order_total ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(CurrencyFormat.toRupiah(generalOrderProvider.totalPrice.toString()), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
