docker build -t navywharf/multi-client:latest -t navywharf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t navywharf/multi-server:latest -t navywharf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t navywharf/multi-worker:latest -t navywharf/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push navywharf/multi-client:latest
docker push navywharf/multi-server:latest
docker push navywharf/multi-worker:latest
docker push navywharf/multi-client:$SHA
docker push navywharf/multi-server:$SHA
docker push navywharf/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=navywharf/multi-server:$SHA
kubectl set image deployments/client-deployment client=navywharf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=navywharf/multi-worker:$SHA