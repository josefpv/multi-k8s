docker build -t josefvivas/multi-client:latest -t josefvivas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t josefvivas/multi-server:latest -t josefvivas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t josefvivas/multi-worker:latest -t josefvivas/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push josefvivas/multi-client:latest
docker push josefvivas/multi-server:latest
docker push josefvivas/multi-worker:latest

docker push josefvivas/multi-client:$SHA
docker push josefvivas/multi-server:$SHA
docker push josefvivas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=josefvivas/multi-server:$SHA
kubectl set image deployments/client-deployment client=josefvivas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=josefvivas/multi-worker:$SHA