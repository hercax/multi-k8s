docker build -t hercax/multi-client:latest -t hercax/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hercax/multi-server:latest -t hercax/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hercax/multi-worker:latest -t hercax/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hercax/multi-cient:latest
docker push hercax/multi-server:latest
docker push hercax/multi-worker:latest

docker push hercax/multi-cient:$SHA
docker push hercax/multi-server:$SHA
docker push hercax/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hercax/multi-server:$SHA
kubectl set image deployments/client-deployment client=hercax/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hercax/multi-worker:$SHA