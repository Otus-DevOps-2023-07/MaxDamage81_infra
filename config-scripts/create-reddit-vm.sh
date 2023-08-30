yc compute instance create \
  --name reddit-app-full \
  --hostname reddit-app-full \
  --zone=ru-central1-a \
  --create-boot-disk size=20GB,image-id=fd8h9u9kcfi4gvrd96st \
  --cores=2 \
  --core-fraction=20 \
  --memory=4G \
  --network-interface subnet-id=e9bkuibq1vtnre11mk3b,ipv4-address=auto,nat-ip-version=ipv4
