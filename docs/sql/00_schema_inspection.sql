-- Melihat nama kolom dan tipe data semua tabel di dataset
SELECT
  table_name,
  column_name,
  data_type,
  is_nullable
FROM `bigquery-public-data.thelook_ecommerce.INFORMATION_SCHEMA.COLUMNS`
ORDER BY table_name, ordinal_position;

-- Jumlah baris dan ukuran tiap tabel, tanpa scan data
SELECT
  table_id,
  row_count,
  ROUND(size_bytes / POW(1024, 2), 1) AS size_mb
FROM `bigquery-public-data.thelook_ecommerce.__TABLES__`
ORDER BY row_count DESC;

