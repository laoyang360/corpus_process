#author：http://blog.csdn.net/laoyang360
#date:20160304 pm22:38
#version:V0.1
#!/bin/bash

#the dir for use
DIR_NAME=./train
OUT_RESULT=./out_result
CNT_FILE=files_cnt.txt
NAME_FILE=all_file_dir.txt
TOTAL_TYPES_FILE=$OUT_RESULT/outtype.txt
TOTAL_TYPES_BAK_FILE=total_types_bak.txt
TOTAL_OUTFILE=$OUT_RESULT/outdata.txt

#clear the existing contents
function initialize()
{
mkdir $OUT_RESULT
cat /dev/null > $CNT_FILE
cat /dev/null > $NAME_FILE
cat /dev/null > $TOTAL_TYPES_FILE
cat /dev/null > $TOTAL_OUTFILE;
}

#list all files and stat file cnts
function list_all_files()
{
for file in ` ls $1 | sort`
do
if [ -d $1"/"$file ]
then

file_cnt=`ls $1"/"$file | wc -l`
echo $1"/"$file $file_cnt >> $CNT_FILE
list_all_files $1"/"$file 
else
echo $1"/"$file >> $NAME_FILE
fi 
done 
}

#construct files sort by types
function constrcut_type_files()
{
line_cnt=1;
mkdir ./out_put
cat $CNT_FILE | while read line
do
CNT_NO_FILE=${CNT_FILE}_${line_cnt}
#echo "linecnt="$line_cnt;
echo $line > ./out_put/$CNT_NO_FILE;

#first column of every line
type_name=` awk '{print $1}' ./out_put/$CNT_NO_FILE `
#sencond column of every line, nums for print
type_cnt=` awk '{print $2}' ./out_put/$CNT_NO_FILE `
echo $type_name $type_cnt

#construct files
for((curnum=0;curnum<$type_cnt;curnum++))
{
echo $type_name >> $TOTAL_TYPES_FILE
}
line_cnt=$((line_cnt+1));
done;
rm -rf ./out_put
}

#format types_files
function typefile_format()
{
#bak for source
cp -f $TOTAL_TYPES_FILE $TOTAL_TYPES_BAK_FILE
sed -i 's#./train/##g' $TOTAL_TYPES_FILE;
sed -i 's#C4-Literature#文学#g' $TOTAL_TYPES_FILE; #17
sed -i 's#C5-Education#教育#g' $TOTAL_TYPES_FILE; #18
sed -i 's#C6-Philosophy#哲学#g' $TOTAL_TYPES_FILE; #19
sed -i 's#C15-Energy#能源#g' $TOTAL_TYPES_FILE; #2
sed -i 's#C16-Electronics#电子#g' $TOTAL_TYPES_FILE; #3 1240
sed -i 's#C17-Communication#通讯#g' $TOTAL_TYPES_FILE; #4
sed -i 's#C29-Transport#运输#g' $TOTAL_TYPES_FILE; #7
sed -i 's#C35-Law#法学#g' $TOTAL_TYPES_FILE; #11
sed -i 's#C36-Medical#医学#g' $TOTAL_TYPES_FILE; #12
sed -i 's#C37-Military#军事#g' $TOTAL_TYPES_FILE; #13

#sed -i 's#C3-Art#艺术#g' $TOTAL_TYPES_FILE; #16 763
#sed -i 's#C7-History#历史#g' $TOTAL_TYPES_FILE #20 
#sed -i 's#C11-Space#空间#g' $TOTAL_TYPES_FILE; #1
#sed -i 's#C19-Computer#电脑#g' $TOTAL_TYPES_FILE; #5
#sed -i 's#C23-Mine#矿#g' $TOTAL_TYPES_FILE; #6
#sed -i 's#C31-Enviornment#环境#g' $TOTAL_TYPES_FILE; #8 
#sed -i 's#C32-Agriculture#农业#g' $TOTAL_TYPES_FILE; #9
#sed -i 's#C34-Economy#经济#g' $TOTAL_TYPES_FILE; #10 1623
#sed -i 's#C38-Politics#政治#g' $TOTAL_TYPES_FILE; #14 1047
#sed -i 's#C39-Sports#体育#g' $TOTAL_TYPES_FILE; #15 
}

#GBK2UTF8, ./train changed to utf-8 format
function GBK2UTF8()
{
#for all files in ./train
` find $DIR_NAME -type d -exec mkdir -p utf/{} \; `
` find $DIR_NAME -type f -exec iconv -f GBK -t UTF-8 {} -o utf/{} >/dev/null 2>&1 \; ` 

rm -rf $DIR_NAME;
mv utf/* ./;
}

#new and "[EndEnd]" at the end of every file
function allfiles_addend()
{
icnt=0;
cat $NAME_FILE | while read line
do
echo "[EndEnd]" >> $line;
icnt=$((icnt+1));
#echo "icnt ="$icnt;
done;
}

#Merage all files together
function merge_all_files()
{
#find $DIR_NAME -type f -exec cat {} \;>all_files_together.txt 
icnt=0;
cat $NAME_FILE | while read line
do
cat $line >> $TOTAL_OUTFILE;
icnt=$((icnt+1));
echo "icnt ="$icnt;
done;
}

#executing for use
initialize;
list_all_files $DIR_NAME;
constrcut_type_files;
typefile_format;
GBK2UTF8;
allfiles_addend;
merge_all_files;
