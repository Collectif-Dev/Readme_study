# Travaux Pratiques (TP) - Formation Linux Complète

## TP 1 : Créer une clé USB bootable avec Ventoy

**Durée estimée** : 15-20 minutes  
**Objectif** : Savoir créer une clé USB bootable réutilisable  
**Difficultés** : Très facile

### Étapes

1. **Télécharger Ventoy**
   - Aller sur https://www.ventoy.net/
   - Télécharger la version Linux (ventoy-X.X.X-linux.tar.gz)

2. **Extraire l'archive**
   ```bash
   tar -xzf ventoy-*.tar.gz
   cd ventoy-*/
   ```

3. **Identifier la clé USB**
   ```bash
   lsblk
   # Exemple : sdb (8GB, votre clé)
   ```

4. **Installer Ventoy** (attention au bon disque !)
   ```bash
   sudo ./Ventoy2Disk.sh -i /dev/sdb
   # Tapez "y" pour confirmer
   ```

5. **Copier l'ISO**
   ```bash
   # Brancher la clé (elle est détectée)
   # Copier l'ISO dessus
   cp ~/Downloads/linuxmint.iso /media/arthur/Ventoy/
   ```

6. **Tester**
   - Redémarrer
   - Sélectionner boot USB
   - Choisir l'ISO

### Résultat attendu
✅ Clé USB bootable avec plusieurs ISO (réutilisable)

---

## TP 2 : Installer Linux Mint Cinnamon en machine virtuelle

**Durée estimée** : 30-45 minutes  
**Objectif** : Installation sans risque + découvrir l'interface  
**Difficultés** : Facile

### Étapes

1. **Installer VirtualBox** (si pas déjà fait)
   ```bash
   sudo apt install virtualbox -y
   ```

2. **Créer une machine virtuelle**
   - Ouvrir VirtualBox
   - Cliquer "Nouvelle"
   - Nom : "Linux Mint Test"
   - Type : Linux
   - Version : Linux Mint 64-bit
   - RAM : 4 GB minimum
   - Disque : 30 GB

3. **Configurer l'ISO**
   - Paramètres → Stockage
   - Sélectionner le lecteur CD
   - Choisir l'ISO Linux Mint

4. **Démarrer et installer**
   - Démarrer la machine
   - Suivre l'installation (même que TP 1)
   - Partitionnement : automatique

5. **Post-installation**
   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

### Résultat attendu
✅ Linux Mint en VM fonctionnel et à jour

---

## TP 3 : Créer et gérer des utilisateurs

**Durée estimée** : 20 minutes  
**Objectif** : Maîtriser les utilisateurs Linux  
**Difficultés** : Moyen

### Étapes

1. **Créer 3 utilisateurs**
   ```bash
   sudo adduser alice
   sudo adduser bob
   sudo adduser charlie
   
   # Voir les utilisateurs
   cat /etc/passwd | grep -E "alice|bob|charlie"
   ```

2. **Ajouter au groupe sudo**
   ```bash
   sudo usermod -aG sudo alice
   groups alice
   ```

3. **Créer un groupe "developers"**
   ```bash
   sudo groupadd developers
   sudo usermod -aG developers bob
   sudo usermod -aG developers charlie
   groups bob
   ```

4. **Tester les permissions**
   ```bash
   # Devenir alice
   su - alice
   
   # Voir si on peut utiliser sudo
   sudo whoami
   # Entrer le mot de passe d'alice
   
   exit
   ```

5. **Changer mot de passe**
   ```bash
   sudo passwd alice
   # Entrer nouveau mot de passe
   ```

### Résultat attendu
✅ 3 utilisateurs créés, permissions configurées

---

## TP 4 : Mises à jour du système et maintenance

**Durée estimée** : 15 minutes  
**Objectif** : Savoir maintenir un système Linux  
**Difficultés** : Très facile

### Étapes

1. **Voir l'état du système**
   ```bash
   uname -a
   lsb_release -a
   df -h
   free -h
   ```

2. **Mettre à jour**
   ```bash
   sudo apt update
   sudo apt upgrade -y
   sudo apt full-upgrade -y
   ```

3. **Nettoyer**
   ```bash
   sudo apt autoremove
   sudo apt autoclean
   sudo apt clean
   ```

4. **Voir les logs**
   ```bash
   journalctl -n 50           # 50 dernières entrées
   journalctl -f              # Suivre en direct
   # Ctrl+C pour arrêter
   ```

5. **Vérifier l'intégrité disque**
   ```bash
   sudo fsck -n /dev/sda1     # Check seulement, pas de modifications
   ```

### Résultat attendu
✅ Système à jour et bien entretenu

---

## TP 5 : Installer Git et VS Code - Premier projet

**Durée estimée** : 25 minutes  
**Objectif** : Environnement de développement fonctionnel  
**Difficultés** : Moyen

### Étapes

1. **Installer Git**
   ```bash
   sudo apt install git -y
   git --version
   
   # Configurer
   git config --global user.name "Arthur Dupont"
   git config --global user.email "arthur@example.com"
   ```

2. **Installer VS Code**
   ```bash
   sudo apt install code -y
   code --version
   
   # Lancer VS Code
   code &
   ```

3. **Créer un projet**
   ```bash
   mkdir mon_premier_projet
   cd mon_premier_projet
   git init
   ```

4. **Créer des fichiers**
   ```bash
   cat > README.md << EOF
   # Mon Premier Projet
   
   Ceci est mon premier projet Linux !
   
   ## Installation
   \`\`\`bash
   git clone https://github.com/user/mon_premier_projet
   \`\`\`
   EOF
   
   cat > main.py << EOF
   #!/usr/bin/env python3
   print("Hello Linux!")
   EOF
   ```

5. **Commiter**
   ```bash
   git add .
   git commit -m "Initial commit"
   git log
   ```

6. **Voir le projet dans VS Code**
   ```bash
   code .
   ```

### Résultat attendu
✅ Projet Git avec VS Code, prêt pour développer

---

## TP 6 : Créer un dépôt Git local et collaborer

**Durée estimée** : 30 minutes  
**Objectif** : Git en équipe  
**Difficultés** : Moyen

### Étapes

1. **Créer un dépôt "serveur"**
   ```bash
   mkdir ~/serveur_git
   cd ~/serveur_git
   git init --bare mon_projet.git
   ```

2. **Cloner en tant qu'alice**
   ```bash
   su - alice
   git clone /root/serveur_git/mon_projet.git
   cd mon_projet
   git config user.name "Alice"
   git config user.email "alice@example.com"
   ```

3. **Alice crée un fichier**
   ```bash
   echo "Travail d'Alice" > alice_work.txt
   git add .
   git commit -m "Ajouter alice_work.txt"
   git push
   exit
   ```

4. **Bob clone et collabore**
   ```bash
   su - bob
   git clone /root/serveur_git/mon_projet.git
   cd mon_projet
   git config user.name "Bob"
   git config user.email "bob@example.com"
   git log
   
   echo "Travail de Bob" > bob_work.txt
   git add .
   git commit -m "Ajouter bob_work.txt"
   git push
   exit
   ```

5. **Alice récupère le travail de Bob**
   ```bash
   su - alice
   cd mon_projet
   git pull
   ls
   # Voir bob_work.txt
   exit
   ```

### Résultat attendu
✅ Collaboration simple via Git

---

## TP 7 : Configuration SSH et accès distant

**Durée estimée** : 25 minutes  
**Objectif** : Accès sécurisé à un serveur  
**Difficultés** : Moyen-Difficile

### Étapes

1. **Activer SSH**
   ```bash
   sudo systemctl status ssh
   # Si inactif :
   sudo systemctl enable ssh
   sudo systemctl start ssh
   ```

2. **Générer clés SSH**
   ```bash
   ssh-keygen -t ed25519 -C "arthur@linux"
   # Appuyer Entrée pour fichier par défaut
   # Entrer une passphrase (sécurisée)
   ```

3. **Voir les clés**
   ```bash
   ls -la ~/.ssh/
   cat ~/.ssh/id_ed25519.pub
   ```

4. **Copier sur serveur (même ordi pour le test)**
   ```bash
   ssh-copy-id -i ~/.ssh/id_ed25519.pub arthur@localhost
   # Entrer le mot de passe d'arthur
   ```

5. **Tester la connexion**
   ```bash
   ssh arthur@localhost
   # Devrait pas demander de mot de passe
   exit
   ```

6. **Configurer SSH** (optionnel, avancé)
   ```bash
   sudo nano /etc/ssh/sshd_config
   # Chercher et modifier :
   # PermitRootLogin no
   # PasswordAuthentication no
   
   sudo systemctl restart ssh
   ```

### Résultat attendu
✅ Accès SSH par clé sans mot de passe

---

## TP 8 : Créer un script de sauvegarde automatisé

**Durée estimée** : 30 minutes  
**Objectif** : Automatisation et maintenance  
**Difficultés** : Moyen

### Étapes

1. **Créer le script**
   ```bash
   mkdir -p ~/scripts
   cat > ~/scripts/backup.sh << 'EOF'
   #!/bin/bash
   
   # Configuration
   SOURCE="/home/$USER/mon_projet"
   BACKUP_DIR="/tmp/backups"
   DATE=$(date +%Y%m%d_%H%M%S)
   
   # Créer répertoire
   mkdir -p "$BACKUP_DIR"
   
   # Créer la sauvegarde
   tar czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE"
   
   echo "✅ Sauvegarde créée : $BACKUP_DIR/backup_$DATE.tar.gz"
   
   # Garder seulement 5 dernières sauvegardes
   ls -t "$BACKUP_DIR"/backup_*.tar.gz | tail -n +6 | xargs rm -f
   EOF
   ```

2. **Rendre exécutable**
   ```bash
   chmod +x ~/scripts/backup.sh
   ```

3. **Tester le script**
   ```bash
   ~/scripts/backup.sh
   ls -lah /tmp/backups/
   ```

4. **Programmer avec crontab**
   ```bash
   crontab -e
   # Ajouter la ligne :
   0 2 * * * /home/arthur/scripts/backup.sh
   # Sauvegarde tous les jours à 2h du matin
   ```

5. **Vérifier crontab**
   ```bash
   crontab -l
   ```

6. **Voir les logs (optionnel)**
   ```bash
   sudo grep CRON /var/log/auth.log
   ```

### Résultat attendu
✅ Sauvegarde automatisée qui s'exécute chaque nuit

---

## TP 9 : Docker - Premier conteneur

**Durée estimée** : 30 minutes  
**Objectif** : Comprendre la containerisation  
**Difficultés** : Moyen

### Étapes

1. **Vérifier Docker**
   ```bash
   docker --version
   docker run hello-world
   ```

2. **Créer un Dockerfile**
   ```bash
   mkdir ~/docker_app
   cd ~/docker_app
   
   cat > Dockerfile << EOF
   FROM ubuntu:22.04
   
   RUN apt-get update && apt-get install -y python3
   
   COPY app.py /app/app.py
   
   WORKDIR /app
   
   CMD ["python3", "app.py"]
   EOF
   ```

3. **Créer l'application**
   ```bash
   cat > app.py << EOF
   #!/usr/bin/env python3
   import platform
   print(f"Système : {platform.system()}")
   print("Hello from Docker!")
   EOF
   ```

4. **Construire l'image**
   ```bash
   docker build -t ma_app:v1 .
   ```

5. **Voir l'image**
   ```bash
   docker images
   ```

6. **Lancer le conteneur**
   ```bash
   docker run ma_app:v1
   ```

7. **Conteneur interactif**
   ```bash
   docker run -it ubuntu:22.04 /bin/bash
   # Vous êtes dans le conteneur
   apt-get update
   apt-get install -y htop
   htop
   exit
   ```

### Résultat attendu
✅ Conteneur Docker fonctionnel

---

## TP 10 : Examen final - Projet complet

**Durée estimée** : 2-3 heures  
**Objectif** : Intégrer toutes les compétences  
**Difficultés** : Difficile

### Mission

Créer une application web Python simple avec :

1. **Gestion utilisateurs** (TP 3)
   ```bash
   # Créer utilisateur "webapp"
   sudo adduser webapp
   ```

2. **Git** (TP 5-6)
   ```bash
   git init
   git commit avec messages clairs
   ```

3. **Application Python** (TP 5)
   ```python
   # Flask app avec 2 routes
   from flask import Flask
   app = Flask(__name__)
   
   @app.route('/')
   def home():
       return 'Home'
   
   @app.route('/api')
   def api():
       return {'status': 'ok'}
   ```

4. **Sauvegarde** (TP 8)
   ```bash
   # Script backup pour le projet
   ```

5. **Docker** (TP 9)
   ```dockerfile
   # Dockerfile pour l'app
   ```

6. **SSH** (TP 7)
   ```bash
   # Clé SSH configurée
   ```

7. **Logs** (TP 4)
   ```bash
   # Logs d'application
   ```

### Livrables attendus

- ✅ Dépôt Git avec historique propre
- ✅ Application fonctionnelle
- ✅ Documentation README.md
- ✅ Script de sauvegarde
- ✅ Image Docker
- ✅ Utilisateur app configuré
- ✅ Logs et monitoring

---

## Résumé des TPs

| TP | Thème | Durée | Difficulté |
|----|-------|-------|-----------|
| 1 | Clé USB Ventoy | 20 min | Facile |
| 2 | Installation VM | 45 min | Facile |
| 3 | Utilisateurs | 20 min | Moyen |
| 4 | Maintenance | 15 min | Facile |
| 5 | Git + VS Code | 25 min | Moyen |
| 6 | Collaboration | 30 min | Moyen |
| 7 | SSH | 25 min | Moyen-Difficile |
| 8 | Sauvegarde | 30 min | Moyen |
| 9 | Docker | 30 min | Moyen |
| 10 | Projet complet | 2-3 h | Difficile |

**Total estimé** : 6-7 heures de pratique  
**Niveau final** : Intermédiaire - capable de gérer un système Linux simple

---

## Conseils pour la réussite

✅ Refaites les TPs plusieurs fois  
✅ Modifiez les exemples pour les adapter  
✅ N'hésitez pas à "casser" pour apprendre  
✅ Utilisez `man commande` pour approfondir  
✅ Testez des variantes  
✅ Documentez ce que vous apprenez  

**Félicitations pour cette formation Linux ! 🎉**

