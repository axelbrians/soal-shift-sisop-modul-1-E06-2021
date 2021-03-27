touch Foto.log

function checkDuplicate () {
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

urut=1
donlot=1

while [ $donlot -le 23 ]
do
    if [ $urut -lt 10 ]
    then
        wget -nv -O Kitten_0$urut.jpeg https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log
    else
        wget -nv -O Kitten_$urut.jpeg https://loremflickr.com/320/240/kitten 2>&1 | tee -a Foto.log
    fi

    checkDuplicate
    re=$?

    if [ $urut -lt 10 ]
    then
        if [ $re -eq 2 ]
        then 
            rm Kitten_0$urut
        else
            urut=$(( $urut + 1))
        fi
    else
        if [ $re -eq 2 ]
        then 
            rm Kitten_$urut
        else
            urut=$(( $urut + 1))
        fi
    fi

    donlot=$(( $donlot + 1))

done

tudey=$(date +"%d-%m-%Y")
mkdir $tudey
mv Foto.log $tudey
mv *.jpeg $tudey
