# Soal Shift Sisop Modul 1 2021


Kelompok E-06
- Fajar Satria (05111940000083)
- Axel Briano Suherik (05111940000137)
- Ikhlasul Amal Rivel (05111940000145)
# Soal Shift Modul 1 (Kelompok E6)

**Soal Shift Modul 1 Sistem Operasi 2021:**
* [Soal 1](https://github.com/axelbrians/soal-shift-sisop-modul-1-E06-2021#Soal-1)
* [Soal 2](https://github.com/axelbrians/soal-shift-sisop-modul-1-E06-2021#Soal-2)
* [Soal 3](https://github.com/axelbrians/soal-shift-sisop-modul-1-E06-2021#Soal-3)

## Soal 2
Steven dan Manis mendirikan sebuah _startup_ bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan _“Laporan-TokoShiSop.tsv”_.

**a**. Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui **Row ID** dan **_profit percentage terbesar_** (jika hasil _profit percentage_ terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari _profit percentage_, yaitu:
**_Profit Percentage = (Profit Cost Price) 100_**
_Cost Price_ didapatkan dari pengurangan _Sales_ dengan _Profit_. (**Quantity diabaikan**).

**b**. Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar **nama _customer_ pada transaksi tahun 2017 di Albuquerque**.

**c**. TokoShiSop berfokus tiga _segment customer_, antara lain: _Home Office_, _Customer_, dan _Corporate_. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan **_segment customer_** dan **jumlah transaksinya yang paling sedikit**.

**d**. TokoShiSop membagi wilayah bagian (_region_) penjualan menjadi empat bagian, antara lain: _Central, East, South,_ dan _West_. Manis ingin mencari **wilayah bagian (_region_) yang memiliki total keuntungan (_profit_) paling sedikit** dan **total keuntungan wilayah tersebut**.

Agar mudah dibaca oleh Manis, Clemong, dan Steven, **(e)** kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:
```text
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```

**_Jawaban:_**

* soal2_generate_laporan_ihir_shisop.sh
    ```bash
    #!/bin/bash
    awk -F'\t' 'NR>1{id=($21/(0.00000000000000000000001+$18-$21)*100)>=maks?$1:id;maks=($21/(0.00000000000000000000001+$18-$21)*100)>maks?($21/(0.00000000000000000000001+$18-$21)*100):maks}END{printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%%.\n",id,maks)}' Laporan-TokoShiSop.tsv
    printf "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
    awk -F'\t' '(/Albuquerque/ && $3~/??-??-17/ && a[$7]==0) {print $7;a[$7]++}' Laporan-TokoShiSop.tsv
    printf "\n"
    awk -F'\t' 'NR>1{a[$8]++} END{c=99999999;for(b in a){d=a[b]<c?b:d;c=a[b]<c?a[b]:c;}printf("Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n",d,c);}' Laporan-TokoShiSop.tsv
    printf "\n"
    awk -F'\t' 'NR>1{a[$13]=$21<a[$13]?$21:a[$13]} END{for(b in a){d=a[b]<c?b:d;c=a[b]<c?a[b]:c;}printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.4f\n",d,c)}' Laporan-TokoShiSop.tsv

    ```
* hasil.txt
    ```text
    Transaksi terakhir dengan profit percentage terbesar yaitu 9952 dengan persentase 100.00%.
    
    Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
    Michelle Lonsdale
    Benjamin Farhat
    David Wiener
    Susan Vittorini
    
    Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan 1783 transaksi.
    
    Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah East dengan total keuntungan -6599.9780

    ```

    Pada soal **(a)** perlu dilakukan pemecahan dengan **\t** sebagai delimiter, lalu dilanjutkan dengan menghitung percentage profit dengan rumus **$21/(0.00000000000000000000001+$18-$21)*100***. Dengan mengiterasi tiap tiap baris dengan rumus tersebut bisa didapatkan id terbesar dengan persentase terbesar pula. *0.00000000000000000000001* digunakan untuk menghindari **divided by zero**.

    Pada soal **(b)** perlu cukup dilakukan pencarian dengan kriteria yang sudah ditentukan, lalu dilanjutkan dengan memfilter nama yang sama dari output.

    Pada soal **(c)** perlu dilakukan pemecahan dengan **\t** sebagai delimiter, lalu dilanjutkan dengan menghitung tiap unique id **kolom 8** dan menyimpan pada variabel **c** dan **d**

    Pada soal **(d)** perlu dilakukan pemecahan dengan **\t** sebagai delimiter, lalu dilanjutkan dengan mencari profit terkecil pada **kolom 21**, lalu menyimpan nilai **profit terendah** pada variabel **c** dan juga nama **region terendah** pada variabel **d**.

Keterangan :

- `-F "\t"` sintaks tersebut untuk mendefinisikan field separator secara manual dari sebuah \t atau blank spaces.
- `'"$var"'` digunakan untuk memasukkan variable bash kedalam sintaks awk.
- `${array[@]}` digunakan untuk mengeluarkan semua isi array.
- Script soal2.sh dijalankan dengan menerima argument berupa file csv yang akan direkap.
