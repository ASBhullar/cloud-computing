{\rtf1\ansi\ansicpg1252\cocoartf2709
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;\f1\fnil\fcharset0 Menlo-Bold;}
{\colortbl;\red255\green255\blue255;\red56\green185\blue199;\red0\green0\blue0;\red57\green192\blue38;
\red170\green171\blue37;\red86\green32\blue244;\red202\green51\blue35;\red255\green255\blue255;}
{\*\expandedcolortbl;;\cssrgb\c25546\c77007\c82023;\csgray\c0;\cssrgb\c25706\c77963\c19557;
\cssrgb\c72331\c71682\c18599;\cssrgb\c41681\c25958\c96648;\cssrgb\c83899\c28663\c18026;\csgray\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww28600\viewh16380\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs22 \cf2 \CocoaLigature0 #!/bin/bash\cf3 \
\
iterations\cf4 =\cf3 5\
\cf2 #Running test on gemu for qcow image\cf3 \
run_test \cf4 ()\{\cf3 \
\cf4 local\cf3  test_command\cf4 =
\f1\b \cf5 "$1"
\f0\b0 \cf3 \
\cf4 local\cf3  test_name\cf4 =
\f1\b \cf5 "$2"
\f0\b0 \cf3 \
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f1\b \cf6 echo
\f0\b0 \cf3  
\f1\b \cf5 "Running$test_name"
\f0\b0 \cf3 \
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0
\cf4 for\cf3  \cf4 ((\cf3 i\cf4 =\cf3 1\cf4 ;\cf3 i\cf4 <=
\f1\b \cf7 $iterations
\f0\b0 \cf4 ;\cf3  i++\cf4 ));\cf3  \cf4 do\cf3 \
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f1\b \cf6 echo
\f0\b0 \cf3  
\f1\b \cf5 "iteration $i:"
\f0\b0 \cf3 \
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f1\b \cf7 $test_command
\f0\b0 \cf3 \
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f1\b \cf6 echo
\f0\b0 \cf3   
\f1\b \cf5   "'.......................................................................
\f0\b0 \cf3 ."\
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0
\cf4 done\cf3 \
\cf4 \}\cf3 \
\
Test Case 0\cf4 :\cf3  Limiting execution \cf4 time\cf3  to 30 sec\
#run_test 
\f1\b \cf5 "sysbench --test=cpu --time=45 run"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 0:CPU time Limit"
\f0\b0 \cf3 \
\
\cf2 #Test Case 1: Limiting max prime 100\cf3 \
run_test 
\f1\b \cf5 "sysbench --test=cpu --cpu-max-prime=100 --time=45 run"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 1: Cpu maxprime=100"
\f0\b0 \cf3 \
\
\cf2 #Test Case 2: Limiting max prime to 1000\cf3 \
run_test 
\f1\b \cf5 "sysbench --test=cpu --cpu-max-prime=1000 --time=45 run"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 2: Cpu maxprime=1000"
\f0\b0 \cf3 \
\
\cf2 #Test Case 3: Memory block size 16M\cf3 \
#run_test 
\f1\b \cf5 "sysbench memory --memory-block-size=16M run"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 3: Cpu memory block 16M"
\f0\b0 \cf3 \
\
\cf2 #Test Case 4: Memory block size 8k\cf3 \
#run_test 
\f1\b \cf5 "sysbench memory --memory-block-size=8k run"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 4: Cpu memory block 8k"
\f0\b0 \cf3 \
\
\cf2 #Test Case 5: File creating total size 1gb\cf3 \
#run_test 
\f1\b \cf5 "sysbench --num-threads=14 --test=fileio --file-total-size=1G --max-time=100 --file-test-mode=seqwr prepare"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 5: Fi
\f0\b0 \cf8 \cb3 le io prepare\'94\cf3 \cb1 \
#run_test 
\f1\b \cf5 "sysbench --num-threads=14 --test=fileio --file-total-size=1G --max-time=100 --file-test-mode=seqwr run"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 5: File io sequential R/W\'94
\f0\b0 \cf3 \
#run_test 
\f1\b \cf5 "sysbench --test=fileio --file-total-size=1G cleanup"
\f0\b0 \cf3  
\f1\b \cf5 "File Cleanup"
\f0\b0 \cf3 \
\
\
\cf2 #Test Case 6: File creating total size 2gb\cf3 \
#run_test 
\f1\b \cf5 "sysbench --num-threads=14 --test=fileio --file-total-size=2G --max-time=100 --file-test-mode=rndrw prepare"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 6: Fi
\f0\b0 \cf8 \cb3 le io prepare\'94\cf3 \cb1 \
#run_test 
\f1\b \cf5 "sysbench --num-threads=14 --test=fileio --file-total-size=2G --max-time=100 --file-test-mode=rndrw run"
\f0\b0 \cf3  
\f1\b \cf5 "Test Case 6: File io random r/w run\'94
\f0\b0 \cf3 \
#run_test 
\f1\b \cf5 "sysbench --test=fileio --file-total-size=2G cleanup"
\f0\b0 \cf3  
\f1\b \cf5 "File Cleanup"
\f0\b0 \cf3 \
\
}