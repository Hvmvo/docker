#!/bin/bash

# Mettre à jour le système
sudo apt-get update

# Installer les dépendances
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Ajouter la clé GPG officielle de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Ajouter le dépôt Docker aux sources APT
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour le système avec le dépôt Docker
sudo apt-get update

# Installer Docker Engine, Docker CLI, et containerd
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Ajouter l'utilisateur actuel au groupe Docker pour éviter d'utiliser 'sudo' avec Docker
sudo usermod -aG docker $USER

# Installer Docker Compose v2
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Afficher les versions installées
docker --version
docker-compose --version

echo "Installation de Docker et Docker Compose v2 terminée. Veuillez redémarrer votre session ou exécuter 'newgrp docker' pour appliquer les changements de groupe."
