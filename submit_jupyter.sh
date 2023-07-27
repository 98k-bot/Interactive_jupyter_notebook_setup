#!/bin/bash
rm /common/zhanh/Jupyter_Scripts/err_jupyter
rm /common/zhanh/Jupyter_Scripts/out_jupyter
QSUBID=`sbatch /common/zhanh/Jupyter_Scripts/_submit_jupyter.sh | tr -dc '0-9'`
sleep 30
QSERV=$(squeue -j ${QSUBID} | grep exec_host_list | cut -d ':' -f2 | tr -d "[:space:]")
WHOAMI=`whoami`
PORTNUM=`cksum <<< ${WHOAMI} | cut -f 1 -d ' ' | cut -c1-4`
ssh -N -f -L localhost:${PORTNUM}:localhost:${PORTNUM} ${WHOAMI}@${QSERV}
sleep 20
HTML=`grep -A1 'Or copy and paste' /common/zhanh/Jupyter_Scripts/err_jupyter | grep -v "Or"`
echo ${HTML}
# print tunneling instructions jupyter-log
echo -e "
MacOS or linux terminal command to create your ssh tunnel:
ssh -N -f -L localhost:${PORTNUM}:localhost:${PORTNUM} ${WHOAMI}@${QSERV}

Use a Browser on your local machine to go to:
localhost:${PORTNUM}  (prefix w/ https:// if using password)
"
sleep 86400
qdel ${QSUBID}
lsof -ti:${PORTNUM} | xargs kill -9 
