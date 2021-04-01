!/bin/bash

#A
grep "ticky" syslog.log | cut -f6- -d' '
printf '\n'

#B
grep "ERROR" syslog.log | cut -f7- -d' ' | cut -f1 -d'(' | sort | uniq -c
printf '\n'

#C
printf 'Jumlah LOG ERROR per USER:\n'
grep "ERROR" syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c
printf 'Jumlah LOG INFO per USER:\n'
grep "INFO" syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c
printf '\n'

#D
echo Error,Count >> error_message.csv
grep "ERROR" syslog.log | cut -f8- -d' ' | cut -f1 -d'(' | sort | uniq -c | sort -nr | while read count text
do
    echo $text,$count >> error_message.csv
done

#E
echo Username,INFO,ERROR >> user_statistic.csv
grep "ERROR" syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | while read count name
do
    infoC=`grep "INFO" syslog.log | grep -w "$name" | wc -l`
    errC=`grep "ERROR" syslog.log | grep -w "$name" | wc -l`
    echo $name,$infoC,$errC >> user_statistic.csv
done
