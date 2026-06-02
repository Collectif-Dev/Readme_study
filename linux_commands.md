# Commandes Linux Indispensables pour Débutants

## 1. Navigation dans les répertoires

### `pwd` - Print Working Directory
Affiche le répertoire courant.
```bash
$ pwd
/home/arthur/Documents
```

### `ls` - List
Liste les fichiers et dossiers.
```bash
ls                       # Listing simple
ls -l                    # Format détaillé (long)
ls -a                    # Avec fichiers cachés
ls -la                   # Détail + cachés
ls -h                    # Tailles lisibles (1K, 2M, etc)
ls /home/arthur/         # Listing d'un dossier
```

Exemple :
```bash
$ ls -la
drwxr-xr-x 10 arthur arthur 4096 juin   2 20:00 .
drwxr-xr-x  3 root   root   4096 mai   10 15:30 ..
-rw-r--r--  1 arthur arthur 2048 juin   2 19:45 fichier.txt
drwxr-xr-x  2 arthur arthur 4096 juin   1 10:20 Documents
```

### `cd` - Change Directory
Change de répertoire.
```bash
cd /home/arthur/Documents       # Chemin absolu
cd Documents                     # Chemin relatif
cd ~                             # Répertoire home
cd -                             # Répertoire précédent
cd ..                            # Répertoire parent
```

### `tree` - Afficher l'arborescence
```bash
tree                    # Arborescence du dossier courant
tree -L 2              # Profondeur limitée à 2 niveaux
tree -a                # Avec fichiers cachés
```

---

## 2. Gestion des fichiers

### `cp` - Copy
Copier des fichiers.
```bash
cp fichier.txt fichier_copie.txt           # Copier un fichier
cp -r dossier/ dossier_copie/              # Copier récursivement (dossier + contenu)
cp -v fichier.txt /tmp/                    # Verbose (affiche ce qu'il copie)
```

### `mv` - Move
Déplacer ou renommer.
```bash
mv fichier.txt nouveau_nom.txt              # Renommer
mv fichier.txt /home/arthur/Documents/      # Déplacer
mv -i fichier.txt /tmp/                     # Interactif (demande avant de remplacer)
```

### `rm` - Remove
Supprimer.
```bash
rm fichier.txt                  # Supprimer un fichier
rm -r dossier/                  # Supprimer récursivement
rm -f fichier.txt               # Force (sans demander)
rm -i *.txt                     # Interactif
```
**⚠️ Attention** : Pas de corbeille ! `rm` supprime définitivement.

### `mkdir` - Make Directory
Créer des dossiers.
```bash
mkdir nouveau_dossier           # Créer un dossier
mkdir -p a/b/c/d                # Créer l'arborescence complète
```

### `touch`
Créer un fichier vide / modifier la date.
```bash
touch mon_fichier.txt           # Créer un fichier
touch -t 202606021900 fichier   # Modifier la date
```

### `cat` - Concatenate
Afficher le contenu d'un fichier.
```bash
cat fichier.txt                 # Afficher le contenu complet
cat fichier1.txt fichier2.txt   # Concaténer 2 fichiers
cat << EOF > fichier.txt        # Créer un fichier multi-ligne
Mon texte
Sur plusieurs
Lignes
EOF
```

### `head` et `tail`
Afficher le début/fin d'un fichier.
```bash
head fichier.txt                # Les 10 premières lignes
head -n 20 fichier.txt          # Les 20 premières lignes
tail fichier.txt                # Les 10 dernières lignes
tail -f fichier.txt             # Suivre en direct (Ctrl+C pour arrêter)
```

---

## 3. Recherche

### `find` - Chercher des fichiers
```bash
find /home -name "*.txt"                  # Fichiers .txt
find /home -type f -name "mon*"           # Fichiers commençant par "mon"
find /home -size +10M                     # Fichiers plus gros que 10MB
find /home -mtime -1                      # Modifiés dans les dernières 24h
find /home -exec rm {} \;                 # Exécuter une commande
```

### `grep` - Chercher du texte
```bash
grep "mot" fichier.txt                    # Chercher "mot" dans le fichier
grep -r "mot" /home/arthur/               # Récursif dans un dossier
grep -i "MOT" fichier.txt                 # Insensible à la casse
grep -n "mot" fichier.txt                 # Avec numéros de ligne
grep -v "mot" fichier.txt                 # Lignes qui NE contiennent PAS "mot"
grep "^mot" fichier.txt                   # Au début de la ligne
grep "mot$" fichier.txt                   # À la fin de la ligne
```

### `locate` - Localiser rapidement
```bash
locate firefox                   # Cherche tous les fichiers contenant "firefox"
updatedb                         # Mettre à jour la base de données
```

---

## 4. Permissions

### `chmod` - Change Mode
Modifier les permissions.
```bash
chmod 755 fichier.sh            # rwxr-xr-x
chmod 644 fichier.txt           # rw-r--r--
chmod +x script.sh              # Ajouter l'exécution
chmod -x script.sh              # Enlever l'exécution
chmod +r fichier.txt            # Ajouter la lecture
chmod -w fichier.txt            # Enlever l'écriture
```

**Notation octal** :
- 4 = read (r)
- 2 = write (w)
- 1 = execute (x)

```
chmod 755 = rwxr-xr-x
           = 7(4+2+1) 5(4+0+1) 5(4+0+1)
           = owner(rwx) group(r-x) other(r-x)
```

### `chown` - Change Owner
Modifier le propriétaire.
```bash
sudo chown arthur fichier.txt              # Changer le propriétaire
sudo chown arthur:arthur fichier.txt       # Changer propriétaire:groupe
sudo chown -R arthur dossier/              # Récursif
```

---

## 5. Réseau

### `ping` - Tester la connectivité
```bash
ping google.com                 # Teste 4 paquets
ping -c 10 google.com           # 10 paquets
```

### `ip` - Adresse IP et configuration réseau
```bash
ip a                            # Afficher toutes les adresses IP
ip a show eth0                  # Une interface spécifique
ip addr add 192.168.1.100/24 dev eth0    # Ajouter une adresse (administrateur)
```

### `ifconfig` - Configuration interface (obsolète mais encore utilisé)
```bash
ifconfig                        # Toutes les interfaces
ifconfig eth0                   # Interface spécifique
```

### `netstat` - État du réseau (obsolète)
```bash
netstat -tuln                   # Ports en écoute
netstat -tan                    # Connexions actives
```

### `ss` - Socket Statistics (moderne)
```bash
ss -tuln                        # Ports en écoute (TCP/UDP)
ss -tan                         # Connexions actives
ss -tpln                        # Avec noms de processus
```

### `curl` et `wget` - Télécharger
```bash
curl https://example.com        # Afficher le contenu
curl -O https://example.com/fichier.zip    # Télécharger
wget https://example.com/fichier.zip       # Télécharger aussi
```

---

## 6. Système et Ressources

### `top` - Afficher les processus
```bash
top                             # Affichage interactif
top -n 1                        # Un seul rafraîchissement
top -u arthur                   # Processus de arthur
```
Touches :
- `q` : quitter
- `Space` : rafraîchir
- `k` : tuer un processus

### `htop` - top amélioré
```bash
htop                            # Interface colorée (à installer)
```

### `ps` - Process Status
```bash
ps                              # Processus courant
ps aux                          # Tous les processus détail
ps aux | grep firefox           # Chercher firefox
```

### `df` - Disk Free
Espace disque disponible.
```bash
df                              # Tous les disques
df -h                           # Format lisible (GB, MB)
df -h /home                     # Un mount point spécifique
```

### `du` - Disk Usage
Utilisation disque.
```bash
du -sh /home/arthur/            # Taille totale d'un dossier
du -sh /home/arthur/*           # Taille de chaque sous-dossier
du -h --max-depth=1             # Max profondeur
```

### `free` - Mémoire RAM
```bash
free                            # En kilobytes
free -h                         # Format lisible
free -m                         # En megabytes
```

### `uptime` - Temps d'activité
```bash
uptime
# 10:45:23 up 5 days, 3:21, 2 users, load average: 0.12, 0.15, 0.10
```

### `uname` - Informations système
```bash
uname -a                        # Tout
uname -r                        # Version du noyau
uname -s                        # Nom du système
```

### `lscpu` - Processeur
```bash
lscpu                           # Informations CPU
```

### `lsblk` - Disques
```bash
lsblk                           # Disques et partitions
lsblk -f                        # Avec systèmes de fichiers
```

---

## 7. Utilisateurs et Permissions

### `whoami` - Utilisateur courant
```bash
whoami                          # Arthur
```

### `sudo` - Super User Do
```bash
sudo commande                   # Exécuter avec droits admin
sudo -i                         # Devenir administrateur
exit                            # Quitter la session admin
```

### `su` - Switch User
```bash
su arthur                       # Changer d'utilisateur
su -                            # Devenir root
```

---

## 8. Édition de texte

### `nano` - Éditeur simple
```bash
nano fichier.txt                # Ouvrir/créer un fichier
# Touches :
# Ctrl+X : quitter
# Ctrl+O : enregistrer
# Ctrl+W : chercher
```

### `vi` ou `vim` - Éditeur avancé
```bash
vim fichier.txt
# :q! → quitter sans sauver
# :wq → enregistrer et quitter
# i → mode insertion
# Échap → mode normal
```

---

## 9. Compression

### `tar` - Archive
```bash
tar -czf archive.tar.gz dossier/         # Créer (gzip)
tar -xzf archive.tar.gz                  # Extraire (gzip)
tar -cf archive.tar dossier/             # Sans compression
tar -xf archive.tar                      # Extraire
```

### `zip` et `unzip`
```bash
zip -r archive.zip dossier/              # Créer
unzip archive.zip                        # Extraire
unzip -l archive.zip                     # Lister
```

---

## 10. Tâches programmées

### `crontab` - Planifier des tâches
```bash
crontab -e                      # Éditer les tâches
crontab -l                      # Lister
# Format : minute heure jour mois jour_semaine commande
# Exemple : 0 2 * * * /script/backup.sh (tous les jours à 2h)
```

---

## Chaîner les commandes

### Pipe `|` - Passer le résultat
```bash
cat fichier.txt | grep "mot"            # Afficher les lignes contenant "mot"
ls -la | grep "^d"                      # Lister seulement les dossiers
ps aux | grep firefox                   # Chercher firefox dans les processus
```

### Redirection
```bash
cat fichier.txt > sortie.txt            # Écrire dans un fichier
cat fichier.txt >> sortie.txt           # Ajouter à la fin
cat fichier.txt 2>&1                    # Erreurs vers sortie standard
```

---

## Raccourcis utiles

| Touche | Fonction |
|--------|----------|
| `Ctrl+C` | Arrêter la commande |
| `Ctrl+Z` | Mettre en pause |
| `Tab` | Autocomplétion |
| `↑` / `↓` | Historique |
| `Ctrl+A` | Début de ligne |
| `Ctrl+E` | Fin de ligne |
| `Ctrl+U` | Effacer la ligne |
| `Ctrl+R` | Chercher dans l'historique |

---

## Pratique progressif
1. **Jour 1** : `pwd`, `ls`, `cd`, `cat`, `mkdir`
2. **Jour 2** : `cp`, `mv`, `rm`, `touch`, `grep`
3. **Jour 3** : `find`, `chmod`, `sudo`
4. **Jour 4** : `top`, `df`, `du`, `free`
5. **Jour 5** : Combinaisons avec `|` et redirections

**Astuce** : Utiliser `man commande` pour l'aide détaillée. Exemple : `man ls`
