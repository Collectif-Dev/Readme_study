Voici un **guide d'apprentissage complet** des commandes de base Linux pour un junior. Je l'ai organisé par thèmes pour un apprentissage progressif.

---

# 📘 GUIDE LINUX POUR JUNIOR - TOUTES LES COMMANDES DE BASE

## Comment utiliser ce guide

- Chaque commande a un **exemple concret**
- Les `[crochets]` indiquent ce que tu dois remplacer
- Les `#` sont des commentaires explicatifs

---

## 1. COMMANDES DE NAVIGATION (se déplacer dans l'arborescence)

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `pwd` | `pwd` | Affiche où tu es (dossier actuel) |
| `ls` | `ls` | Liste les fichiers/dossiers |
| `ls -la` | `ls -la` | Liste TOUT (cachés inclus) avec détails |
| `cd [dossier]` | `cd Documents/` | Se déplacer dans un dossier |
| `cd ..` | `cd ..` | Revenir au dossier parent |
| `cd ~` | `cd ~` | Aller dans ton dossier personnel |
| `cd /` | `cd /` | Aller à la racine du système |
| `cd -` | `cd -` | Revenir au dossier précédent |

**Exemple concret :**
```bash
pwd                    # /home/moi
ls                     # Documents  Musique  Bureau
cd Documents/          # Je vais dans Documents
pwd                    # /home/moi/Documents
cd ..                  # Je reviens en arrière
pwd                    # /home/moi
```

---

## 2. COMMANDES POUR MANIPULER LES DOSSIERS

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `mkdir [nom]` | `mkdir projets` | Créer un dossier |
| `mkdir -p [chemin]` | `mkdir -p a/b/c` | Créer toute l'arborescence |
| `rmdir [dossier]` | `rmdir vide/` | Supprimer un dossier **VIDE** |
| `rm -r [dossier]` | `rm -r projets/` | Supprimer un dossier avec son contenu |
| `cp -r [source] [dest]` | `cp -r docs/ backup/` | Copier un dossier |
| `mv [source] [dest]` | `mv docs/ Archives/` | Déplacer ou renommer un dossier |

**Exemple concret :**
```bash
mkdir mon_projet                 # Crée le dossier
mkdir -p mon_projet/src/utils    # Crée sous-dossiers
cp -r mon_projet/ mon_projet_backup/  # Copie complète
rm -r mon_projet_backup/         # Supprime dossier + contenu
```

---

## 3. COMMANDES POUR MANIPULER LES FICHIERS

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `touch [fichier]` | `touch notes.txt` | Créer un fichier vide |
| `cp [source] [dest]` | `cp notes.txt backup.txt` | Copier un fichier |
| `mv [source] [dest]` | `mv notes.txt vieux_notes.txt` | Renommer un fichier |
| `rm [fichier]` | `rm notes.txt` | Supprimer un fichier |
| `rm -i [fichier]` | `rm -i notes.txt` | Supprimer avec confirmation |
| `file [fichier]` | `file image.jpg` | Afficher le type de fichier |

**Exemple concret :**
```bash
touch todo.txt                    # Crée le fichier
echo "Acheter du pain" > todo.txt # Met du texte dedans
cp todo.txt todo_backup.txt       # Copie de sécurité
rm todo_backup.txt                # Supprime la copie
```

---

## 4. COMMANDES POUR LIRE DES FICHIERS

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `cat [fichier]` | `cat notes.txt` | Afficher tout le fichier |
| `less [fichier]` | `less notes.txt` | Lire page par page (`q` pour quitter) |
| `head [fichier]` | `head notes.txt` | Afficher les 10 premières lignes |
| `head -n 5 [fichier]` | `head -n 5 notes.txt` | Afficher les 5 premières lignes |
| `tail [fichier]` | `tail notes.txt` | Afficher les 10 dernières lignes |
| `tail -f [fichier]` | `tail -f log.txt` | Suivre le fichier en temps réel |
| `wc [fichier]` | `wc notes.txt` | Compter lignes/mots/caractères |

**Exemple concret :**
```bash
cat /etc/passwd        # Affiche le fichier
head -n 3 /etc/passwd  # Seulement 3 premières lignes
wc -l notes.txt        # Compter les lignes du fichier
```

---

## 5. COMMANDES POUR ÉDITER DES FICHIERS

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `nano [fichier]` | `nano notes.txt` | Éditeur simple (RECOMMANDÉ débutant) |
| `vim [fichier]` | `vim notes.txt` | Éditeur avancé |
| `echo [texte] > [fichier]` | `echo "Bonjour" > test.txt` | Écrire (écrase le fichier) |
| `echo [texte] >> [fichier]` | `echo "Ajout" >> test.txt` | Ajouter à la fin |

**Pour sortir de nano :** `Ctrl + X` → `O` (oui) → `Entrée`

---

## 6. COMMANDES POUR CHERCHER

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `grep [mot] [fichier]` | `grep "erreur" log.txt` | Chercher un mot dans un fichier |
| `grep -r [mot] [dossier]` | `grep -r "TODO" .` | Chercher dans TOUS les fichiers |
| `grep -i [mot] [fichier]` | `grep -i "bonjour" test.txt` | Ignorer majuscules/minuscules |
| `grep -v [mot] [fichier]` | `grep -v "^#" config.txt` | Exclure le mot (inverse) |
| `find [dossier] -name [nom]` | `find . -name "*.txt"` | Chercher des fichiers par nom |
| `find [dossier] -type f` | `find . -type f` | Chercher seulement les fichiers |
| `find [dossier] -type d` | `find . -type d` | Chercher seulement les dossiers |

**Exemple concret :**
```bash
grep "ERROR" log.txt           # Trouve toutes les erreurs
find ~ -name "*.pdf"           # Cherche tous les PDFs dans ton dossier
grep -r "TODO" --color=always  # Cherche TODO dans tous les fichiers (coloré)
```

---

## 7. COMMANDES POUR LES PERMISSIONS

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `chmod +x [fichier]` | `chmod +x script.sh` | Rendre exécutable |
| `chmod 755 [fichier]` | `chmod 755 script.sh` | Permissions : rwxr-xr-x |
| `chmod 644 [fichier]` | `chmod 644 fichier.txt` | Permissions : rw-r--r-- |
| `chown [user] [fichier]` | `chown moi fichier.txt` | Changer le propriétaire |
| `ls -l [fichier]` | `ls -l script.sh` | Voir les permissions |

**Comprendre les permissions :**
```
-rwxr-xr--
│││││││││
│││└┴┴┴┴┴→ Autres (lecture seule)
││└──────→ Groupe (lecture + exécution)
│└───────→ Propriétaire (lecture + écriture + exécution)
└────────→ Type (- = fichier, d = dossier)

r = read (lire) = 4
w = write (écrire) = 2
x = execute (exécuter) = 1
```

---

## 8. COMMANDES SYSTÈME

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `clear` | `clear` | Nettoyer l'écran (`Ctrl + L` aussi) |
| `history` | `history` | Voir toutes les commandes tapées |
| `man [commande]` | `man ls` | Afficher le manuel d'une commande |
| `which [commande]` | `which python` | Où est installé un programme |
| `echo [texte]` | `echo "Hello"` | Afficher du texte |
| `date` | `date` | Afficher la date et l'heure |
| `whoami` | `whoami` | Afficher ton nom d'utilisateur |
| `hostname` | `hostname` | Afficher le nom de l'ordinateur |
| `uname -a` | `uname -a` | Infos sur le système |

**Exemple concret :**
```bash
clear                    # Nettoie l'écran
history | grep "ssh"    # Cherche toutes les commandes ssh tapées
man cp                  # Lit le manuel de la commande cp
which python3           # /usr/bin/python3
```

---

## 9. COMMANDES POUR LES ARCHIVES (compression)

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `tar -czf [archive.tar.gz] [dossier]` | `tar -czf backup.tar.gz docs/` | Compresser en .tar.gz |
| `tar -xzf [archive.tar.gz]` | `tar -xzf backup.tar.gz` | Décompresser un .tar.gz |
| `tar -cvf [archive.tar] [dossier]` | `tar -cvf docs.tar docs/` | Créer une archive .tar |
| `tar -xvf [archive.tar]` | `tar -xvf docs.tar` | Extraire un .tar |
| `zip [archive.zip] [fichier]` | `zip backup.zip notes.txt` | Compresser en .zip |
| `unzip [archive.zip]` | `unzip backup.zip` | Décompresser un .zip |

**Exemple concret :**
```bash
tar -czf projet.tar.gz mon_projet/   # Compresse tout le dossier
tar -xzf projet.tar.gz               # Décompresse
zip -r backup.zip documents/         # Compresse en zip (récursif)
```

---

## 10. COMMANDES AVEC REDIRECTION (tuyaux |)

| Symbole | Exemple | Ce que ça fait |
|---------|---------|----------------|
| `\|` (pipe) | `ls \| grep ".txt"` | Envoie la sortie d'une commande à une autre |
| `>` | `echo "texte" > fichier` | Redirige vers un fichier (écrase) |
| `>>` | `echo "texte" >> fichier` | Redirige vers un fichier (ajoute) |
| `<` | `sort < fichier.txt` | Prend l'entrée depuis un fichier |
| `2>` | `commande 2> erreurs.txt` | Redirige les erreurs seulement |

**Exemples puissants :**
```bash
ls -la | grep "txt"           # Liste seulement les fichiers .txt
ps aux | grep "python"        # Cherche les processus Python
cat fichier.txt | wc -l       # Compte les lignes
ls > liste.txt                # Sauvegarde la liste des fichiers
commande 2>/dev/null          # Cache les erreurs
```

---

## 11. COMMANDES POUR LES PROCESSUS

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `ps aux` | `ps aux` | Voir tous les processus |
| `ps aux \| grep [nom]` | `ps aux \| grep firefox` | Chercher un processus |
| `top` | `top` | Surveiller les processus en direct (`q` pour quitter) |
| `kill [PID]` | `kill 1234` | Arrêter un processus (par son ID) |
| `kill -9 [PID]` | `kill -9 1234` | Forcer l'arrêt d'un processus |
| `pkill [nom]` | `pkill firefox` | Arrêter par nom |
| `htop` | `htop` | Version améliorée de top (à installer) |

---

## 12. COMMANDES RÉSEAU

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `ping [site]` | `ping google.com` | Tester la connexion (`Ctrl+C` pour arrêter) |
| `curl [url]` | `curl https://api.example.com` | Télécharger le contenu d'une URL |
| `wget [url]` | `wget https://exemple.com/fichier.zip` | Télécharger un fichier |
| `ifconfig` | `ifconfig` | Voir les interfaces réseau (IP, etc.) |
| `ip a` | `ip a` | Version moderne de ifconfig |
| `netstat -tuln` | `netstat -tuln` | Voir les ports ouverts |
| `ssh [user]@[ip]` | `ssh root@192.168.1.10` | Se connecter à un serveur distant |

---

## 13. COMMANDES DE GESTION DES PAQUETS (Ubuntu/Debian)

| Commande | Exemple | Ce que ça fait |
|----------|---------|----------------|
| `sudo apt update` | `sudo apt update` | Met à jour la liste des paquets |
| `sudo apt upgrade` | `sudo apt upgrade` | Installe les mises à jour |
| `sudo apt install [paquet]` | `sudo apt install firefox` | Installer un logiciel |
| `sudo apt remove [paquet]` | `sudo apt remove firefox` | Désinstaller un logiciel |
| `sudo apt search [mot]` | `sudo apt search python` | Chercher un paquet |
| `sudo apt autoremove` | `sudo apt autoremove` | Supprime les paquets inutiles |

---

## 📝 COMMANDES À CONNAÎTRE PAR CŒUR (TOP 20)

Voici les **20 commandes incontournables** que tu dois maîtriser en priorité :

```bash
1. ls          # Lister
2. cd          # Se déplacer
3. pwd         # Où suis-je ?
4. mkdir       # Créer dossier
5. rm          # Supprimer
6. cp          # Copier
7. mv          # Déplacer/renommer
8. touch       # Créer fichier vide
9. cat         # Lire fichier
10. nano       # Éditer fichier
11. grep       # Chercher
12. find       # Trouver fichiers
13. chmod      # Permissions
14. sudo       # Super-utilisateur
15. apt        # Installer logiciels
16. man        # Aide
17. clear      # Nettoyer
18. history    # Historique
19. | (pipe)   # Tuyau
20. >          # Redirection
```

---

## 🎯 EXERCICES PRATIQUES (à faire dans l'ordre)

### Exercice 1 : Navigation
```bash
cd ~
mkdir test_linux
cd test_linux
pwd  # Doit afficher /home/moi/test_linux
```

### Exercice 2 : Création de fichiers
```bash
touch fichier1.txt fichier2.txt
echo "Bonjour Linux" > fichier1.txt
cat fichier1.txt  # Doit afficher "Bonjour Linux"
```

### Exercice 3 : Copie et déplacement
```bash
cp fichier1.txt fichier3.txt
mkdir archives
mv fichier3.txt archives/
ls archives/  # Doit montrer fichier3.txt
```

### Exercice 4 : Recherche
```bash
echo "error: connexion refusée" >> fichier2.txt
grep "error" *.txt  # Doit trouver l'erreur
find . -name "*.txt"  # Liste tous les .txt
```

### Exercice 5 : Redirection
```bash
ls -la > listing.txt
cat listing.txt
ps aux | grep "bash" > processus.txt
```

### Exercice 6 : Permissions
```bash
touch script.sh
echo "echo Hello" > script.sh
chmod +x script.sh
./script.sh  # Doit afficher Hello
```

### Exercice 7 : Nettoyage
```bash
rm *.txt
rm -r archives/
cd ~
rmdir test_linux  # Doit réussir (dossier vide)
```

---

## ⚡ RACCOURCIS CLAVIER INDISPENSABLES

| Raccourci | Utilité |
|-----------|---------|
| `Ctrl + C` | Arrêter une commande en cours |
| `Ctrl + L` | Nettoyer l'écran (comme `clear`) |
| `Ctrl + D` | Fermer le terminal/quitter |
| `Ctrl + A` | Aller au début de la ligne |
| `Ctrl + E` | Aller à la fin de la ligne |
| `Ctrl + U` | Effacer tout ce qui est avant le curseur |
| `Ctrl + K` | Effacer tout ce qui est après le curseur |
| `Ctrl + R` | Rechercher dans l'historique |
| `Tab` | Auto-complétion (indispensable !) |
| `↑` (flèche haut) | Commande précédente |
| `!!` | Répéter la dernière commande |
| `!mot` | Répéter la dernière commande commençant par "mot" |

---

## 📚 OÙ TROUVER DE L'AIDE ?

```bash
man [commande]    # Le manuel officiel
[commande] --help # L'aide rapide
tldr [commande]   # Exemples simples (à installer: sudo apt install tldr)
```

**Sites utiles :**
- `explainshell.com` → Explique n'importe quelle commande
- `tldr.sh` → Version simplifiée du manuel

---

## 🏁 CONCLUSION

**Ne cherche pas à tout mémoriser d'un coup !**

1. Commence par les **20 commandes de base**
2. Fais les **exercices pratiques**
3. Utilise `man` et `--help` quand tu bloques
4. Le pipe `|` et la redirection `>` sont tes meilleurs amis
5. **La pratique > la théorie**

> **Astuce finale** : Quand tu ne sais pas quoi faire, tape `ls` pour voir où tu es, et `cd` pour te déplacer. Le reste viendra avec la pratique !

Bon apprentissage ! 🐧
