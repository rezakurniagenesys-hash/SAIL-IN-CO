// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get language => 'Bahasa';

  @override
  String get languageSelect => 'Bahasa Indonesia';

  @override
  String get appTitle => 'Sail In Co';

  @override
  String dashboardGreeting(Object name) {
    return 'Halo, $name';
  }

  @override
  String get dashboard_home => 'Beranda';

  @override
  String get dashboard_customers => 'Pelanggan';

  @override
  String get dashboard_transportation => 'Transportasi';

  @override
  String get dashboard_history => 'Riwayat';

  @override
  String get home_lastUpdate => 'Pembaruan Terakhir';

  @override
  String get home_status => 'Status';

  @override
  String get home_online => 'Online';

  @override
  String get home_visited => 'Dikunjungi';

  @override
  String get home_notVisited => 'Belum Dikunjungi';

  @override
  String get home_tasks => 'Tugas';

  @override
  String get home_stock => 'Stok';

  @override
  String get home_achievements => 'Pencapaian';

  @override
  String get home_registeredCustomers => 'Customer Terdaftar';

  @override
  String get home_newCustomers => 'Customer Baru';

  @override
  String get home_soldStock => 'Stok Terjual';

  @override
  String get home_noInternet => 'Tidak ada koneksi internet';

  @override
  String get home_seeDetail => 'Lihat Detail';

  @override
  String get home_settlement => 'Settlement';

  @override
  String get homeDialog_syncTitle => 'Sinkronisasi Data';

  @override
  String get homeDialog_syncSubtitle => 'Mulai sinkronisasi untuk memastikan Anda menggunakan data terbaru saat offline';

  @override
  String get homeDialog_inputKmStart => 'Input Kilometer Awal';

  @override
  String get homeDialog_km => 'Km';

  @override
  String get homeDialog_inputDescription => 'Masukkan keterangan';

  @override
  String get homeDialog_warningInternet => 'Pastikan Internet Aktif untuk sinkronisasi data!';

  @override
  String get homeDialog_syncButton => 'Sinkronisasi Data Awal';

  @override
  String get homeDialog_syncNote => 'Tetap online hingga sinkronisasi selesai. Anda dapat terus menggunakan aplikasi ini selama sinkronisasi berlangsung.';

  @override
  String get customer_title => 'Manajemen Pelanggan';

  @override
  String get customer_list => 'Daftar Pelanggan';

  @override
  String get customer_search => 'Cari';

  @override
  String get customer_visit => 'Dikunjungi';

  @override
  String get customer_notVisit => 'Belum Dikunjungi';

  @override
  String get customerDetail_title => 'Detail Customer';

  @override
  String get customerDetail_customerName => 'Nama Customer';

  @override
  String get customerDetail_customerCode => 'Kode Pelanggan';

  @override
  String get customerDetail_warehouseCode => 'Kode Gudang';

  @override
  String get customerDetail_paymentType => 'Jenis Pembayaran';

  @override
  String get customerDetail_customerType => 'Jenis Customer';

  @override
  String get customerDetail_salesCode => 'Kode Sales';

  @override
  String get customerDetail_area => 'Area';

  @override
  String get customerDetail_address => 'Alamat';

  @override
  String get customerDetail_city => 'Kota';

  @override
  String get customerDetail_ktp => 'KTP';

  @override
  String get customerDetail_phoneNumber => 'Nomor HP';

  @override
  String get customerDetail_creditLimit => 'Limit Kredit';

  @override
  String get customerDetail_statusVisited => 'Dikunjungi';

  @override
  String get customerDetail_statusNotVisited => 'Belum Dikunjungi';

  @override
  String get customerDetail_editData => 'Ubah Data';

  @override
  String get customerDetail_editCustomerData => 'Ubah Data Customer';

  @override
  String get customerDetail_uploadPhoto => 'Upload Foto';

  @override
  String get customerDetail_order => 'Order';

  @override
  String get customerDetail_adjustment => 'Penyesuaian';

  @override
  String get customerDetail_return => 'Pengembalian';

  @override
  String get customerDetail_activityHistory => 'Riwayat Aktivitas';

  @override
  String get customerDetail_outstandingOrder => 'Pesanan Belum Selesai';

  @override
  String get customerDetail_stock => 'Stock';

  @override
  String get customerDetail_filterAll => 'Semua';

  @override
  String get customerDetail_filterSales => 'Penjualan';

  @override
  String get customerDetail_filterOrder => 'Pesanan';

  @override
  String get customerDetail_filterAdjustment => 'Penyesuaian';

  @override
  String get customerDetail_filterReturn => 'Pengembalian';

  @override
  String get customerDetail_labelCustomerName => 'Nama Pelanggan';

  @override
  String get customerDetail_labelAddress => 'Alamat';

  @override
  String get customerDetail_labelArea => 'Area';

  @override
  String get customerDetail_labelPhoneNumber => 'Nomor HP';

  @override
  String get customerDetail_labelCustomerType => 'Tipe Customer';

  @override
  String get customerDetail_labelPaymentType => 'Jenis Pembayaran';

  @override
  String get customerDetail_customerTypeRetail => 'Retail';

  @override
  String get customerDetail_customerTypeWholesale => 'Grosir';

  @override
  String get customerDetail_paymentCash => 'Cash';

  @override
  String get customerDetail_paymentCredit => 'Credit';

  @override
  String get customerDetail_saveChanges => 'Simpan Perubahan';

  @override
  String get customerDetail_returnPayment => 'Pengembalian Pembayaran';

  @override
  String get order_quickSales => 'Penjualan Cepat';

  @override
  String get order_salesOrder => 'Sales Order';

  @override
  String get order_visit => 'Dikunjungi';

  @override
  String get order_notVisit => 'Belum Dikunjungi';

  @override
  String get order_customerId => 'ID Pelanggan';

  @override
  String get order_paymentType => 'Jenis Pembayaran';

  @override
  String get order_salesId => 'ID Sales';

  @override
  String get order_address => 'Alamat';

  @override
  String get order_ktp => 'KTP';

  @override
  String get order_warehouseId => 'ID Gudang';

  @override
  String get order_city => 'Kota';

  @override
  String get order_area => 'Area';

  @override
  String get order_phoneNumber => 'Nomor HP';

  @override
  String get order_inventoryDetail => 'Detail Inventory';

  @override
  String get order_addProduct => 'Tambah Produk';

  @override
  String get order_edit => 'Edit';

  @override
  String get order_delete => 'Hapus';

  @override
  String get order_discount => 'Diskon';

  @override
  String get order_subtotal => 'Subtotal';

  @override
  String get order_grandTotalPayment => 'Total Pembayaran';

  @override
  String get order_inventory => 'Inventory';

  @override
  String get order_qty => 'Qty';

  @override
  String get order_price => 'Harga';

  @override
  String get order_uom => 'Satuan';

  @override
  String get order_notes => 'Catatan';

  @override
  String get order_total => 'Total';

  @override
  String get order_insert => 'Tambah';

  @override
  String get order_payment => 'Pembayaran';

  @override
  String get order_searchInventory => 'Cari Inventory';

  @override
  String get order_selectInventory => 'Pilih Inventory';

  @override
  String get transportation_management => 'Manajemen Transportasi';

  @override
  String get transportation_history => 'Riwayat';

  @override
  String get transportation_add => 'Tambah';

  @override
  String get transportation_addTransportation => 'Tambah Manajemen Transportasi';

  @override
  String get transportation_editTransportation => 'Ubah Manajemen Transportasi';

  @override
  String get transportation_viewTransportation => 'Lihat Manajemen Transportasi';

  @override
  String get transportation_type => 'Tipe';

  @override
  String get transportation_vehicleNumber => 'Nomor Kendaraan';

  @override
  String get transportation_date => 'Tanggal';

  @override
  String get transportation_price => 'Harga';

  @override
  String get transportation_notes => 'Catatan';

  @override
  String get transportation_total => 'Total';

  @override
  String get transportation_insert => 'Tambah';

  @override
  String get transportation_update => 'Perbarui';

  @override
  String get transportation_photo => 'Foto';

  @override
  String get transaction_transactionHistory => 'Riwayat Transaksi';

  @override
  String get transaction_customerFilter => 'Filter Pelanggan';

  @override
  String get transaction_search => 'Cari';

  @override
  String get transaction_all => 'Semua';

  @override
  String get transaction_sales => 'Penjualan';

  @override
  String get transaction_order => 'Order';

  @override
  String get transaction_adjustment => 'Penyesuaian';

  @override
  String get transaction_return => 'Retur';

  @override
  String get transaction_visited => 'Dikunjungi';

  @override
  String get transaction_notVisited => 'Belum Dikunjungi';

  @override
  String get transaction_salesTransaction => 'Transaksi Penjualan';

  @override
  String get transaction_date => 'Tanggal';

  @override
  String get transaction_warehouse => 'Gudang';

  @override
  String get transaction_address => 'Alamat';

  @override
  String get transaction_idNumber => 'Nomor ID';

  @override
  String get transaction_paymentType => 'Jenis Pembayaran';

  @override
  String get transaction_salesId => 'ID Sales';

  @override
  String get transaction_customerName => 'Nama Pelanggan';

  @override
  String get transaction_area => 'Area';

  @override
  String get transaction_phoneNumber => 'Nomor HP';

  @override
  String get transaction_remarks => 'Keterangan';

  @override
  String get transaction_inventoryDetail => 'Detail Inventory';

  @override
  String get transaction_add => 'Tambah';

  @override
  String get transaction_edit => 'Ubah';

  @override
  String get transaction_delete => 'Hapus';

  @override
  String get transaction_addProduct => 'Tambah Produk';

  @override
  String get transaction_inventory => 'Inventory';

  @override
  String get transaction_qty => 'Qty';

  @override
  String get transaction_price => 'Harga';

  @override
  String get transaction_uom => 'Satuan';

  @override
  String get transaction_discount => 'Diskon';

  @override
  String get transaction_notes => 'Catatan';

  @override
  String get transaction_total => 'Total';

  @override
  String get transaction_insert => 'Tambah';

  @override
  String get transaction_payment => 'Pembayaran';

  @override
  String get setting_title => 'Pengaturan';

  @override
  String get setting_account => 'Akun';

  @override
  String get setting_language => 'Bahasa';

  @override
  String get setting_helpSupport => 'Bantuan & Dukungan';

  @override
  String get setting_about => 'Tentang Aplikasi';

  @override
  String get setting_profilePhoto => 'Foto Profil';

  @override
  String get setting_displayName => 'Nama Tampilan';

  @override
  String get setting_email => 'Email';

  @override
  String get setting_address => 'Alamat';

  @override
  String get setting_phoneNumber => 'Nomor HP';

  @override
  String get setting_newPassword => 'Kata Sandi Baru';

  @override
  String get setting_saveChanges => 'Simpan Perubahan';

  @override
  String get payment_quickSalesPayment => 'Pembayaran Penjualan Cepat';

  @override
  String get payment_totalAmount => 'Jumlah Total';

  @override
  String get payment_remainingPayment => 'Sisa Pembayaran';

  @override
  String get payment_returnId => 'ID Retur';

  @override
  String get payment_returnValue => 'Nilai Retur';

  @override
  String get payment_paymentMethod => 'Metode Pembayaran';

  @override
  String get payment_pendingPayment => 'Pembayaran Tertunda';

  @override
  String get payment_confirmPayment => 'Konfirmasi Pembayaran';

  @override
  String get payment_salesOrderPayment => 'Pembayaran Sales Order';

  @override
  String get payment_returnPayment => 'Pembayaran Retur';
}
