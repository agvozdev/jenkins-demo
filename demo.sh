#set -x
echo Starting up docker, docker registry and triggering default build job

catch()
{
  echo Some exception caught
  ./cleanup.sh
  exit 1
}

cleanup()
{
 ./cleanup.sh
 exit
}

#trap catch ERR
trap cleanup SIGINT

addr=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')

export echo Now starting up Jenkins and docker registry

docker-compose up -d

DEMO_URL=http://admin:admin@$addr:8081/job/docker-builder
echo Will wait for Jenkins to appear at $DEMO_URL


retry=0
while [ "$retry" -lt 10 ]; do code=$(curl $DEMO_URL/ -w "%{http_code}" -o /dev/null -s); [[ "$code" == "200" ]] && echo Jenkins running && break; sleep 6; echo Waiting for Jenkins to become available; done

echo Go to $DEMO_URL and build the job, you may leave all parameters intact by default

echo You may terminate this demo with Ctrl+C, otherwise try to send this to foreground, if you know how ahahaha!

read -r -d '' _ </dev/tty
