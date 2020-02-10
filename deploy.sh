docker build -t afilipash/multi-client:latest -t afilipash/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t afilipash/multi-server:latest -t afilipash/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t afilipash/multi-worker:latest -t afilipash/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push afilipash/multi-client:latest 
docker push afilipash/multi-server:latest
docker push afilipash/multi-worker:latest
docker push afilipash/multi-client:$SHA 
docker push afilipash/multi-server:$SHA
docker push afilipash/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=afilipash/multi-server:$SHA
kubectl set image deployment/client-deployment client=afilipash/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=afilipash/multi-worker:$SHA