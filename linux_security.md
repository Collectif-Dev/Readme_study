# Sécurité Linux pour Débutants

## 1. Mises à jour du système

### Mettre à jour le système

#### Ubuntu / Linux Mint / Debian
```bash
sudo apt update                 # Mettre à jour la liste
sudo apt upgrade                # Mettre à jour les logiciels
sudo apt full-upgrade           # Upgrade plus complet
sudo apt autoremove             # Supprimer les dépendances inutiles
```

Ou en une commande :
```bash
sudo apt update && sudo apt upgrade -y
```

#### Fedora
```bash
sudo dnf upgrade --refresh -y
```

### Activer mises à jour automatiques

#### Ubuntu 20.04+
```bash
sudo apt install unattended-upgrades
sudo systemctl enable unattended-upgrades
sudo systemctl start unattended-upgrades
```

Configuration :
```bash
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
# Décommenter les lignes nécessaires
```

### Importance
- ✅ Patchs de sécurité
- ✅ Correctifs de bugs
- ✅ Améliorations performance

---

## 2. Pare-feu (Firewall)

### UFW - Uncomplicated Firewall (Ubuntu)

#### Installer et activer
```bash
sudo apt install ufw
sudo ufw enable
```

#### Vérifier le statut
```bash
sudo ufw status
sudo ufw status verbose         # Détails
```

#### Règles de base
```bash
sudo ufw default deny incoming           # Bloquer par défaut
sudo ufw default allow outgoing          # Autoriser sortant

sudo ufw allow ssh                       # Autoriser SSH (port 22)
sudo ufw allow 22                        # Par port
sudo ufw allow 22/tcp                    # Protocole spécifique
sudo ufw allow 80                        # HTTP
sudo ufw allow 443                       # HTTPS
sudo ufw allow from 192.168.1.0/24       # Réseau local seulement
```

#### Supprimer une règle
```bash
sudo ufw delete allow 80
sudo ufw deny 8080
```

#### Voir les règles
```bash
sudo ufw show added
```

#### Recharger
```bash
sudo ufw reload
```

### Outils système

Pour Fedora/CentOS :
```bash
sudo firewall-cmd --state
sudo firewall-cmd --add-service=ssh
```

---

## 3. Accès SSH sécurisé

### Configuration SSH sécurisée

Éditer `/etc/ssh/sshd_config` :
```bash
sudo nano /etc/ssh/sshd_config
```

**Recommandations** :
```
# Port non standard (optionnel mais utile)
Port 2222

# Désactiver root
PermitRootLogin no

# Authentification par clé (très sécurisé)
PubkeyAuthentication yes
PasswordAuthentication no

# Logs
SyslogFacility AUTH
LogLevel VERBOSE

# Timeouts
ClientAliveInterval 300
ClientAliveCountMax 2
```

Redémarrer :
```bash
sudo systemctl restart ssh
```

### Générer des clés SSH

```bash
ssh-keygen -t ed25519 -C "mon@email.com"
# ou RSA :
ssh-keygen -t rsa -b 4096 -C "mon@email.com"
```

Réponses suggérées :
```
Enter file in which to save the key: /home/arthur/.ssh/id_ed25519
Enter passphrase: [entrer phrase sécurisée]
```

Copier sur serveur :
```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server
```

Maintenant connexion sans mot de passe :
```bash
ssh user@server
```

---

## 4. Permissions fichiers

### Principes de base

```bash
# Voir les permissions
ls -la

# Format : -rwxr-xr-x 1 arthur arthur
# - = fichier (d = dossier)
# rwx = owner (read, write, execute)
# r-x = group
# r-x = other
```

### Permissions sûres

```bash
# Fichiers normaux
chmod 644 fichier.txt            # rw-r--r--

# Scripts exécutables
chmod 755 script.sh              # rwxr-xr-x

# Répertoires
chmod 755 dossier/               # rwxr-xr-x

# Sensibles (configs, clés)
chmod 600 ~/.ssh/id_rsa          # rw-------
chmod 700 ~/.ssh                 # rwx------
```

### Changer propriétaire

```bash
# Après installation d'un logiciel
sudo chown -R arthur:arthur /opt/monapp

# Pour un service
sudo chown -R www-data:www-data /var/www/html
```

---

## 5. Vérification des ports ouverts

### Voir les ports en écoute

```bash
sudo ss -tuln                    # Tous les ports
sudo ss -tuln | grep LISTEN      # Seulement ceux en écoute

# Exemple de résultat :
# LISTEN    tcp    0    0    0.0.0.0:22    0.0.0.0:*
# Port 22 (SSH) ouvert à tous
```

### Voir les connexions actives

```bash
sudo ss -tan                     # Toutes les connexions
ss -tan | grep ESTABLISHED       # Établies
```

### Qui écoute sur un port ?

```bash
sudo lsof -i :22                 # Port 22
sudo lsof -i :8080               # Port 8080
sudo ss -tpln | grep 22          # Avec service
```

---

## 6. Audit et logs

### Voir les logs système

```bash
sudo journalctl -u ssh           # Logs SSH
sudo journalctl -u systemd       # Logs systemd
sudo journalctl -f               # Suivre en direct
```

### Logs d'authentification

```bash
sudo tail -f /var/log/auth.log   # Tentatives connexion
grep "Failed password" /var/log/auth.log   # Tentatives échouées
```

### Voir qui se connecte

```bash
who                              # Utilisateurs en ligne
last                             # Historique des connexions
lastlog                          # Dernière connexion par user
```

### Audit des changements

```bash
# Fichiers modifiés récemment
find /etc -type f -mtime -1      # Modifiés aujourd'hui

# Qui a utilisé sudo ?
sudo grep "sudo:" /var/log/auth.log | tail -20
```

---

## 7. Chiffrement et mots de passe

### Mots de passe forts

**Critères** :
- ✅ Au moins 12 caractères
- ✅ Majuscules et minuscules
- ✅ Chiffres
- ✅ Caractères spéciaux (!@#$%^&*)
- ✅ Pas de mots du dictionnaire
- ✅ Pas d'infos personnelles

### Gestionnaire de mots de passe

```bash
# Bitwarden (gratuit, cloud)
# KeePass (local, très sûr)
# 1Password (payant, pro)
```

### Chiffrer des fichiers

```bash
# Avec GPG
gpg -c fichier.txt              # Chiffrer
gpg fichier.txt.gpg              # Déchiffrer

# Avec zip chiffré
zip -e archive.zip fichier.txt
```

### Chiffrement disque

```bash
# LUKS (Linux)
sudo cryptsetup luksFormat /dev/sdX
sudo cryptsetup luksOpen /dev/sdX mon_disque
sudo mkfs.ext4 /dev/mapper/mon_disque
```

---

## 8. Attaques courantes et prévention

### Brute Force SSH
```bash
# Attaque : tentatives multiples de mot de passe
# Solution : 
# 1. Clés SSH (authentification)
# 2. Port non standard
# 3. Fail2Ban

sudo apt install fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### Virus/Malware
```bash
# Scanner antivirus
sudo apt install clamav
sudo systemctl start clamav-freshclam    # Mettre à jour
clamscan -r /home/                       # Scanner
```

### DDoS
```bash
# Limiter connexions
sudo iptables -A INPUT -p tcp --dport 80 -m limit --limit 5/min -j ACCEPT

# Activer via ufw
sudo ufw limit ssh
sudo ufw limit 80/tcp
```

---

## 9. Sauvegarde

### Sauvegarde locale

```bash
# Tar chiffré
tar czf - /home/arthur | gpg -c > backup.tar.gz.gpg

# Rsync incremental
rsync -av --delete /home/arthur/ /media/usb/backup/

# Avec date
rsync -av /home/arthur/ /backup/arthur_$(date +%Y%m%d)/
```

### Sauvegarde cloud

Outils recommandés :
- **Duplicati** (gratuit, chiffré)
- **Bacula** (pro)
- **Acronis** (payant)

```bash
# Duplicati
sudo apt install duplicati
# Interface web : localhost:8200
```

---

## 10. Surveillance

### Monitoring système

```bash
# Processus
ps aux | grep firefox

# Espace disque
watch -n 5 'df -h'         # Actualiser tous les 5s

# Connexions
watch -n 1 'ss -tan'
```

### Outils graphiques

```bash
# Install
sudo apt install gnome-system-monitor    # GUI simple
sudo apt install iotop                   # I/O disque
sudo apt install nethogs                 # Bande passante
```

### Alertes

```bash
# Disque plein
# Ajouter dans crontab :
0 2 * * * [ $(df / | awk 'NR==2 {print $5}' | cut -d'%' -f1) -gt 90 ] && mail -s "Disque plein" user@example.com
```

---

## 11. Checklist de sécurité

Avant de considérer un système Linux comme sûr :

- ✅ Système à jour (`sudo apt update && upgrade`)
- ✅ Pare-feu activé (`sudo ufw enable`)
- ✅ SSH sécurisé (clés, port, root désactivé)
- ✅ Mots de passe forts
- ✅ Permissions correctes (`chmod`)
- ✅ Utilisateurs sans privilèges
- ✅ Logs surveillés
- ✅ Sauvegarde régulière
- ✅ Antivirus si utile
- ✅ Fail2Ban pour SSH

---

## 12. Ressources

- **Ubuntu Security** : `ubuntu.com/security`
- **Linux Foundation** : `linuxfoundation.org`
- **OWASP** : `owasp.org` (application security)

**Rappel** : La sécurité Linux est bien meilleure que Windows si on respecte les bonnes pratiques !

