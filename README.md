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

## Soal 3
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :

## a. 
Membuat script untuk **mengunduh** 23 gambar dari "https://loremflickr.com/320/240/kitten" serta **menyimpan** log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus **menghapus** gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian **menyimpan** gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan **tanpa ada nomor yang hilang** (contoh : Koleksi_01, Koleksi_02, ...)

### Penjelasan Soal
* Diminta untuk mengunduh 23 kali dari url https://loremflickr.com/320/240/kitten
* Jika ada foto yang sama maka dihapus. 
* Log dari mengunduh disimpan pada `Foto.log`
* Format penamaan foto yang di unduh `Koleksi_XX` XX mulai dari 00 hingga 23.

### Solution
Menjalankan `wget -nv -O Koleksi_XX https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log` sebanyak 23 kali. XX pada `Koleksi_XX` diganti dengan urutan angka yang sesuai.
Cara mencari tahu foto yang kembar atau tidak adalah dengan melakukan awk setiap kali menjalankan `wget`, melakukan split url hasil download pada `Foto.log` `2021-04-01 19:32:25 URL:https://loremflickr.com/cache/resized/65535_50739141646_a2e146d245_320_240_nofilter.jpg [18583/18583] -> "Kitten_01.jpeg" [1]`, diambil part pada `a2e146d245` untuk tiap baris log. Lalu bandingkan log paling akhir dengan semua log sebelumnya. Jika ada yang sama, maka pada loop tersebut hapus foto yang baru di download.


## b. 
Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut **sehari sekali pada jam 8 malam** untuk tanggal-tanggal tertentu setiap bulan, yaitu dari **tanggal 1 tujuh hari sekali** (1,8,...), serta dari **tanggal 2 empat hari sekali**(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta **log-nya**, **dipindahkan ke folder** dengan nama **tanggal unduhnya** dengan **format** "DD-MM-YYYY" (contoh : "13-03-2023").

### Penjelasan Soal
* Membuat crontab yang melakukan apa yang dilakukan oleh script **3a**.
* Crontab dijalankan sehari sekali pada pukul 8 malam
    * mulai tanggal 1 dan tiap 7 hari (1, 8, 15, ...)
    * mulai tanggal 2 dan tiap 4 hari (2, 6, 10, ...)
* Memindahkan foto yang diunduh ke file dengan format "DD-MM-YYYY" pada tanggal tersebut. ex: ("12-03-2021")

### Solution
Menggunakan script yang sama seperti 3a, hanya saja menambahkan kode untuk memindahkan foto yang telah diunduh dan `Foto.log`.
Crontabnya cukup _straightforward_ untuk waktunya `0 20 1-31/7,2-31/4 * *` dan cukup pindah directore ke lokasi script `soal3b.sh` dan panggil scriptnya.

## c.
Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk **mengunduh** gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara **bergantian** (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, **nama folder diberi awalan** "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").

### Penjelasan Soal
* Download 23 foto dari kedua link yang disediakan yaitu https://loremflickr.com/320/240/kitten atau https://loremflickr.com/320/240/bunny.
* Kedua link tersebut dipanggil secara bergantian tiap harinya.
    * Misal tanggal 30 kucing -> tanggal 31 kelinci -> 1 kucing -> ...
* Foto beserta log nya dipindahkan ke file dengan format
    > `<Nama hewan>_DD-MM-YYYY`
    > contoh Kucing-30-03-2021

### Solution
Script yang dipakai untuk download sama dengan 3b, namun dengan beberapa modifikasi. 
* Harus mengetahui foto apa yang terakhir di download (Kucing/Kelinci), dengan melakukan awk pada directory script tersebut.
* Jika jumlah foldernya sama (antara folder kucing dan kelinci), maka download Kucing (Karena bebas ingin download kucing/kelinci terlebih dahulu).
* Cek tanggal terakhir folder foto pada directory. Jika waktunya download Kucing dari hasil di perintah sebelumnya, namun tanggal folder terakhir di download sama dengan tanggal hari ini. Maka download Kelinci, jika tanggalnya berbeda download Kucing.
* Jika jumlah filenya berbeda, maka lakukan kebalikan dari dua perintah di atas ini.
* Lalu panggil fungsi untuk memindahkan log dan foto yang baru diunduh sesuai link yang digunakan. Panggil fungsi date yang diformat sesuai soal untuk penamaan folder.

## d.
Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan **memindahkan seluruh folder ke zip** yang diberi nama “Koleksi.zip” dan **mengunci** zip tersebut dengan **password** berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).

### Penjelasan Soal
* Zip semua folder dari hasil script `soal3b.sh` dan `soal3c.sh`.
* Zip dipasang password dengan format `MMDDYYYY` yang sesuai tanggal zip itu dipanggil.
* Hapus folder yang baru saja di zip

### Solution
Panggil command `zip` pada scriptnya, dan imbuhi dengan password yang dipanggil menggunakan command `date`. Jangan lupa di reformat pemanggilan `date` nya. Kemudian hapus semua folder yang baru saja di zip.
> keyPassword=$(date +"%m%d%Y")
> zip -r -P "$keyPassword" Koleksi.zip *-*
> rm -r *-*

## e.
Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya **ter-zip** saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya **ter-unzip** dan **tidak ada file zip** sama sekali.

### Penjelasan Soal
* Membuat crontab yang dijadwalkan pada hari senin-jum'at
    * pada jam 7 pagi
    * pada jam 6 sore
* Jam 7 pagi menjalankan command zip untuk script `soal3d.sh`
* Jam 6 sore menjalankan command untuk unzip, dan hapus file zipnya.

### Solution
Terdapat dua crontab. Pertama untuk jam 7 pagi setiap senin-jum'at, `0 7 * * 1-5` memanggil script `soal3.sh`. Kedua `0 18 * * 1-5` meng-unzip file zip di directory tersebut. Lalu hapus .zip nya.
> 0 18 * * 1-5 unzip -P `date +\%m\%d\%Y` && rm Koleksi.zip

### Kesulitan
* Mencari cara untuk check foto yang diunduh ada yang kembar atau tidak. Akhirnya memutuskan dengan melakukan awk para url download nya, karena url sendiri adalah unique. Bisa digunakan untuk membandingkan.
* Cara memecah url nya lumayan sulit banyak __trial and error__ mencari cara yang pas. 
* Cara untuk mengetahui di directory tertentu ada file apa saja dan memasukannya ke awk, setelah tahu cara memasukkan hasil command ke awk lumayan memakan waktu untuk menemukan logic yang bisa menentukan menggunakan link yang mana diantara kucing dan kelinci.
* Script `soal3c.sh` berakhir sangat panjang.
* Memanggil fungsi date untuk dimasukan sebagai argumen password untuk zip. Mencari cara untuk memilih folder tertentu saja saat ingin melakukan zip.
