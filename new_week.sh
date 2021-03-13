#!/bin/bash

echo '\n' Ready to create a new week planner '\n'

read -p 'What is the week start date? Enter as mm-dd-yy [today]:  ' START
START=${START:-$(date '+%m-%d-%y')}

echo '\n'Creating a new weekly planner starting on $(date -j -f %m-%d-%y $START '+%A %m-%d-%y') '\n'

WEEK_DIR=$START-To-$(date -j -f %m-%d-%y -v+6d $START '+%m-%d-%y')
mkdir $WEEK_DIR
cd $WEEK_DIR

for i in {0..6}
do
    NEXT_DATE=$(date -j -f %m-%d-%y -v+"$i"d $START '+%m-%d-%y')
    FILE_NAME=$((i+1))-$(date -j -f %m-%d-%y -v+"$i"d $START '+%A-%m-%d-%y').md
    touch $FILE_NAME
    (echo "## $(date -j -f %m-%d-%y $NEXT_DATE '+%A %b %d, %Y')";
    echo "### To-do";
    echo "- [ ] Create list";
    echo "\n";
    echo "### Brain Dump/ Notes";
    echo "\n";) >> $FILE_NAME
done

touch Weekly_Overview.md
(echo "## Week of $(date -j -f %m-%d-%y $START '+%b %d') - $(date -j -f %m-%d-%y -v+6d $START '+%b %d, %Y')"
echo "### Appointments & Meetings";
echo "**12:00PM $(date -j -f %m-%d-%y $START '+%A %m-%d-%y')** - Meeting with Someone";
echo '\n'
echo "### Weekly To-do";
echo "- [ ] Have a great week";
echo "\n" >> $FILE_NAME
echo "### Brain Dump/ Notes";
echo "\n";) >> Weekly_Overview.md

echo Creation complete. Enjoy your week.
