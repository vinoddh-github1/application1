
#This script will build docker image


version=$BUILD_ID
docker build -t apprepo:$version .
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 849440486996.dkr.ecr.us-east-1.amazonaws.com
docker tag apprepo:latest 849440486996.dkr.ecr.us-east-1.amazonaws.com/apprepo:$version
docker push 849440486996.dkr.ecr.us-east-1.amazonaws.com/apprepo:$version

echo "image successfully pushed to ECR"

