#!/bin/bash
cd ~/GirInMoto/cgsexpress_db_backups/

NUMOFFILE=$(ls | wc -l)
MAXACTIVEBCKP=20
MAXDELETEFILE=10


if [[ $NUMOFFILE -gt $MAXACTIVEBCKP ]]
        then
                echo  "Piu di $MAXACTIVEBCKP, elimino i primi $MAXDELETEFILE"
                for FILE in $(ls -tr | grep "cgs*" | head -$MAXDELETEFILE)
                        do
                                rm  $FILE
                        done
else
        echo "Sotto i $MAXACTIVEBCKP bkp"
fi




TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")

docker exec cgs_mysqldb_1 /usr/bin/mysqldump -u root --password=7DZeHNq19W6O express | gzip -9 > /root/CGS/cgsexpress_db_backups/cgsexpress_db_backup_$TIMESTAMP.gz
