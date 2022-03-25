docker build -t peterkeiser/multi-client:latest -t peterkeiser/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peterkeiser/multi-server:latest -t peterkeiser/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peterkeiser/multi-worker:latest -t peterkeiser/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push peterkeiser/multi-client:latest
docker push peterkeiser/multi-server:latest
docker push peterkeiser/multi-worker:latest

docker push peterkeiser/multi-client:$SHA
docker push peterkeiser/multi-server:$SHA
docker push peterkeiser/multi-worker:$SHA

kubectl apply -f k82
kubectl set image deployments/server-deployment server=peterkeiser/multi-server:$SHA
kubectl set image deployments/client-deployment client=peterkeiser/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peterkeiser/multi-worker:$SHA
