!/bin/bash

#A
grep "ticky" syslog.log | cut -f6- -d' '
echo

#B
grep "ERROR" syslog.log | cut -f7- -d' ' | cut -f1 -d'(' | sort | uniq -c
echo

#C
echo Jumlah LOG ERROR per USER
grep "ERROR" syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c
echo Jumlah LOG INFO per USER
grep "INFO" syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c
echo

#D
echo Error,Count >> error_message.csv
grep "ERROR" syslog.log | cut -f7- -d' ' | cut -f1 -d'(' | sort | uniq -c | sort -nr | while read count text
do
    echo $text,$count >> error_message.csv
done

#E
echo Username,INFO,ERROR >> user_statistic.csv
grep "ticky" syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c | while read count name
do
    info=`grep "INFO" syslog.log | grep -w "$name" | wc -l`
    error=`grep "ERROR" syslog.log | grep -w "$name" | wc -l`
    echo $name,$info,$error >> user_statistic.csv
done
