docker build -t laxtour/multi-client:latest -t laxtour/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t laxtour/multi-server:latest -t laxtour/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t laxtour/multi-worker:latest -t laxtour/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push laxtour/multi-client:latest
docker push laxtour/multi-server:latest
docker push laxtour/multi-worker:latest

docker push laxtour/multi-client:$SHA
docker push laxtour/multi-server:$SHA
docker push laxtour/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=laxtour/multi-server:$SHA
kubectl set image deployments/client-deployment client=laxtour/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=laxtour/multi-worker:$SHA


