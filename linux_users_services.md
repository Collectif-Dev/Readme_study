# Gestion des Utilisateurs et Services Linux

## 1. Gestion des Utilisateurs

### Créer un utilisateur

#### Méthode simple
```bash
sudo adduser arthur
# Le système demande :
# - Password (mot de passe)
# - Full Name
# - Room Number
# - Work Phone
# - Home Phone
# - Other
```

#### Méthode rapide (sans questions)
```bash
sudo useradd -m -s /bin/bash arthur
# -m : crée le répertoire home
# -s : shell par défaut (/bin/bash)
```

### Définir/changer le mot de passe

```bash
passwd                          # Changer son propre mot de passe
sudo passwd arthur              # Changer pour un autre utilisateur
```

### Ajouter un utilisateur au groupe sudo (administrateur)

```bash
sudo usermod -aG sudo arthur
# -a : ajouter
# -G : groupe secondaire
# sudo : groupe administrateur
```

L'utilisateur peut maintenant utiliser `sudo`.

### Lister les utilisateurs

```bash
cat /etc/passwd                 # Liste de tous les utilisateurs
cat /etc/shadow                 # Mots de passe (cryptés, root seulement)
getent passwd                   # Format lisible
```

### Voir les groupes d'un utilisateur

```bash
groups arthur                   # Groupes de arthur
groups                          # Mes groupes
id                              # Informations complètes (UID, GID)
```

### Supprimer un utilisateur

```bash
sudo userdel arthur             # Supprimer l'utilisateur
sudo userdel -r arthur          # Supprimer avec le répertoire home
```

### Changer le shell par défaut

```bash
sudo usermod -s /bin/zsh arthur
# /bin/bash → Bash
# /bin/zsh → Zsh
# /bin/sh → Shell minimal
```

### Créer un groupe

```bash
sudo groupadd developers        # Créer un groupe
sudo usermod -aG developers arthur    # Ajouter arthur au groupe
newgrp developers               # Changer de groupe (session courante)
```

---

## 2. Gestion des Services

### Qu'est-ce qu'un service ?
Service = programme qui fonctionne en arrière-plan.

Exemples :
- SSH (accès distant)
- Apache/Nginx (serveur web)
- MySQL (base de données)
- Docker (conteneurs)

### Voir l'état d'un service

```bash
sudo systemctl status ssh       # État complet
sudo systemctl is-active ssh    # Juste le statut (active/inactive)
sudo systemctl is-enabled ssh   # Lance-t-il au démarrage ?
```

### Démarrer/Arrêter/Redémarrer un service

```bash
sudo systemctl start ssh        # Démarrer
sudo systemctl stop ssh         # Arrêter
sudo systemctl restart ssh      # Redémarrer (stop + start)
sudo systemctl reload ssh       # Recharger config (sans interruption)
```

### Activer/Désactiver au démarrage

```bash
sudo systemctl enable ssh       # Lance au démarrage
sudo systemctl disable ssh      # Ne lance pas au démarrage
sudo systemctl mask ssh         # Empêche le démarrage même en sudo
sudo systemctl unmask ssh       # Rétablir
```

### Lister tous les services

```bash
systemctl list-units --type=service             # Tous les services
systemctl list-units --type=service --state=running    # En cours
systemctl list-units --type=service --state=failed     # En erreur
```

### Voir les logs d'un service

```bash
sudo journalctl -u ssh                  # Logs du service ssh
sudo journalctl -u ssh -n 50            # 50 dernières lignes
sudo journalctl -u ssh -f               # Suivre en direct
sudo journalctl -u ssh --since "1 hour ago"    # Depuis 1 heure
sudo journalctl -u ssh -p err           # Seulement les erreurs
```

### Redémarrer le système

```bash
sudo reboot                     # Redémarrer
sudo shutdown -h now            # Éteindre maintenant
sudo shutdown -r +30            # Redémarrer dans 30 minutes
sudo shutdown -c                # Annuler un shutdown programmé
```

---

## 3. Démarrage et services essentiels

### Services importants sous Ubuntu/Linux Mint

| Service | Description | Exemple |
|---------|-------------|---------|
| `ssh` | Accès à distance | `sudo systemctl status ssh` |
| `networking` | Réseau | `sudo systemctl status networking` |
| `cron` | Tâches programmées | `sudo systemctl status cron` |
| `docker` | Conteneurs | `sudo systemctl status docker` |
| `apache2`/`nginx` | Serveur web | `sudo systemctl status nginx` |
| `mysql`/`postgresql` | Base de données | `sudo systemctl status mysql` |

### Activer SSH pour accès distant

```bash
sudo systemctl enable ssh       # Au démarrage
sudo systemctl start ssh        # Maintenant
sudo systemctl status ssh       # Vérifier
```

### Ajouter un service personnalisé

Créer un fichier `/etc/systemd/system/monservice.service` :

```ini
[Unit]
Description=Mon Service Personnel
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/monscript.sh
Restart=always
User=arthur

[Install]
WantedBy=multi-user.target
```

Ensuite :
```bash
sudo systemctl daemon-reload           # Recharger
sudo systemctl enable monservice       # Au démarrage
sudo systemctl start monservice        # Démarrer
```

---

## 4. Permissions et propriété

### Voir les permissions

```bash
ls -la | head -10
# drwxr-xr-x 10 arthur arthur 4096 juin   2 20:00 .
#  ^^^^^^^^^^      ^^^^^^  ^^^^^^
#  permissions     owner   group

# d        rwx      r-x      r-x
# type     owner    group    others
```

### Changer le propriétaire/groupe

```bash
sudo chown arthur fichier.txt                   # Propriétaire
sudo chown arthur:developers fichier.txt        # Propriétaire:groupe
sudo chown -R arthur dossier/                   # Récursif
```

---

## 5. Sudo - Super User Do

### Utiliser sudo

```bash
sudo commande                   # Exécuter en administrateur
sudo -l                         # Voir ce qu'on peut faire
sudo -u arthur commande         # Exécuter en tant qu'arthur
sudo -i                         # Devenir root (shell root)
```

### Configurer sudo (sudoers)

**⚠️ Toujours modifier avec `visudo` (pas de risque de casse)**

```bash
sudo visudo                     # Éditer sudoers
```

Exemple d'entrée :
```
arthur ALL=(ALL) NOPASSWD: /usr/bin/apt
# arthur → utilisateur
# ALL → sur tous les hosts
# (ALL) → exécuter comme tous
# NOPASSWD → sans mot de passe
# /usr/bin/apt → commande autorisée
```

---

## 6. Cas d'usage pratique

### Créer 3 utilisateurs pour un atelier

```bash
# Créer les utilisateurs
sudo adduser alice
sudo adduser bob
sudo adduser charlie

# Les ajouter au groupe developers
sudo usermod -aG developers alice
sudo usermod -aG developers bob
sudo usermod -aG developers charlie

# Vérifier
groups alice
```

### Configurer SSH

```bash
# Installer SSH
sudo apt install openssh-server -y

# Vérifier
sudo systemctl status ssh

# Activer au démarrage
sudo systemctl enable ssh

# Voir l'adresse IP
ip a

# Depuis un autre ordi : ssh alice@192.168.1.100
```

### Logs courants à consulter

```bash
# Erreurs système
sudo journalctl -p err

# SSH
sudo journalctl -u ssh

# Authentification
sudo tail /var/log/auth.log

# Système
sudo tail /var/log/syslog
```

---

## Résumé des commandes essentielles

| Tâche | Commande |
|-------|----------|
| Créer utilisateur | `sudo adduser arthur` |
| Changer mot de passe | `passwd` |
| Ajouter à sudo | `sudo usermod -aG sudo arthur` |
| Voir utilisateurs | `cat /etc/passwd` |
| Démarrer service | `sudo systemctl start ssh` |
| Voir logs | `sudo journalctl -u ssh` |
| Activer au démarrage | `sudo systemctl enable ssh` |
| Changer propriétaire | `sudo chown arthur:developers fichier` |
| Voir permissions | `ls -la` |

Ces commandes forment la base de l'administration Linux !
