# Guide Complet : Installation et Configuration de Tailscale (Client)

> **Niveau** : Débutant | **Dernière mise à jour** : Juin 2026
> 
> Ce guide vous accompagne pas à pas pour installer, configurer et utiliser Tailscale sur toutes les plateformes.

---

## Table des matières

1. [Qu'est-ce que Tailscale ?](#1-quest-ce-que-tailscale-)
2. [Prérequis](#2-prérequis)
3. [Création de votre compte Tailscale](#3-création-de-votre-compte-tailscale)
4. [Installation par plateforme](#4-installation-par-plateforme)
   - [Linux (générique)](#linux-générique)
   - [Ubuntu / Debian](#ubuntu--debian)
   - [Fedora / RHEL / CentOS](#fedora--rhel--centos)
   - [Arch Linux](#arch-linux)
   - [Windows](#windows)
   - [macOS](#macos)
   - [Android & iOS](#android--ios)
5. [Vérification de l'installation](#5-vérification-de-linstallation)
6. [Authentification et connexion](#6-authentification-et-connexion)
7. [Utilisation au quotidien](#7-utilisation-au-quotidien)
8. [Fonctionnalités avancées (facultatif)](#8-fonctionnalités-avancées-facultatif)
9. [Dépannage](#9-dépannage)
10. [Bonnes pratiques de sécurité](#10-bonnes-pratiques-de-sécurité)
11. [Désinstallation](#11-désinstallation)
12. [Ressources utiles](#12-ressources-utiles)

---

## 1. Qu'est-ce que Tailscale ?

**Tailscale** est un VPN (réseau privé virtuel) moderne basé sur le protocole **WireGuard**. Contrairement aux VPN traditionnels complexes à configurer, Tailscale fonctionne "out of the box" et permet de :

- 🔗 Connecter vos appareils comme s'ils étaient sur le même réseau local
- 🏠 Accéder à votre domicile depuis l'extérieur (caméras, NAS, serveur domestique)
- 💼 Travailler à distance en accédant aux ressources de l'entreprise
- 🔒 Chiffrer automatiquement toutes les communications entre vos appareils
- 🌐 Contourner les restrictions réseau sans configuration complexe de pare-feu

**Avantages pour les débutants :**
- Pas besoin d'ouvrir de ports sur votre routeur
- Pas de configuration IP complexe
- Fonctionne derrière les NAT et pare-feu
- Gratuit pour un usage personnel (jusqu'à 20 appareils)

---

## 2. Prérequis

Avant de commencer, assurez-vous d'avoir :

| Prérequis | Détail |
|-----------|--------|
| ✅ Compte Tailscale | Google, Microsoft, GitHub, ou email classique |
| ✅ Connexion Internet | Fonctionnelle sur la machine à configurer |
| ✅ Droits administrateur | Nécessaires pour l'installation |
| ✅ Navigateur web | Pour l'authentification (Chrome, Firefox, Safari, Edge) |

> 💡 **Astuce** : Créez votre compte sur [login.tailscale.com](https://login.tailscale.com) avant d'installer le client.

---

## 3. Création de votre compte Tailscale

### Étape 1 : Inscription
1. Rendez-vous sur [https://login.tailscale.com](https://login.tailscale.com)
2. Cliquez sur **"Sign up"** ou **"S'inscrire"**
3. Choisissez votre méthode de connexion :
   - **Google** (recommandé pour la simplicité)
   - **Microsoft**
   - **GitHub**
   - **Email + mot de passe**

### Étape 2 : Vérification
- Un email de confirmation peut être envoyé (selon la méthode choisie)
- Validez votre adresse email si demandé

### Étape 3 : Console d'administration
- Une fois connecté, vous accédez à la [console admin](https://login.tailscale.com/admin)
- Vous y verrez la liste de vos appareils connectés
- Vous pourrez renommer vos machines et gérer les accès

> 📝 **Note** : Gardez cette page ouverte dans votre navigateur pendant l'installation, vous en aurez besoin pour vérifier que votre appareil apparaît bien.

---

## 4. Installation par plateforme

### 🐧 Linux (générique)

Tailscale fournit un script d'installation universel qui détecte automatiquement votre distribution.

#### Méthode recommandée (script automatique)

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

**Ce que fait ce script :**
- Détecte votre distribution (Ubuntu, Debian, Fedora, Arch, etc.)
- Ajoute le dépôt officiel Tailscale
- Installe le paquet
- Démarre le service

> ⚠️ **Sécurité** : Le script télécharge et exécute du code. Tailscale est un éditeur de confiance, mais pour une installation manuelle plus contrôlée, voir ci-dessous.

#### Vérification de l'installation

```bash
tailscale version
```

**Sortie attendue :**
```text
1.82.0
  tailscale commit: abc123def
  other commit: xyz789abc
  go version: go1.24.0
```

> 📌 Les numéros de version peuvent varier. L'important est de ne pas avoir de message d'erreur.

#### Démarrage du service

```bash
# Activer le démarrage automatique
sudo systemctl enable tailscaled

# Démarrer le service maintenant
sudo systemctl start tailscaled
```

#### Vérifier que le service fonctionne

```bash
sudo systemctl status tailscaled
```

**Sortie attendue :** `Active: active (running)` en vert

---

### 🟠 Ubuntu / Debian

#### Méthode 1 : Script automatique (recommandé)

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

#### Méthode 2 : Installation manuelle (plus de contrôle)

```bash
# 1. Installer les dépendances
sudo apt update
sudo apt install -y curl apt-transport-https

# 2. Ajouter la clé GPG officielle Tailscale
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$(lsb_release -cs).noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

# 3. Ajouter le dépôt Tailscale
echo "deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/tailscale.list

# 4. Mettre à jour et installer
sudo apt update
sudo apt install -y tailscale

# 5. Démarrer le service
sudo systemctl enable --now tailscaled
```

#### Connexion

```bash
sudo tailscale up
```

---

### 🔴 Fedora / RHEL / CentOS / Rocky Linux / AlmaLinux

#### Fedora (versions récentes)

```bash
# Installation via DNF
sudo dnf install -y tailscale

# Démarrage et activation
sudo systemctl enable --now tailscaled

# Connexion
sudo tailscale up
```

#### RHEL / CentOS / Rocky Linux / AlmaLinux

```bash
# Pour RHEL 8/9 et dérivés
sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/rhel/$(rpm -E %rhel)/tailscale.repo
sudo dnf install -y tailscale
sudo systemctl enable --now tailscaled
sudo tailscale up
```

---

### 🅰️ Arch Linux / Manjaro

```bash
# Installation depuis les dépôts officiels Arch
sudo pacman -S tailscale

# Démarrage et activation
sudo systemctl enable --now tailscaled

# Connexion
sudo tailscale up
```

> 📝 **Note Manjaro** : La commande est identique. Manjaro étant basée sur Arch, elle utilise les mêmes paquets.

---

### 🪟 Windows

#### Étape 1 : Téléchargement

1. Rendez-vous sur [https://tailscale.com/download](https://tailscale.com/download)
2. Cliquez sur **"Windows"**
3. Téléchargez le fichier `.exe`

#### Étape 2 : Installation

1. **Double-cliquez** sur le fichier téléchargé
2. Si Windows affiche un avertissement de sécurité, cliquez sur **"Exécuter"** ou **"Plus d'infos" → "Exécuter quand même"**
3. Suivez l'assistant d'installation :
   - Cliquez **"Next"** à chaque étape
   - Acceptez les termes de licence
   - Choisissez le dossier d'installation (laisser par défaut)
   - Cliquez **"Install"**
4. À la fin, cliquez **"Finish"**

#### Étape 3 : Connexion

1. Tailscale se lance automatiquement dans la barre des tâches (icône en bas à droite)
2. Cliquez sur l'icône Tailscale (petite queue de renard 🦊)
3. Cliquez sur **"Log in..."** ou **"Se connecter"**
4. Une fenêtre de navigateur s'ouvre
5. Connectez-vous avec le même compte que sur la console web
6. Autorisez Tailscale à accéder à votre compte

#### Vérification sous Windows

Ouvrez **PowerShell** (clic droit sur le bouton Démarrer → "Windows PowerShell") :

```powershell
# Vérifier le statut
tailscale status

# Voir votre IP Tailscale
tailscale ip

# Tester la connexion vers un autre appareil
ping 100.x.x.x  # Remplacez par l'IP de votre autre appareil
```

> 💡 **Astuce Windows** : Si l'icône Tailscale n'apparaît pas, recherchez "Tailscale" dans le menu Démarrer et lancez-le.

---

### 🍎 macOS

#### Méthode 1 : Homebrew (recommandé pour les utilisateurs avancés)

```bash
# Installer Homebrew si ce n'est pas déjà fait
# (voir https://brew.sh pour les instructions)

# Installer Tailscale
brew install --cask tailscale
```

#### Méthode 2 : Téléchargement officiel (recommandé pour les débutants)

1. Rendez-vous sur [https://tailscale.com/download](https://tailscale.com/download)
2. Cliquez sur **"macOS"**
3. Téléchargez le fichier `.dmg`
4. Ouvrez le fichier téléchargé
5. Glissez-déposez l'icône Tailscale dans le dossier **Applications**

#### Connexion sous macOS

1. Ouvrez **Tailscale** depuis le dossier Applications
2. Cliquez sur l'icône Tailscale dans la barre de menu (en haut de l'écran)
3. Cliquez sur **"Log in..."**
4. Authentifiez-vous avec votre compte
5. Autorisez les extensions réseau si macOS le demande :
   - Allez dans **Préférences Système → Sécurité et confidentialité**
   - Cliquez sur **"Autoriser"** à côté du message concernant Tailscale

> 📝 **Note macOS** : Sur macOS récent (Big Sur et ultérieur), Tailscale utilise les extensions système. Vous devrez peut-être redémarrer après la première autorisation.

---

### 📱 Android & iOS

#### Android

1. Ouvrez le **Google Play Store**
2. Recherchez **"Tailscale"**
3. Installez l'application officielle (éditeur : Tailscale Inc.)
4. Ouvrez l'application
5. Tapez **"Get Started"** ou **"Commencer"**
6. Connectez-vous avec votre compte
7. Autorisez la création du VPN si Android le demande

#### iOS (iPhone / iPad)

1. Ouvrez l'**App Store**
2. Recherchez **"Tailscale"**
3. Installez l'application officielle
4. Ouvrez l'application
5. Tapez **"Get Started"**
6. Connectez-vous avec votre compte
7. Autorisez la configuration VPN dans les **Réglages → Général → VPN** si nécessaire

> 💡 **Astuce mobile** : Une fois connecté, vous pouvez activer/désactiver Tailscale rapidement depuis l'application ou le widget VPN natif du système.

---

## 5. Vérification de l'installation

### Vérifier la version installée

**Linux / macOS :**
```bash
tailscale version
```

**Windows (PowerShell) :**
```powershell
tailscale version
```

### Vérifier le statut du service

**Linux :**
```bash
sudo systemctl status tailscaled
```

**Windows :**
```powershell
# Voir si le service est actif
Get-Service tailscale
```

### Vérifier la connexion au réseau

Sur toutes les plateformes :

```bash
tailscale status
```

**Sortie attendue (exemple) :**
```text
100.64.0.1  mon-serveur      user@example.com  linux   -
100.64.0.2  mon-pc-windows   user@example.com  windows idle, tx 1234 rx 5678
100.64.0.3  mon-iphone       user@example.com  ios     -
```

> ✅ Si vous voyez vos appareils listés, tout fonctionne !

---

## 6. Authentification et connexion

### Connexion initiale

Sur Linux, macOS (Terminal) et Windows (PowerShell) :

```bash
sudo tailscale up
```

**Ce qui se passe :**
1. Un lien d'authentification s'affiche dans le terminal :
   ```text
   To authenticate, visit:

   https://login.tailscale.com/a/xxxxxxxxxxxxxxxx
   ```
2. **Copiez** ce lien (sélectionnez-le, clic droit → copier)
3. **Ouvrez** le lien dans votre navigateur
4. **Connectez-vous** avec votre compte Tailscale
5. **Autorisez** l'appareil à rejoindre votre réseau

### Connexion sans interaction (clé d'authentification)

Pour les serveurs ou déploiements automatisés, vous pouvez utiliser une clé d'authentification pré-générée depuis la console admin :

```bash
sudo tailscale up --authkey tskey-auth-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx
```

> 📝 **Pour obtenir une clé** : Console Admin → Settings → Keys → Auth Keys → Generate auth key

### Voir votre adresse IP Tailscale

```bash
tailscale ip -4
```

**Exemple de sortie :**
```text
100.64.0.5
```

C'est cette adresse IP que vous utiliserez pour communiquer avec cet appareil depuis vos autres appareils Tailscale.

---

## 7. Utilisation au quotidien

### Lister les appareils de votre réseau

```bash
tailscale status
```

### Tester la connectivité avec un autre appareil

```bash
# Méthode 1 : Ping via Tailscale (recommandé)
tailscale ping NOM_DE_LA_MACHINE

# Méthode 2 : Ping classique
ping 100.x.x.x  # Remplacez par l'IP Tailscale

# Méthode 3 : Ping par nom de machine (MagicDNS)
ping NOM_DE_LA_MACHINE
```

### Se connecter en SSH à un serveur

```bash
# Si le serveur s'appelle "mon-serveur" dans Tailscale
ssh utilisateur@mon-serveur

# Ou par IP
ssh utilisateur@100.64.0.1
```

> 💡 **Avantage** : Pas besoin d'ouvrir le port SSH (22) sur votre routeur ! La connexion passe par le tunnel chiffré Tailscale.

### Accéder à un partage de fichiers (SMB/NFS)

```bash
# Linux : monter un partage SMB
sudo mount -t cifs //100.64.0.1/partage /mnt/partage -o username=votre_user

# Windows : accéder à un partage réseau
\\100.64.0.1\partage
```

### Déconnexion temporaire

```bash
# Désactiver Tailscale (reste installé)
tailscale down

# Réactiver
tailscale up
```

### Déconnexion complète (logout)

```bash
# Déconnecter et révoquer l'authentification
tailscale logout
```

> 📝 Après un `logout`, vous devrez vous réauthentifier avec `tailscale up`.

---

## 8. Fonctionnalités avancées (facultatif)

> ⚠️ Ces sections sont optionnelles. Vous pouvez utiliser Tailscale efficacement sans elles.

### MagicDNS (résolution de noms)

Tailscale attribue automatiquement des noms de domaine à vos appareils.

**Activer MagicDNS :**
1. Console Admin → DNS → MagicDNS
2. Activez **"Enable MagicDNS"**
3. Vos appareils sont maintenant accessibles par nom : `mon-serveur`, `mon-pc`, etc.

### Exit Node (faire passer tout le trafic par un appareil)

Utilisez un appareil comme "passerelle" Internet (utile pour contourner les restrictions géographiques).

**Sur l'appareil passerelle (ex: serveur aux USA) :**
```bash
sudo tailscale up --advertise-exit-node
```

**Sur l'appareil client :**
```bash
sudo tailscale up --exit-node=100.x.x.x
```

### Subnet Routes (accéder à un réseau entier)

Si vous avez un réseau local (ex: 192.168.1.0/24) derrière un appareil Tailscale :

```bash
# Sur l'appareil qui a accès au réseau local
sudo tailscale up --advertise-routes=192.168.1.0/24
```

Puis, dans la console admin, approuvez les routes.

### Funnel (exposer un service sur Internet)

Pour rendre un service local accessible publiquement via HTTPS :

```bash
tailscale serve https / http://localhost:3000
```

---

## 9. Dépannage

### Problème : Le service ne démarre pas

**Linux :**
```bash
# Vérifier les logs
sudo journalctl -u tailscaled -n 50

# Redémarrer le service
sudo systemctl restart tailscaled

# Vérifier à nouveau
sudo systemctl status tailscaled
```

**Windows :**
```powershell
# Redémarrer le service
Restart-Service tailscale

# Voir les logs
Get-EventLog -LogName Application -Source Tailscale | Select-Object -Last 20
```

### Problème : Impossible de s'authentifier

1. Vérifiez que vous utilisez le **bon compte** (même email que la console admin)
2. Vérifiez que le lien d'authentification n'a pas **expiré** (valide ~10 minutes)
3. Essayez de **régénérer** le lien :
   ```bash
   sudo tailscale up --force-reauth
   ```

### Problème : L'appareil n'apparaît pas dans la console

1. Vérifiez que le service est actif : `tailscale status`
2. Vérifiez la connexion Internet
3. Vérifiez les logs pour les erreurs
4. Essayez de vous déconnecter/reconnecter :
   ```bash
   tailscale logout
   sudo tailscale up
   ```

### Problème : Ping ne fonctionne pas entre appareils

1. Vérifiez que les deux appareils sont **connectés** (`tailscale status`)
2. Vérifiez que les ACLs ne bloquent pas le trafic (console admin → Access Controls)
3. Essayez `tailscale ping` au lieu de `ping` classique (utilise un protocole différent)
4. Vérifiez le pare-feu local de chaque appareil

### Problème : Lenteur ou déconnexions fréquentes

```bash
# Forcer un nouveau handshake DERP (relai)
tailscale ping --until-direct=false NOM_MACHINE

# Vérifier la qualité de la connexion
tailscale status --json | grep -E "RxBytes|TxBytes|Latency"
```

---

## 10. Bonnes pratiques de sécurité

### 🔐 Authentification multifacteur (MFA)

Activez le MFA sur votre compte Tailscale (via votre fournisseur d'identité : Google, Microsoft, etc.).

### 🏷️ Renommer vos appareils

Dans la console admin, donnez des noms explicites :
- ❌ `ubuntu-s-1vcpu-1gb-fra1-01`
- ✅ `serveur-prod-fra1`
- ✅ `nas-maison`
- ✅ `pc-bureau-marc`

### 🔒 Utiliser les ACLs (Access Control Lists)

Dans la console admin → Access Controls, définissez qui peut communiquer avec qui :

```json
// Exemple : seul le PC de Marc peut accéder au NAS
{
  "acls": [
    {
      "action": "accept",
      "src": ["marc@example.com"],
      "dst": ["nas-maison:22", "nas-maison:445"]
    }
  ]
}
```

### 🔄 Maintenir Tailscale à jour

**Linux :**
```bash
# Ubuntu/Debian
sudo apt update && sudo apt upgrade tailscale

# Fedora
sudo dnf update tailscale

# Arch
sudo pacman -Syu tailscale
```

**Windows** : Tailscale se met à jour automatiquement

**macOS** : `brew upgrade --cask tailscale` ou via l'App Store

### 👁️ Surveiller les appareils enregistrés

- Consultez régulièrement la console admin
- Révoquez les appareils inutilisés (cliquez sur les "..." à côté d'un appareil → "Remove")
- Activez les notifications de nouveaux appareils

### 🔑 Utiliser des clés d'auth éphémères pour les conteneurs/VMs temporaires

Dans la console admin, générez des clés avec **"Ephemeral"** coché pour les appareils temporaires (elles s'auto-révoquent après déconnexion).

---

## 11. Désinstallation

### Linux

**Ubuntu / Debian :**
```bash
sudo apt remove --purge tailscale
sudo apt autoremove
```

**Fedora / RHEL :**
```bash
sudo dnf remove tailscale
```

**Arch Linux :**
```bash
sudo pacman -R tailscale
```

**Nettoyage complet (toutes distributions) :**
```bash
# Arrêter le service
sudo systemctl stop tailscaled

# Supprimer les données de configuration
sudo rm -rf /var/lib/tailscale
sudo rm -rf /etc/default/tailscaled
```

### Windows

1. **Paramètres** → **Applications** → **Applications installées**
2. Cherchez **"Tailscale"**
3. Cliquez sur **"Désinstaller"**
4. Suivez l'assistant de désinstallation

> 📝 **Note** : Vous pouvez aussi utiliser le Panneau de configuration classique → Programmes et fonctionnalités.

### macOS

**Si installé via Homebrew :**
```bash
brew uninstall --cask tailscale
```

**Si installé via .dmg :**
1. Quittez Tailscale (clic droit sur l'icône dans la barre de menu → Quit)
2. Glissez l'application Tailscale depuis Applications vers la Corbeille
3. Videz la Corbeille

**Nettoyage des données restantes :**
```bash
rm -rf ~/Library/Application\ Support/Tailscale
rm -rf ~/Library/Caches/Tailscale
rm -rf ~/Library/Preferences/io.tailscale.ipn.macsys.plist
```

### Android / iOS

1. Appuyez longuement sur l'icône Tailscale
2. Sélectionnez **"Désinstaller"** ou **"Supprimer l'application"**
3. Confirmez

---

## 12. Ressources utiles

| Ressource | Lien | Description |
|-----------|------|-------------|
| 📚 Documentation officielle | [tailscale.com/kb](https://tailscale.com/kb) | Guides complets et techniques |
| ⬇️ Téléchargements | [tailscale.com/download](https://tailscale.com/download) | Installateurs pour toutes les plateformes |
| 🆘 Support | [tailscale.com/contact/support](https://tailscale.com/contact/support) | Contacter le support |
| 💬 Communauté | [reddit.com/r/tailscale](https://reddit.com/r/tailscale) | Forum Reddit communautaire |
| 🐙 GitHub | [github.com/tailscale/tailscale](https://github.com/tailscale/tailscale) | Code source open source |
| 🎓 Blog | [tailscale.com/blog](https://tailscale.com/blog) | Articles et tutoriels |

---

## Glossaire rapide

| Terme | Explication simple |
|-------|-------------------|
| **VPN** | Réseau privé virtuel : connecte des appareils de manière sécurisée comme s'ils étaient sur le même réseau |
| **WireGuard** | Protocole de VPN moderne, rapide et sécurisé, utilisé par Tailscale |
| **NAT** | Mécanisme qui permet à plusieurs appareils de partager une même IP publique (votre routeur fait du NAT) |
| **DERP** | Serveur relai de Tailscale utilisé quand une connexion directe n'est pas possible |
| **MagicDNS** | Système qui donne des noms de domaine automatiques à vos appareils Tailscale |
| **Exit Node** | Appareil qui fait passer tout votre trafic Internet (comme un VPN classique) |
| **Subnet Route** | Permet à un appareil Tailscale d'accéder à un réseau local entier |
| **ACL** | Liste de contrôle d'accès : règles qui définissent qui peut communiquer avec qui |

---

> **Licence** : Ce guide est fourni à titre indicatif. Tailscale est une marque de Tailscale Inc. 
> 
> **Version du guide** : 2.0 - Juin 2026
