--soal 1
SELECT
	nama,
	email,
	bulan_lahir,
	tanggal_registrasi
FROM rakamin_customer
WHERE
	(email LIKE '%gmail%' OR email LIKE '%roketmail%')
	AND tanggal_registrasi BETWEEN '2012-01-01' AND '2012-03-01'
	AND bulan_lahir IN ('Januari', 'Februari', 'Maret')
	
--soal 2
SELECT
	id_order,
	id_pelanggan,
	harga,
	harga + (harga * ppn) harga_setelah_ppn,
	CASE WHEN (harga + (harga * ppn)) < 20000 THEN 'LOW'
		 WHEN (harga + (harga * ppn)) > 20000 AND (harga + (harga * ppn)) < 50000 THEN 'MEDIUM'
		 WHEN (harga + (harga * ppn)) > 50000 THEN 'HIGH'
	END spending_bucket
FROM rakamin_order
ORDER BY 4 DESC

--soal 3
SELECT
	id_merchant,
	COUNT(1) jumlah_order,
	SUM(harga) jumlah_pendapatan
FROM rakamin_order
GROUP BY 1
ORDER BY 3 DESC

--soal 4
SELECT
	metode_bayar,
	COUNT(1) frekuensi_penggunaan
FROM rakamin_order
GROUP BY 1
HAVING COUNT(1) > 10
ORDER BY 2 DESC

--soal 5
SELECT
	MIN(jumlah_pelanggan) kota_pelanggan_terkecil,
	MAX(jumlah_pelanggan) kota_pelanggan_terbesar
FROM (
	SELECT 
		kota, 
		COUNT(1) jumlah_pelanggan
	FROM rakamin_customer_address
	GROUP BY 1
) jumlah_pelanggan_per_kota

--soal 6
SELECT
	rm.nama_merchant,
	ro.metode_bayar,
	COUNT(2) frekuensi_penggunaan
FROM rakamin_order ro
LEFT JOIN rakamin_merchant rm
ON ro.id_merchant = rm.id_merchant
GROUP BY 1, 2
ORDER BY 1, 2

--soal 7
WITH qty AS (
	SELECT 
		id_pelanggan,
		SUM(kuantitas) total_kuantitas
	FROM rakamin_order
	GROUP BY 1
	HAVING SUM(kuantitas) > 5
)

SELECT
	qty.id_pelanggan,
	qty.total_kuantitas,
	rc.nama,
	rc.email
FROM qty
LEFT JOIN rakamin_customer rc
ON qty.id_pelanggan = rc.id_pelanggan
