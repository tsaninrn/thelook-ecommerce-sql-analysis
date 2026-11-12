-- =====================================================================
-- 01_data_exploration.sql
-- Project  : TheLook E-commerce SQL Analysis
-- Dataset  : bigquery-public-data.thelook_ecommerce
-- Dijalankan: 12 November 2026
-- Tujuan   : Memahami struktur data sebelum analisis (validasi primary
--            key, distribusi status, dan jumlah pengguna yang membeli)
-- =====================================================================


-- ---------------------------------------------------------------------
-- Query 1: Apakah orders.order_id layak menjadi primary key?
-- Tujuan   : Memastikan setiap baris di tabel orders mewakili satu order
--            yang unik dan tidak ada nilai kosong pada order_id.
-- Hasil (12 Nov 2026): total_rows = 125.183
--                      distinct_order_ids = 125.183
--                      null_order_ids = 0
-- Interpretasi: Jumlah baris sama dengan jumlah nilai unik, dan tidak ada
--               NULL, sehingga order_id valid sebagai primary key.
-- ---------------------------------------------------------------------
SELECT
  COUNT(*)                    AS total_rows,
  COUNT(DISTINCT order_id)    AS distinct_order_ids,
  COUNTIF(order_id IS NULL)   AS null_order_ids
FROM `bigquery-public-data.thelook_ecommerce.orders`;


-- ---------------------------------------------------------------------
-- Query 2: Distribusi status di tabel orders dan order_items
-- Tujuan   : Mengetahui nilai status apa saja yang ada dan seberapa
--            banyak masing-masing, sebelum menentukan definisi revenue.
-- Hasil (12 Nov 2026):
--   Status      orders    order_items
--   Shipped     37.750    54.637
--   Complete    31.185    45.063
--   Processing  24.907    36.080
--   Cancelled   18.830    27.294
--   Returned    12.511    18.165
-- Interpretasi: Hanya ada 5 status dan tidak ada status NULL. Hanya
--               sekitar 24,9% order berstatus Complete, sehingga revenue
--               tidak boleh dihitung dari semua baris tanpa filter status.
-- Catatan   : UNION ALL menumpuk dua hasil query menjadi satu tabel.
-- ---------------------------------------------------------------------
SELECT 'orders' AS source_table, status, COUNT(*) AS row_count
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status
UNION ALL
SELECT 'order_items', status, COUNT(*)
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY status
ORDER BY source_table, row_count DESC;


-- ---------------------------------------------------------------------
-- Query 3: Berapa pengguna yang benar-benar pernah melakukan order?
-- Tujuan   : Membuktikan apakah semua pengguna pernah membeli.
--            Membandingkan jumlah baris orders dengan jumlah pengguna
--            tidak cukup, karena satu pengguna bisa memesan berkali-kali.
-- Hasil (12 Nov 2026): total_users = 100.000
--                      users_with_orders = 80.120
-- Interpretasi: Sekitar 19.880 pengguna (19,9%) belum pernah memesan.
--               Kelompok ini menjadi bahan analisis pelanggan nanti.
-- Catatan   : COUNT(DISTINCT user_id) menghitung pengguna unik, bukan
--             jumlah order.
-- ---------------------------------------------------------------------
SELECT
  (SELECT COUNT(*)
   FROM `bigquery-public-data.thelook_ecommerce.users`) AS total_users,
  (SELECT COUNT(DISTINCT user_id)
   FROM `bigquery-public-data.thelook_ecommerce.orders`) AS users_with_orders;


-- ---------------------------------------------------------------------
-- Query 4: Apakah status order dan status item konsisten?
-- Tujuan   : Memeriksa apakah item dalam satu order selalu memiliki
--            status yang sama dengan order induknya.
-- Hasil (12 Nov 2026): Hanya muncul 5 kombinasi, semuanya sama
--   Shipped/Shipped 54.637 | Complete/Complete 45.063
--   Processing/Processing 36.080 | Cancelled/Cancelled 27.294
--   Returned/Returned 18.165
-- Interpretasi: Status konsisten di semua baris. Total item = 181.239,
--               sama dengan jumlah baris order_items, jadi tidak ada
--               item tanpa order induk (tidak ada orphan item).
-- Catatan   : Pada data bisnis nyata, satu order bisa berisi item dengan
--             status berbeda. Konsistensi ini ciri data sintetis dan
--             dicatat sebagai keterbatasan proyek.
-- ---------------------------------------------------------------------
SELECT
  o.status  AS order_status,
  oi.status AS item_status,
  COUNT(*)  AS item_count
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
INNER JOIN `bigquery-public-data.thelook_ecommerce.orders` AS o
  ON oi.order_id = o.order_id
GROUP BY order_status, item_status
ORDER BY item_count DESC;


-- ---------------------------------------------------------------------
-- Query 5: Apakah order_items.id layak menjadi primary key?
-- Tujuan   : Memastikan setiap baris order_items unik dan id tidak kosong.
-- Hasil (12 Nov 2026): total_rows = 181.239
--                      distinct_ids = 181.239
--                      null_ids = 0
-- Interpretasi: Jumlah baris sama dengan jumlah nilai unik dan tidak ada
--               NULL, sehingga id valid sebagai primary key. Grain tabel
--               ini adalah satu baris per item dalam order.
-- ---------------------------------------------------------------------
SELECT
  COUNT(*)            AS total_rows,
  COUNT(DISTINCT id)  AS distinct_ids,
  COUNTIF(id IS NULL) AS null_ids
FROM `bigquery-public-data.thelook_ecommerce.order_items`;

-- ---------------------------------------------------------------------
-- Query 6: Rentang tanggal data
-- Tujuan   : Mengetahui periode data agar analisis tren (bulanan/tahunan)
--            memiliki dasar yang jelas.
-- Hasil (12 Nov 2026): order pertama = 2019-01-12
--                      order terakhir = 2026-11-12
--                      rentang = 2.861 hari
-- Interpretasi: Data mencakup sekitar 7,8 tahun. Bulan pertama (Jan 2019)
--               dan bulan terakhir (Nov 2026) tidak penuh, sehingga harus
--               dikecualikan atau diberi tanda pada analisis tren bulanan.
-- ---------------------------------------------------------------------
SELECT
  MIN(created_at) AS first_order_date,
  MAX(created_at) AS last_order_date,
  DATE_DIFF(DATE(MAX(created_at)), DATE(MIN(created_at)), DAY) AS span_days
FROM `bigquery-public-data.thelook_ecommerce.orders`;


-- ---------------------------------------------------------------------
-- Query 7: Jumlah produk per kategori
-- Tujuan   : Memahami struktur katalog produk.
-- Hasil (12 Nov 2026): 26 kategori. Terbanyak: Intimates (2.363),
--                      Jeans (1.999), Tops & Tees (1.868).
--                      Tersedikit: Clothing Sets (37), Suits (188).
-- Interpretasi: Ini jumlah produk, bukan penjualan. Ada kategori yang
--               mirip: Socks vs Socks & Hosiery, Pants vs Pants & Capris,
--               Suits vs Suits & Sport Coats. Belum digabung dan dicatat
--               sebagai keterbatasan di data quality report.
-- ---------------------------------------------------------------------
SELECT
  category,
  COUNT(*) AS product_count
FROM `bigquery-public-data.thelook_ecommerce.products`
GROUP BY category
ORDER BY product_count DESC;


-- ---------------------------------------------------------------------
-- Query 8: Sebaran pelanggan per negara dan gender
-- Tujuan   : Mengetahui profil geografis dan gender pelanggan.
-- Hasil (12 Nov 2026): China 33.926 user, United States 22.552,
--                      Brasil 14.634 (ketiganya sekitar 71% dari 100.000).
--                      Gender hanya F dan M, rasio hampir seimbang.
-- Interpretasi: Pelanggan terkonsentrasi di tiga negara. Ditemukan nama
--               negara tidak konsisten: 'España' (4 user) dan
--               'Deutschland' (2 user) seharusnya Spain dan Germany.
--               Colombia (9) dan Austria (1) terlalu kecil untuk
--               dijadikan dasar kesimpulan.
-- ---------------------------------------------------------------------
SELECT
  country,
  gender,
  COUNT(*) AS user_count
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY country, gender
ORDER BY user_count DESC;
