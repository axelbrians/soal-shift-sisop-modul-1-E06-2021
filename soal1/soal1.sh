#!/bin/bash

#A
grep "ticky" syslog.log | cut -f6- -d' '

#B
grep "ERROR" syslog.log | cut -f7- -d' ' | cut -f1 -d'(' | sort | uniq -c

#C
printf 'Jumlah LOG ERROR:\n'
grep "ERROR" syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c
printf 'Jumlah LOG INFO:\n'
grep "INFO" syslog.log | cut -f2 -d'(' | cut -f1 -d')' | sort | uniq -c
