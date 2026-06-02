# Résolution des Problèmes Courants sous Linux

## 1. Pas de Wi-Fi / Réseau

### Vérifier l'interface réseau

```bash
ip a                            # Voir toutes les interfaces
# Si pas de interface Wi-Fi → problème driver
```

### Lister le matériel réseau

```bash
lspci | grep -i network        # Cartes réseau PCI
lsusb | grep -i network        # Cartes USB
```

### Redémarrer le réseau

```bash
sudo systemctl restart networking
sudo systemctl restart network-manager
```

### Reconnecter le Wi-Fi

```bash
nmcli dev wifi list             # Voir les réseaux
nmcli dev wifi connect "SSID" password "PASSWORD"
```

### Vérifier DNS

```bash
cat /etc/resolv.conf            # Configuration DNS
nslookup google.com             # Tester la résolution
```

### Solution rapide

```bash
sudo ip link set wlan0 down
sudo ip link set wlan0 up
```

---

## 2. Problème d'écran / Affichage

### Résolution incorrecte

```bash
xrandr                          # Lister les écrans
xrandr --output HDMI1 --mode 1920x1080
```

Pour Ubuntu 22.04+ (Wayland) :

```bash
gsettings list-schemas | grep display
```

### Écran noir / Pas de signal

**Causes possibles** : GPU, drivers, ou GRUB

```bash
# Vérifier BIOS/UEFI → Secure Boot ou GPU
# Depuis le GRUB : appuyer E et ajouter nomodeset
```

### Forcer le GPU intégré

```bash
# Voir les GPU
glxinfo | grep "OpenGL renderer"

# Forcer GPU
export LIBGL_ALWAYS_INDIRECT=1
```

---

## 3. Système lent / Haute utilisation CPU/RAM

### Voir les processus gourmands

```bash
top                             # Voir en direct
htop                            # Plus lisible
ps aux --sort=-%cpu | head      # Processus CPU
ps aux --sort=-%mem | head      # Processus mémoire
```

### Vérifier l'espace disque

```bash
df -h                           # Espace libre
du -sh /home/*                  # Taille des dossiers
du -sh ~/*  | sort -hr          # Triés par taille
```

### Nettoyer l'espace disque

```bash
# Paquets inutilisés
sudo apt autoremove
sudo apt autoclean
sudo apt clean

# Fichiers temporaires
rm -rf ~/.cache/*
sudo rm -rf /tmp/*

# Logs anciens
sudo journalctl --vacuum=500M    # Garder max 500MB
```

### Vérifier la RAM

```bash
free -h                         # Utilisation RAM
vmstat 1 5                       # Statistiques mémoire
```

---

## 4. Problèmes de démarrage / Boot

### Système ne démarre pas

1. **Vérifier le BIOS/UEFI** → Mode UEFI vs Legacy
2. **Vérifier GRUB** → appuyer Shift/Escape au démarrage
3. **Vérifier partition EFI** → peut être corrompue

### GRUB corrompu

```bash
# Depuis un Live USB :
sudo mount /dev/sdaX /mnt       # Partition root
sudo mount /dev/sdaY /mnt/boot/efi    # Partition EFI (si UEFI)
sudo grub-install --root-directory=/mnt /dev/sda
sudo update-grub
```

### Voir les logs de boot

```bash
journalctl -b                   # Logs du dernier boot
journalctl -b -1                # Boot précédent
```

---

## 5. Problèmes d'authentification SSH

### SSH ne se connecte pas

```bash
# Vérifier SSH est démarré
sudo systemctl status ssh

# Vérifier le port (défaut 22)
sudo ss -tuln | grep 22

# Voir les logs
sudo journalctl -u ssh -f

# Vérifier les permissions
ls -la ~/.ssh
# Doit être : drwx------ (700)
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

### Problème de clés SSH

```bash
# Générer une nouvelle clé
ssh-keygen -t ed25519 -C "mon@email.com"
# ou RSA :
ssh-keygen -t rsa -b 4096

# Copier la clé publique
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@host
```

### Erreur "Permission denied (publickey)"

```bash
# Vérifier les permissions serveur
sudo ls -la /home/user/.ssh/authorized_keys
# Doit être : -rw------- (600)
sudo chmod 600 /home/user/.ssh/authorized_keys
```

---

## 6. Problèmes de disque/Stockage

### Disque dur plein

```bash
df -h                           # Voir l'utilisation
du -sh /* | sort -hr            # Gros dossiers
```

### Vérifier intégrité du disque

```bash
sudo smartctl -a /dev/sda       # État SMART (si disponible)
sudo fsck /dev/sdaX             # Check filesystem (hors ligne)
```

### Partition corrompue

```bash
# Depuis Live USB
sudo fsck -n /dev/sdaX          # Check seulement
sudo fsck -y /dev/sdaX          # Corriger
```

---

## 7. Problèmes de logiciels

### Logiciel ne démarre pas

```bash
# Lancer en terminal pour voir l'erreur
firefox                         # Voir messages d'erreur
firefox 2>&1 | tail -20         # Voir les 20 dernières erreurs
```

### Dépendances manquantes

```bash
sudo apt install -f             # Corriger les dépendances
sudo dpkg --configure -a        # Reconfigurer paquets
```

### Logiciel figé

```bash
# Trouver le processus
ps aux | grep firefox

# Tuer gentiment
kill PID

# Forcer
kill -9 PID
```

---

## 8. Problèmes d'imprimante

### Détecter l'imprimante

```bash
lpstat -a                       # Imprimantes disponibles
sudo lpadmin -p -E -v socket://IP:SOCKET -m everywhere    # Ajouter
```

### Problèmes driver

```bash
# Voir les drivers disponibles
lpinfo --list-available-devices
lpinfo --list-available-models
```

---

## 9. Problèmes d'audio/son

### Pas de son

```bash
# Vérifier ALSA
alsamixer                       # Mixer audio (F6 pour sélectionner)
amixer                          # Info mute/volume

# Redémarrer ALSA
sudo systemctl restart alsa-utils

# Vérifier PulseAudio
pactl list short sinks          # Sorties audio
pactl set-default-sink NUM      # Changer sortie
```

### Micro ne marche pas

```bash
# Voir les microphones
pactl list sources

# Vérifier mute
pactl set-source-mute NUM false
```

---

## 10. Erreurs fréquentes et solutions

### "Permission denied"
```bash
# Ajouter droit d'exécution
chmod +x script.sh

# Ou utiliser sudo
sudo script.sh
```

### "Command not found"
```bash
# Installer le logiciel
sudo apt install nom

# Ou vérifier le PATH
echo $PATH
which commande
```

### "Disk space low"
```bash
# Nettoyer
sudo apt autoremove
sudo apt autoclean
sudo apt clean
```

### "Could not connect to socket"
```bash
# Problème D-Bus ou service
sudo systemctl restart dbus
```

### "Permission denied: /dev/..."
```bash
# Ajouter l'utilisateur au groupe
sudo usermod -aG dialout $USER  # Serial
sudo usermod -aG docker $USER   # Docker
# Redémarrer la session
exit
```

---

## 11. Commandes de diagnostic utiles

### Diagnostic complet du système

```bash
# Informations générales
uname -a
lsb_release -a

# Matériel
lscpu
lsblk
lspci
lsusb
free -h

# Système de fichiers
mount | grep -E "^/dev"
df -h

# Réseau
ip a
ip route
ss -tuln

# Services
systemctl list-units --type=service --state=running

# Logs récents
journalctl -n 50 -p err
```

### Test de performance

```bash
# CPU
sysbench cpu run

# Disque
sysbench fileio prepare
sysbench fileio run

# RAM
sysbench memory run
```

---

## 12. Demander de l'aide

### Avant de demander aide

1. **Voir le message d'erreur complet** → `2>&1`
2. **Vérifier les logs** → `journalctl -xe`
3. **Rechercher en ligne** → message exact entre guillemets
4. **Fournir infos** → `uname -a`, `lsb_release -a`

### Commandes à partager

```bash
# Créer un rapport
uname -a && cat /etc/os-release && df -h && free -h > rapport.txt

# Voir les erreurs système
journalctl -p err -n 50 > erreurs.txt
```

### Sites d'aide

- Ubuntu : `ubuntufr.org`
- Linux Général : `askubuntu.com`, `linuxquestions.org`
- Stack Overflow : `stackoverflow.com`

**Astuce** : Copier/coller l'erreur complète dans un moteur de recherche → souvent une solution rapidement.

