curl -o tws-latest-standalone-linux-x64.sh https://download2.interactivebrokers.com/installers/tws/latest-standalone/tws-latest-standalone-linux-x64.sh 

# build normally
docker build -t twstest .

# cross build if on arm
docker buildx build --platform linux/amd64 .

# optional: push to registry
docker buildx build --platform linux/amd64 --push -t your-docker-registry.you.local/ibkrtws . 

# if using docker-compose, do this:

docker-compose build

echo "Did you remember to set VNC_PASSWORD, TWS_USER, and TWS_PASS?"
echo "VNC_PASSWORD: $VNC_PASSWORD"
echo "TWS_USER: $TWS_USER"
echo "TWS_PASS: $TWS_PASS"

docker-compose up

# if NOT using docker compose, do this:

docker run -it -p7497:7497 -p7496:7496 --name twstest -h twstest --platform=linux/amd64 --rm -e INIT_PAPER=1 -e TWS_USER=james_simmons -e TWS_PASS=topSecretPassword -e VNC_PASSWORD=1234 twstest 
