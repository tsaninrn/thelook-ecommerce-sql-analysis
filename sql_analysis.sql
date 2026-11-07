SELECT name, category, department, brand, retail_price 
FROM bigquery-public-data.thelook_ecommerce.products
ORDER BY name ASC
LIMIT 20;

SELECT name, category, brand, retail_price
FROM bigquery-public-data.thelook_ecommerce.products
WHERE retail_price > 100
ORDER BY retail_price DESC;

-- Evaluasi Kategori Produk 
-- Mengetahui kategori dengan jumlah produk terbanyak 
SELECT category, COUNT(id) jumlah_produk
FROM bigquery-public-data.thelook_ecommerce.products
GROUP BY category
ORDER BY jumlah_produk DESC;

-- INSIGHT :
-- Kategori produk yang paling tinggi adalah "Intimates" dengan  2.363 produk
-- Sedangkan kategori yang memiliki produk paling sedikit, sebanyak 37 produk adalah clothing sets


SELECT o.order_id, o.status, o.created_at, u.first_name, u.last_name
FROM bigquery-public-data.thelook_ecommerce.orders o
INNER JOIN bigquery-public-data.thelook_ecommerce.users u
    ON o.user_id=u.id;

-- Analisi Penjualan Per Kategori
-- Hitung total penjualan per kategori, diurutkan dari nilai terbesar

SELECT p.category, ROUND(SUM(oi.sale_price),2) as Penjualan
FROM bigquery-public-data.thelook_ecommerce.products p
INNER JOIN bigquery-public-data.thelook_ecommerce.order_items oi
    ON p.id=oi.product_id
WHERE oi.status = "Complete"
GROUP BY p.category
ORDER BY Penjualan DESC;

-- INSIGHT 
-- Kategori produk penyumbang sales terbesar adalah "Outerwear and Coats" dengan pendapatan sekitar 332057.06
-- Sedangkan category dengan pendapatan terendah adalah Clothing Sets dengan pendapatan 4126.75


