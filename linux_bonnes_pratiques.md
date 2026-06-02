# Bonnes Pratiques Linux

## 1. Gestion des fichiers et répertoires

### Arborescence propre

```
Projet/
├── docs/                       # Documentation
├── src/                        # Code source
├── tests/                      # Tests
├── config/                     # Configuration
├── data/                       # Données
├── scripts/                    # Scripts utilitaires
├── README.md
├── LICENSE
└── .gitignore
```

### Nommage des fichiers

✅ **Bon** :
- `main.py`
- `config_app.sh`
- `user_database_2024.sql`
- `document_final.pdf`

❌ **Mauvais** :
- `main 2.py` (espace)
- `CONFIG_APP!.sh` (caractères spéciaux)
- `mon doc (1) (2).pdf` (versions)
- `aaaaaaa.txt` (pas descriptif)

### Permissions

```bash
# Fichiers
chmod 644 *.txt
chmod 644 *.sh (si non-exécutable)

# Scripts
chmod 755 *.sh
chmod +x script.py

# Répertoires
chmod 755 dossier/

# Sensibles
chmod 600 ~/.ssh/id_rsa
chmod 700 ~/.ssh
```

---

## 2. Ligne de commande

### Écrire des scripts robustes

```bash
#!/bin/bash

# Set options
set -e                          # Arrêter si erreur
set -u                          # Erreur si variable non définie
set -o pipefail                 # Erreur si pipe échoue
set -x                          # Afficher ce qu'on exécute

# Variables
BACKUP_DIR="/backup"
LOG_FILE="$BACKUP_DIR/backup.log"

# Vérifier répertoire existe
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Exécution
tar czf "$BACKUP_DIR/backup_$(date +%Y%m%d).tar.gz" /home
echo "Backup complété : $(date)" >> "$LOG_FILE"
```

### Conventions de nommage

```bash
# Fichiers exécutables : snake_case
backup_system.sh
check_disk_usage.sh

# Variables : UPPERCASE
DATABASE_PATH="/data/db"
LOG_FILE="app.log"

# Fonctions : lowercase_with_underscores
function backup_files() {
    # code
}

# Constantes : UPPERCASE
readonly APP_VERSION="1.0.0"
readonly MAX_RETRIES=3
```

### Gestion d'erreurs

```bash
# Fonction pour logs
function log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $@" | tee -a "$LOG_FILE"
}

# Gestion erreurs
if ! command -v docker &> /dev/null; then
    log "ERROR: Docker not installed"
    exit 1
fi

# Trap pour cleanup
trap 'log "Script interrupted"; exit 1' INT TERM
trap 'rm -f "$TMP_FILE"' EXIT
```

---

## 3. Documentation

### README.md

```markdown
# Mon Projet Linux

## Description
Courte description du projet.

## Prérequis
- Linux 20.04+
- Python 3.8+
- Docker

## Installation
\`\`\`bash
git clone https://github.com/user/project.git
cd project
sudo apt install requirements
\`\`\`

## Utilisation
\`\`\`bash
python main.py --help
\`\`\`

## Tests
\`\`\`bash
pytest tests/
\`\`\`

## Licence
MIT
```

### Commenter le code

```python
# Bon commentaire
def calculate_checksum(data):
    """
    Calcule la somme de contrôle SHA256 des données.
    
    Args:
        data (bytes): Données à vérifier
        
    Returns:
        str: Hash hexadécimal
    """
    return hashlib.sha256(data).hexdigest()

# Mauvais commentaire
def calc(d):  # calcule truc
    return hashlib.sha256(d).hexdigest()
```

---

## 4. Sauvegarde et récupération

### Stratégie 3-2-1

- **3 copies** : originale + 2 sauvegardes
- **2 supports différents** : disque + cloud
- **1 copie hors site** : cloud ou lieu distinct

### Sauvegarde automatisée

```bash
# Crontab (edit with crontab -e)
# Tous les jours à 2h du matin
0 2 * * * /home/arthur/scripts/daily_backup.sh

# Chaque semaine le dimanche à 3h
0 3 * * 0 /home/arthur/scripts/weekly_backup.sh
```

### Tester la récupération

```bash
# Tester si la sauvegarde marche
tar -tzf backup.tar.gz | head -20

# Extraire fichier spécifique
tar -xzf backup.tar.gz --strip-components=1 fichier.txt
```

---

## 5. Sécurité du code

### Variables d'environnement pour secrets

```bash
# .env (NE PAS committer !)
cat > .env << EOF
DATABASE_PASSWORD=monmotdepasse
API_KEY=clé_secrète
SECRET_JWT=jwt_secret
EOF

# .gitignore
echo ".env" >> .gitignore

# Script : charger les variables
source .env
echo $DATABASE_PASSWORD
```

### Chiffrement de fichiers sensibles

```bash
# Chiffrer
gpg -c fichier_sensible.txt

# Déchiffrer
gpg fichier_sensible.txt.gpg
```

---

## 6. Performance

### Optimisation disque

```bash
# Voir gros fichiers
du -sh * | sort -hr | head -10

# Nettoyer logs
sudo journalctl --vacuum=500M

# Nettoyer cache
sudo apt clean
sudo apt autoclean
```

### Monitoring régulier

```bash
# Script de santé système
#!/bin/bash
echo "=== Santé Système ==="
echo "CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')"
echo "RAM: $(free -h | awk '/^Mem/ {print $3/$2}')"
echo "Disque: $(df -h / | awk 'NR==2 {print $5}')"
echo "Processus: $(ps aux | wc -l)"
```

---

## 7. Maintenance

### Mises à jour régulières

```bash
# Chaque mois
sudo apt update
sudo apt upgrade
sudo apt full-upgrade

# Vérifier noyau
uname -r
```

### Nettoyage régulier

```bash
# Liste des fichiers temporaires
find /tmp -type f -atime +30 -delete

# Journaux anciens
sudo journalctl --vacuum=30d

# Paquets inutilisés
sudo apt autoremove
sudo apt autoclean
```

---

## 8. Collaboration

### Git - Bonnes pratiques

```bash
# Commits atomiques et explicites
git commit -m "Fix: correction bug affichage date"
git commit -m "Feature: ajout pagination table utilisateurs"
git commit -m "Refactor: extraction logic dans utils"

# Messages de commit
# Format : [Type]: Description
# Types : Fix, Feature, Refactor, Test, Docs, Style

# Branches claires
feature/ajout-authentification
bugfix/correction-pagination
refactor/simplify-utils
```

### Code review

Avant de merger :
- ✅ Tests passent
- ✅ Code formaté
- ✅ Documentation à jour
- ✅ Pas de secrets en clair
- ✅ Performance acceptable

---

## 9. Logging

### Logs structurés

```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('app.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)
logger.info("Démarrage application")
logger.warning("Configuration non trouvée")
logger.error("Erreur base de données", exc_info=True)
```

### Rotation des logs

```bash
# Configurer logrotate
cat > /etc/logrotate.d/myapp << EOF
/var/log/myapp/*.log {
    daily
    rotate 7
    compress
    delaycompress
    notifempty
    create 0640 myapp myapp
    sharedscripts
    postrotate
        systemctl reload myapp
    endscript
}
EOF
```

---

## 10. Tests

### Types de tests

```bash
# Tests unitaires (fonction isolée)
pytest tests/unit/test_math.py

# Tests d'intégration (composants ensemble)
pytest tests/integration/test_api.py

# Tests end-to-end (scénario complet)
pytest tests/e2e/test_workflow.py

# Couverture
pytest --cov=src tests/
```

### CI/CD (intégration continue)

GitHub Actions example :
```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Run tests
        run: pytest tests/ -v
```

---

## 11. Checklist de production

Avant de déployer :

- ✅ Code testé et reviewé
- ✅ Secrets en env variables (pas en dur)
- ✅ Logs configurés et monitores
- ✅ Sauvegarde en place
- ✅ Monitoring et alertes
- ✅ Documentation à jour
- ✅ Scripts de backup testés
- ✅ Plan de récupération d'erreurs
- ✅ Permissions correctes
- ✅ HTTPS activé (si web)

---

## 12. Ressources

- **Linux Foundation** : linuxfoundation.org
- **Shellcheck** : shellcheck.net (lint bash)
- **OWASP** : owasp.org (sécurité application)
- **Linux Academy** : linuxacademy.com

**La qualité est une habitude, pas une destination ! Amélioration continue.**

