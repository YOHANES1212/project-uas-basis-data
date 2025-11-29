## 1. Tabel Stall (Gerai Makanan)

Menyimpan daftar gerai/tenant yang berjualan di food hall.

Kolom	Tipe	Deskripsi
stall_id	INT (PK)	ID unik gerai
name	VARCHAR	Nama gerai
owner	VARCHAR	Nama pemilik
2. Tabel MenuItem (Menu Makanan / Minuman)

Menyimpan menu yang dijual tiap gerai.

Kolom	Tipe	Deskripsi
item_id	INT (PK)	ID menu
stall_id	INT (FK → Stall)	Gerai pemilik menu
name	VARCHAR	Nama menu
description	TEXT	Deskripsi
price	DECIMAL	Harga
is_available	BOOLEAN	Ketersediaan

Relasi:
Satu Stall memiliki banyak MenuItem (1-to-many)

3. Tabel Category (Kategori Menu)

Menyimpan kategori seperti: Makanan, Minuman, Dessert, dsb.

Kolom	Tipe	Deskripsi
category_id	INT (PK)	ID kategori
name	VARCHAR	Nama kategori
4. Tabel MenuItemCategory (Relasi Menu ↔ Kategori)

Tabel junction untuk many-to-many.

Kolom	Tipe	Deskripsi
item_id	FK → MenuItem	
category_id	FK → Category	

Relasi:
Satu menu dapat punya banyak kategori
Satu kategori dapat berisi banyak menu

5. Tabel Customer (Pembeli)
Kolom	Tipe	Deskripsi
customer_id	INT (PK)	ID pembeli
name	VARCHAR	Nama pembeli
6. Tabel Orders (Pesanan)
Kolom	Tipe	Deskripsi
order_id	INT (PK)	ID pesanan
customer_id	FK → Customer	Pembeli pemilik pesanan
order_time	TIMESTAMP	Waktu pesanan dibuat
status	VARCHAR	Status (PENDING, PAID, CANCELLED)
total_amount	DECIMAL	Total harga

Relasi:
Satu customer bisa punya banyak order

7. Tabel OrderItem (Detail Item Pesanan)
Kolom	Tipe	Deskripsi
order_item_id	INT (PK)	ID detail item
order_id	FK → Orders	Pesanan
item_id	FK → MenuItem	Menu
quantity	INT	Jumlah
unit_price	DECIMAL	Harga satuan
subtotal	DECIMAL	Total per item

Relasi:
Satu order punya banyak order item

8. Tabel Payment (Pembayaran)
Kolom	Tipe	Deskripsi
payment_id	INT (PK)	ID pembayaran
order_id	FK (unique)	Pesanan yang dibayar
paid_amount	DECIMAL	Jumlah bayar
method	VARCHAR	Metode (Cash, QRIS, Debit)
payment_time	TIMESTAMP	Waktu bayar
status	VARCHAR	Completed / Failed
Ringkasan Relasi

Stall → MenuItem = 1-to-many

MenuItem ↔ Category = many-to-many

Customer → Orders = 1-to-many

Orders → OrderItem = 1-to-many

Orders → Payment = 1-to-1

Manfaat Skema

Cocok untuk aplikasi kasir food hall.

Mendukung multi-tenant (banyak stall).

Mendukung banyak kategori menu.

Payment terpisah agar mudah integrasi ke sistem pembayaran.