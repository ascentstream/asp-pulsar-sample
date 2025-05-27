#!/bin/sh
pname=SampleStart
pid=`ps -ef|grep $pname |grep -v grep|awk '{print $2}'`
if [ "X$pid" = "X" ]
        then
                sh runserver.sh com.ascentstream.playground.SampleStart &
                sleep 1
                pid=`ps -ef|grep $pname|grep -v grep|awk '{print $2}'`
                echo $pid > run.pid
                echo "START UP [$pname]" 
        else
		ps -ef|grep $pname|grep -v grep|awk '{print $2}'|xargs kill -1
		sleep 1	
		pid1=`ps -ef|grep $pname |grep -v grep|awk '{print $2}'`
		
		if [ "X$pid1" = "X" ]
			then 	
				echo "KILL PROCESS"
				    sh runserver.sh com.ascentstream.playground.SampleStart &
                echo "RESTART PROCESS OK" 
				pid2=`ps -ef|grep $pname |grep -v grep|awk '{print $2}'`
                echo $pid2 > run.pid
			else
				echo "PROCESS ALREADY EXIT,STOP FAILED"
		fi
fi
