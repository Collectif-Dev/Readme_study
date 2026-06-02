# Structure du Système Linux : Hiérarchie des Fichiers

## Vue d'ensemble de l'arborescence
```
/
├── bin                 # Exécutables essentiels
├── boot                # Fichiers de démarrage
├── dev                 # Fichiers de périphériques
├── etc                 # Configuration système
├── home                # Répertoires utilisateurs
├── lib                 # Bibliothèques système
├── media               # Points de montage (USB, CD)
├── mnt                 # Montages temporaires
├── opt                 # Logiciels optionnels
├── proc                # Informations processus
├── root                # Répertoire du super-utilisateur
├── run                 # Données d'exécution
├── srv                 # Données de services
├── sys                 # Informations système
├── tmp                 # Fichiers temporaires
├── usr                 # Programmes et données utilisateur
└── var                 # Données variables
```

---

## Explication détaillée des répertoires importants

### `/` (Root - La racine)
**Le répertoire racine du système.**
- Tous les autres répertoires sont des sous-dossiers de `/`
- Comme `C:\` sous Windows

### `/home`
**Répertoire des utilisateurs.**
```
/home
├── arthur/             # Mon utilisateur
│   ├── Documents/
│   ├── Downloads/
│   ├── Desktop/
│   └── .config/        # Fichiers de configuration personnels
├── marie/              # Autre utilisateur
└── pierre/
```
- Chaque utilisateur a son propre espace
- `.config/` contient les paramètres des applications (commence par `.` = caché)

### `/etc`
**Configuration système.**
```
/etc
├── hostname            # Nom de l'ordinateur
├── passwd              # Liste des utilisateurs
├── shadow              # Mots de passe (chiffrés)
├── fstab               # Montages des disques
├── ssh/                # Configuration SSH
├── apt/                # Configuration APT (Debian/Ubuntu)
└── systemd/            # Configuration des services
```
- Fichiers essentiels pour le fonctionnement du système
- Nécessite des droits administrateur (sudo) pour les modifier

### `/var` (Variable)
**Données qui changent fréquemment.**
```
/var
├── log/                # Journaux système (*.log)
│   ├── syslog
│   ├── auth.log
│   └── kern.log
├── cache/              # Données en cache
├── tmp/                # Fichiers temporaires
└── lib/                # Bases de données de services
```
- Fichiers journaux (logs) → `/var/log/`
- Croissance possible → attention à l'espace disque

### `/boot`
**Fichiers de démarrage.**
```
/boot
├── vmlinuz             # Noyau Linux
├── initrd.img          # Image initiale du disque RAM
└── grub/               # Configuration GRUB
```
- Ne pas supprimer !
- Contient ce qui est nécessaire pour démarrer le système

### `/usr` (Unix System Resources)
**Programmes et ressources utilisateur.**
```
/usr
├── bin/                # Exécutables disponibles pour les utilisateurs
├── lib/                # Bibliothèques
├── share/              # Ressources partagées (icônes, doc)
├── local/              # Logiciels installés localement
│   ├── bin/
│   └── lib/
└── src/                # Code source
```
- Où sont installés la plupart des programmes
- `/usr/local/` → logiciels qu'on installe manuellement

### `/opt` (Optional)
**Logiciels optionnels / tiers.**
- Logiciels propriétaires ou non standards
- Exemple : `/opt/google-chrome/`

### `/root`
**Répertoire personnel du super-utilisateur (root/administrateur).**
- Équivalent à `/home/arthur/` mais pour l'administrateur
- Accès réservé

### `/tmp` (Temporary)
**Fichiers temporaires.**
- Vidé au redémarrage (généralement)
- Accessible en lecture/écriture par tous
- Attention : peuvent être supprimés

### `/dev` (Devices)
**Fichiers de périphériques.**
```
/dev
├── sda                 # Disque dur 1
├── sda1                # Partition 1 du disque 1
├── sdb                 # Disque dur 2
├── null                # Fichier null (/dev/null)
├── zero                # Générer des zéros
└── random              # Nombres aléatoires
```

### `/proc` et `/sys`
**Informations système virtuelles.**
- Pas de vrais fichiers (en RAM)
- `/proc` → informations sur les processus en cours d'exécution
- `/sys` → informations sur les périphériques hardware

---

## Chemins absolus et relatifs

### Chemin absolu
Commence par `/`
```bash
/home/arthur/Documents/mon_fichier.txt
/etc/ssh/sshd_config
```

### Chemin relatif
Relatif au répertoire courant
```bash
# Si je suis dans /home/arthur/
Documents/mon_fichier.txt        # Équivalent à /home/arthur/Documents/mon_fichier.txt
../marie/fichier.txt             # Dossier parent → marie
./Desktop/                        # Dossier courant → Desktop
```

---

## Commandes utiles pour explorer

### Voir le répertoire courant
```bash
pwd
```

### Lister le contenu
```bash
ls /home/arthur/
ls -la                    # Détail + fichiers cachés
```

### Aller à un répertoire
```bash
cd /home/arthur/
cd ~                      # Répertoire home (~)
cd ..                     # Répertoire parent
```

### Voir l'utilisation disque
```bash
du -sh /home/            # Taille d'un dossier
df -h                    # Espace total disque
```

---

## Hiérarchie des permissions
```
/                        → Propriétaire: root
├── home/
│   └── arthur/          → Propriétaire: arthur
├── etc/                 → Propriétaire: root
└── var/log/             → Propriétaire: root
```

**Règle** : Chacun peut modifier son `/home/utilisateur/` librement.

---

## Résumé pour débuter

| Répertoire | Usage | Modifiable ? |
|-----------|-------|-------------|
| `/home/utilisateur/` | Vos fichiers | ✅ Oui |
| `/etc/` | Configuration système | ❌ Non (sudo nécessaire) |
| `/var/log/` | Journaux | ❌ Non (sudo) |
| `/tmp/` | Fichiers temporaires | ✅ Oui |
| `/usr/bin/` | Programmes | ❌ Non |
| `/opt/` | Programmes additionnels | ❌ Non |

**Point clé** : Linux est organisé hiérarchiquement, tout en partant du `/` racine. Comprendre cette structure rend Linux beaucoup moins mystérieux !
