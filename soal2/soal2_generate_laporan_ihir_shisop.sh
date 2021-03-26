#!/bin/bash
awk -F'\t' 'NR>1{id=($21/(0.00000000000000000000001+$18-$21)*100)>=maks?$1:id;maks=($21/(0.00000000000000000000001+$18-$21)*100)>maks?($21/(0.00000000000000000000001+$18-$21)*100):maks}END{printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%%.\n",id,maks)}' Laporan-TokoShiSop.tsv
printf "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
awk -F'\t' '(/Albuquerque/ && $3~/??-??-17/ && a[$7]==0) {print $7;a[$7]++}' Laporan-TokoShiSop.tsv
printf "\n"
awk -F'\t' 'NR>1{a[$8]++} END{c=99999999;for(b in a){d=a[b]<c?b:d;c=a[b]<c?a[b]:c;}printf("Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n",d,c);}' Laporan-TokoShiSop.tsv
printf "\n"
awk -F'\t' 'NR>1{a[$13]=$21<a[$13]?$21:a[$13]} END{for(b in a){d=a[b]<c?b:d;c=a[b]<c?a[b]:c;}printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.4f\n",d,c)}' Laporan-TokoShiSop.tsv

