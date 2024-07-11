#!/bin/bash

# Mise à jour du système
sudo apt update
sudo apt upgrade -y

# Installation des dépendances
sudo apt install -y ca-certificates curl gnupg lsb-release

# Ajout de la clé GPG officielle de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Ajout du dépôt Docker
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mise à jour du cache APT
sudo apt update

# Installation de Docker Engine et Docker Compose v2
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Vérification de l'installation
sudo docker --version
sudo docker compose version

# Ajout de l'utilisateur au groupe Docker (optionnel)
sudo usermod -aG docker $USER

echo "Installation de Docker et Docker Compose v2 terminée."
echo "Déconnectez-vous et reconnectez-vous pour appliquer les modifications de groupe (si nécessaire)."
