# Installation d'une Distribution Linux : Guide Complet de Préparation, Installation et Configuration

## 1. Prérequis avant l'installation
Avant de commencer, vérifiez :

### Configuration matérielle minimale
ComposantMinimumRecommandéProcesseur64 bits64 bits multicœurRAM4 Go8 Go ou plusStockage25 Go50 à 100 GoClé USB8 Go16 Go
### Sauvegarde obligatoire
Avant toute modification :

- Documents
- Photos
- Vidéos
- Projets professionnels
- Mots de passe
- Favoris du navigateur

**Règle importante :** toujours prévoir une sauvegarde externe avant de toucher aux partitions.

---

# 2. Choisir son environnement de bureau (Desktop Environment)
Beaucoup de débutants confondent **Linux** (le système) avec **l'interface graphique** (l'environnement de bureau).

**Concept clé** : Linux Mint Cinnamon, Linux Mint XFCE et Linux Mint MATE utilisent exactement le même système Linux. Seule l'interface graphique change.

## Tableau comparatif

| Besoin | Recommandation | Caractéristiques |
|--------|----------------|------------------|
| Vient de Windows | **Cinnamon** | Intuitive, ressemble à Windows, fluide, modernes |
| PC ancien / faible | **XFCE** | Léger, rapide, fonctionnel |
| Design moderne | **GNOME** | Élégant, épuré, performant |
| Personnalisation poussée | **KDE Plasma** | Très flexible, lourd, riche |
| Très faibles ressources | **LXQt** | Minimal, ultra-léger |

## Recommandation pour débuter
**Linux Mint Cinnamon** est le meilleur choix car :
- ✅ Interface similaire à Windows
- ✅ Stable et éprouvée
- ✅ Excellent support communautaire
- ✅ Ressources modérées
- ✅ Logiciels pré-installés

---

# 3. Vérification de l'intégrité de l'ISO
**Étape cruciale souvent oubliée !**

### Pourquoi vérifier ?
- Déterminer si l'ISO n'est pas corrompue
- S'assurer qu'elle n'a pas été modifiée ou hackée
- Éviter des problèmes d'installation ou de stabilité

### Sous Windows (PowerShell)
```
Get-FileHash ubuntu.iso -Algorithm SHA256
```
Exemple de résultat :
```
Algorithm       Hash                                                       Path
---------       ----                                                       ----
SHA256          A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R8S9T0U1V2W3X4Y5Z6      C:\Users\...\ubuntu.iso
```

### Sous Linux/Mac
```
sha256sum ubuntu.iso
```

### Vérification
1. Accédez au site officiel (ex: ubuntu.com)
2. Cherchez la **clé SHA256 officielle**
3. Comparez le résultat obtenu
4. ✅ Si identique → l'ISO est valide
5. ❌ Si différent → téléchargez à nouveau

---

# 4. Dual Boot vs Machine Virtuelle
**Question fréquente :** Dois-je installer Linux ou utiliser une machine virtuelle ?

### Tableau comparatif

| Critère | Dual Boot | Machine Virtuelle |
|---------|-----------|-------------------|
| **Performance** | Excellente | Moyenne (partage ressources) |
| **Risque pour Windows** | Oui (partitionnement) | ❌ Non |
| **Facilité d'installation** | Moyenne | ✅ Très facile |
| **Accès matériel** | Complet | Limité |
| **Flexibilité** | Engage l'ordinateur | Changement facile |
| **Pour débuter** | ✅ Recommandé | Alternative sûre |

### Outils de virtualisation
- **VirtualBox** (gratuit, open-source)
- **VMware Workstation Player** (gratuit pour usage personnel)
- **Hyper-V** (Windows Pro+)

### Recommandation
- **Débutant anxieux** → Machine virtuelle avec VirtualBox
- **Débutant confiant** → Dual Boot (meilleur apprentissage)
- **Pour tester** → Machine virtuelle
- **Installation définitive** → Dual Boot

---

# 5. Vérifications et préparation de Windows

## Vérifier le mode de démarrage (UEFI ou Legacy)
Ouvrir PowerShell en administrateur :

```
Get-ComputerInfo | Select BiosFirmwareType
```
Résultat attendu :

```
UEFI
```
Si le résultat indique Legacy ou BIOS, il faudra être particulièrement vigilant lors de l'installation.

---

## Vérifier BitLocker
PowerShell :

```
manage-bde -status
```
Si BitLocker est activé :

```
manage-bde -off C:
```
ou

```
Suspend-BitLocker -MountPoint "C:" -RebootCount 0
```

### Pourquoi ?
BitLocker peut empêcher Linux d'accéder correctement aux partitions et provoquer des demandes de clé de récupération après l'installation.

---

## Désactiver le démarrage rapide (Fast Startup)
PowerShell administrateur :

```
powercfg /h off
```
Ou :

1. Panneau de configuration
2. Options d'alimentation
3. Choisir l'action des boutons d'alimentation
4. Modifier les paramètres actuellement non disponibles
5. Désactiver « Activer le démarrage rapide »

### Pourquoi ?
Le Fast Startup verrouille partiellement les partitions Windows et peut provoquer des erreurs lors du dual boot.

---

## Vérifier les partitions
Lister les disques :

```
Get-Disk
```
Lister les volumes :

```
Get-Volume
```

---

## Libérer de l'espace disque
Ouvrir :

```
diskmgmt.msc
```
Puis :

- clic droit sur C:
- Réduire le volume

Espace recommandé :

- Minimum : 30 Go
- Recommandé : 50 à 100 Go

Laisser l'espace en **non alloué**.

Ne créez pas de nouvelle partition depuis Windows.

---

# 6. Téléchargement de la distribution
Télécharger uniquement depuis les sites officiels :

- Ubuntu
- Linux Mint
- Debian
- Fedora

Choix conseillé :

ProfilDistributionDébutantLinux MintDébutant avancéUbuntuServeurDebianDéveloppeurFedora
---

# 7. Création de la clé USB bootable

## Outils recommandés

- Rufus
- Ventoy
- balenaEtcher

### Ventoy
Avantages :

- Plusieurs ISO sur une seule clé
- Pas besoin de reformater à chaque fois

### Rufus
Avantages :

- Très simple
- Très populaire

---

# 8. Comprendre GPT et MBR

## GPT
Recommandé

Caractéristiques :

- Compatible UEFI
- Plus moderne
- Plus de partitions
- Plus fiable

## MBR
Ancien standard

Caractéristiques :

- Compatible BIOS Legacy
- Limité à 4 partitions principales

### Vérification sous Windows

```
Get-Disk
```
Colonne :

```
Partition Style
GPT
```

---

# 9. Configuration BIOS / UEFI

## Accéder au BIOS
ConstructeurToucheDellF2HPF10LenovoF1 ou F2AsusF2AcerF2MSIDeleteGigabyteDelete
---

## Menu Boot
ConstructeurToucheDellF12HPF9LenovoF12AsusESCAcerF12MSIF11GigabyteF12
---

## Paramètres à vérifier

### USB Boot

```
Enabled
```

### UEFI

```
Enabled
```

### Legacy Boot

```
Disabled
```

### Secure Boot

#### Ubuntu, Fedora, Linux Mint récents
Peut rester activé.

#### En cas de problème

```
Secure Boot = Disabled
```

---

# 10. Démarrage sur la clé USB
Étapes :

1. Éteindre l'ordinateur
2. Insérer la clé USB
3. Démarrer
4. Ouvrir le menu Boot
5. Sélectionner la clé USB

Exemple :

```
UEFI: SanDisk 16GB
```

---

# 11. Mode Live Linux
Avant d'installer :

```
Try Ubuntu
Try Linux Mint
```
ou

```
Live Session
```
Permet de tester :

- Wi-Fi
- Bluetooth
- Son
- Écran
- Pavé tactile

Sans rien modifier sur le disque.

---

# 12. Installation de Linux

## Choix de la langue
Exemple :

```
Français
```

## Clavier

```
Français (AZERTY)
```

## Fuseau horaire

```
Abidjan
```

## Réseau
Connexion Internet recommandée.

---

# 13. Choix du type d'installation

## Linux seul
Tout le disque est effacé.

### Avantage
Système propre.

### Risque
Suppression complète de Windows.

---

## Dual Boot
Windows + Linux

### Avantage
Conserver Windows.

### Recommandé pour débuter.

---

# 14. Comprendre les partitions Linux

## Partition EFI

```
/boot/efi
```
Permet le démarrage.

---

## Partition racine

```
/
```
Contient le système.

Taille recommandée :

```
30 à 50 Go
```

---

## Partition Home

```
/home
```
Contient les données utilisateur.

Optionnelle mais recommandée.

---

## Swap
Utilisée lorsque la RAM est saturée.

Taille recommandée :

- 2 à 8 Go

---

# 15. GRUB : le gestionnaire de démarrage
GRUB permet de choisir :

```
Linux
ou
Windows
```
au démarrage.

Ne jamais supprimer la partition EFI sous peine de rendre le système non démarrable.

---

# 16. Vérifications après installation

## Version du système

```
cat /etc/os-release
```

## Version du noyau

```
uname -r
```

## Informations matérielles

```
lscpu
```

```
lsblk
```

```
free -h
```

```
df -h
```

---

# 17. Mise à jour du système

## Ubuntu / Linux Mint / Debian

```
sudo apt update
sudo apt upgrade -y
```

---

## Fedora

```
sudo dnf upgrade --refresh -y
```

---

# 18. Installation des outils essentiels

## Ubuntu / Debian / Mint

```
sudo apt install git curl wget vim build-essential -y
```

---

## Fedora

```
sudo dnf install git curl wget vim gcc gcc-c++ make -y
```

---

# 19. Installation des pilotes

## Ubuntu
Détection :

```
ubuntu-drivers devices
```
Installation automatique :

```
sudo ubuntu-drivers autoinstall
```
Particulièrement utile pour NVIDIA.

---

# 20. Logiciels recommandés

## Navigation

- Firefox
- Chrome

## Bureautique

- LibreOffice

## Développement

- Git
- VS Code

## Multimédia

- VLC

## Communication

- Discord
- Telegram

---

# 21. Erreurs fréquentes à éviter
❌ Installer sans sauvegarde

❌ Ignorer BitLocker

❌ Utiliser une ISO non officielle

❌ Supprimer la partition EFI

❌ Choisir le mauvais disque

❌ Forcer le partitionnement manuel sans comprendre

❌ Couper l'alimentation pendant l'installation

❌ Oublier les mises à jour après installation

---

# Checklist finale
Avant d'installer Linux :

- Sauvegarde effectuée
- BitLocker vérifié
- Fast Startup désactivé
- ISO officielle téléchargée
- Clé USB créée
- UEFI vérifié
- Secure Boot vérifié
- Espace disque libéré
- Test en mode Live réalisé
- Type d'installation choisi

Si tous les points sont validés, l'installation peut être effectuée dans de bonnes conditions.
