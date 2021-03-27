touch Foto.log

checkDuplicate () {
    awk '
        BEGIN { 
            arr[0]="foo";
            i=0;
        }

        /cache/resized {
            split($3, path, "/");

            split(path[6], under, "_");

            arr[i]=under[3];
            i+=1
        }

        END {
            looper=1
            super=1
            print i
            if ( i == 1 ) {
                exit 1
            } else {    
                for (looper=1; looper<i-1; looper++) {
                    if ( arr[looper] == arr[i-1] ) {
                        exit 2
                    }
                }
            }
            exit 1
        }

    ' Foto.log
}

moveKucing () {
    tudey=$(date +"%d-%m-%Y")

    mkdir Kucing_$tudey
    mv *.jpeg Kucing_$tudey
    mv Foto.log Kucing_$tudey
}

moveKelinci () {
    tudey2=$(date +"%d-%m-%Y")

    mkdir Kelinci_$tudey2
    mv *.jpeg Kelinci_$tudey2
    mv Foto.log Kelinci_$tudey2
}

fotoFolder="`ls $dir_path`"

awk '
    BEGIN {
        arrKucing[0]="foo";
        arrKelinci[0]="bar";
        kelinci=0;
        kucing=0;
    }

    /Kelinci/ {
        split($1, path, "_");
        split(path[2], dash, "-");
        arrKelinci[kelinci]=dash[1]
        kelinci+=1
    }

    /Kucing/ {
        split($1, path, "_");
        split(path[2], dash, "-");
        arrKucing[kucing]=dash[1]
        kucing+=1
    }

    END {
        if ( kucing == kelinci ) {
            exit arrKucing[kucing-1]
        } else {
            exit arrKelinci[kelinci-1]
        }
    }

' <<< $fotoFolder

lastDate=$?

awk '
    BEGIN {
        arrKucing[0]="foo";
        arrKelinci[0]="bar";
        kelinci=0;
        kucing=0;
    }

    /Kelinci/ {
        split($1, path, "_");
        split(path[2], dash, "-");
        arrKelinci[kelinci]=dash[1]
        kelinci+=1
    }

    /Kucing/ {
        split($1, path, "_");
        split(path[2], dash, "-");
        arrKucing[kucing]=dash[1]
        kucing+=1
    }

    END {
        if ( kucing == kelinci ) {
            exit 1
        } else {
            exit 2
        }
    }

' <<< $fotoFolder

donlotType=$?
currDate=$(date +%d)

urut=1
donlot=1


if [ $currDate == $lastDate ]
then
    if [ $donlotType -eq 1 ]
    then
        while [ $donlot -le 23 ]
        do
            if [ $urut -lt 10 ]
            then
                wget -nv -O Koleksi_0$urut.jpeg https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log
            else
                wget -nv -O Koleksi_$urut.jpeg https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log
            fi

            checkDuplicate
            re=$?

            if [ $urut -lt 10 ]
            then
                if [ $re -eq 2 ]
                then 
                    rm Koleksi_0$urut
                else
                    urut=$(( $urut + 1))
                fi
            else
                if [ $re -eq 2 ]
                then 
                    rm Koleksi_$urut
                else
                    urut=$(( $urut + 1))
                fi
            fi
            donlot=$(( $donlot + 1))
        done
        moveKucing
    else
        while [ $donlot -le 23 ]
        do
            if [ $urut -lt 10 ]
            then
                wget -nv -O Koleksi_0$urut.jpeg https://loremflickr.com/320/240/bunny 2>&1 | tee -a Foto.log
            else
                wget -nv -O Koleksi_$urut.jpeg https://loremflickr.com/320/240/bunny 2>&1 | tee -a Foto.log
            fi

            checkDuplicate
            re=$?

            if [ $urut -lt 10 ]
            then
                if [ $re -eq 2 ]
                then 
                    rm Koleksi_0$urut.jpeg
                else
                    urut=$(( $urut + 1))
                fi
            else
                if [ $re -eq 2 ]
                then 
                    rm Koleksi_$urut.jpeg
                else
                    urut=$(( $urut + 1))
                fi
            fi
            donlot=$(( $donlot + 1))
        done
        moveKelinci
    fi
else
    if [ $donlotType -eq 2 ]
    then
        while [ $donlot -le 23 ]
        do
            if [ $urut -lt 10 ]
            then
                wget -nv -O Koleksi_0$urut.jpeg https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log
            else
                wget -nv -O Koleksi_$urut.jpeg https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log
            fi

            checkDuplicate
            re=$?

            if [ $urut -lt 10 ]
            then
                if [ $re -eq 2 ]
                then 
                    rm Koleksi_0$urut.jpeg
                else
                    urut=$(( $urut + 1))
                fi
            else
                if [ $re -eq 2 ]
                then 
                    rm Koleksi_$urut.jpeg
                else
                    urut=$(( $urut + 1))
                fi
            fi
            donlot=$(( $donlot + 1))
        done
        moveKucing
    else
        while [ $donlot -le 23 ]
        do
            if [ $urut -lt 10 ]
            then
                wget -nv -O Koleksi_0$urut.jpeg https://loremflickr.com/320/240/bunny 2>&1 | tee -a Foto.log
            else
                wget -nv -O Koleksi_$urut.jpeg https://loremflickr.com/320/240/bunny 2>&1 | tee -a Foto.log
            fi

            checkDuplicate
            re=$?

            if [ $urut -lt 10 ]
            then
                if [ $re -eq 2 ]
                then 
                    rm Koleksi_0$urut.jpeg
                else
                    urut=$(( $urut + 1))
                fi
            else
                if [ $re -eq 2 ]
                then 
                    rm Koleksi_$urut.jpeg
                else
                    urut=$(( $urut + 1))
                fi
            fi
            donlot=$(( $donlot + 1))
        done
        moveKelinci
    fi
fi

