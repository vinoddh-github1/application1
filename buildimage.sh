
#This script will build docker image


version=$BUILD_ID
docker build -t apprepo .
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 849440486996.dkr.ecr.us-east-1.amazonaws.com
docker tag apprepo:latest 849440486996.dkr.ecr.us-east-1.amazonaws.com/apprepo:$version
docker push 849440486996.dkr.ecr.us-east-1.amazonaws.com/apprepo:$version

echo "image successfully pushed to ECR"

#Create new task definition with new version of build number

sed -i s#849440486996.dkr.ecr.us-east-1.amazonaws.com/apprepo:32#849440486996.dkr.ecr.us-east-1.amazonaws.com/apprepo:$version#g taskdef.json

aws ecs register-task-definition --cli-input-json file://taskdef.json --region us-east-1

echo "New task revision created"


