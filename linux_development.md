# Développement sous Linux

## 1. Git - Contrôle de version

### Installation

```bash
sudo apt install git -y
git --version                   # Vérifier l'installation
```

### Configuration initiale

```bash
git config --global user.name "Arthur Dupont"
git config --global user.email "arthur@example.com"
git config --global core.editor "nano"
git config --list              # Voir la config
```

### Créer un dépôt local

```bash
mkdir mon_projet
cd mon_projet
git init                        # Initialiser
```

### Workflows de base

```bash
# 1. Créer un fichier
echo "Hello Linux" > main.py

# 2. Voir l'état
git status

# 3. Ajouter (staging)
git add main.py                 # Un fichier
git add .                       # Tout

# 4. Commit
git commit -m "Initial commit : création main.py"

# 5. Voir l'historique
git log
git log --oneline               # Résumé
```

### Cloner un dépôt

```bash
git clone https://github.com/user/project.git
cd project
```

### Branches

```bash
git branch                      # Voir les branches
git branch nouvelle_branche     # Créer
git checkout nouvelle_branche   # Changer de branche
git checkout -b dev             # Créer et changer
git merge dev                   # Fusionner
```

### Push/Pull

```bash
git push origin main            # Envoyer
git pull origin main            # Récupérer
```

---

## 2. VS Code - Éditeur de code

### Installation

```bash
sudo apt install code -y
code                            # Lancer
```

### Essentiels VS Code

**Extensions recommandées** :
- Prettier (formattage)
- ESLint (JavaScript)
- Python (Python)
- GitLens (Git)
- Markdown Preview

**Raccourcis utiles** :
```
Ctrl+` → Terminal intégré
Ctrl+/ → Commenter
Ctrl+Maj+P → Palette commandes
Ctrl+F → Rechercher
Ctrl+H → Remplacer
Ctrl+Maj+F → Rechercher dans les fichiers
```

### Ouvrir un projet

```bash
code .                          # Ouvrir le dossier courant
code fichier.py                 # Ouvrir un fichier
```

---

## 3. Python - Programmation

### Installation

```bash
sudo apt install python3 python3-pip -y
python3 --version              # Vérifier
pip3 --version                 # Pip (gestionnaire paquets)
```

### Créer un script Python

```bash
cat > hello.py << EOF
#!/usr/bin/env python3
print("Hello Linux!")
EOF

python3 hello.py
```

### Environnements virtuels

Isoler les dépendances d'un projet :

```bash
# Créer
python3 -m venv env
# ou
python3 -m virtualenv env

# Activer
source env/bin/activate         # Linux/Mac
env\Scripts\activate            # Windows

# Voir le prompt :
(env) arthur@pc:~$ 

# Installer des paquets
pip install requests django

# Voir les paquets
pip list

# Exporter les dépendances
pip freeze > requirements.txt

# Désactiver
deactivate
```

### Installer des paquets

```bash
pip install flask               # Framework web
pip install requests            # HTTP client
pip install pandas              # Data science
pip install numpy               # Calcul numérique
pip install matplotlib          # Graphiques
pip install jupyter             # Notebooks interactifs
```

### Exemple : Application web avec Flask

```python
# app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello Linux!'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
```

Lancer :
```bash
python3 app.py
# Accéder à http://localhost:5000
```

---

## 4. Node.js / JavaScript

### Installation

```bash
sudo apt install nodejs npm -y
node --version
npm --version

# Ou avec NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
nvm use 18
```

### Créer un projet

```bash
mkdir mon_app
cd mon_app
npm init -y                     # Initialiser
npm install express             # Installer dépendance
```

### Exemple : Serveur avec Express

```javascript
// server.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hello Linux!');
});

app.listen(3000, () => {
    console.log('Serveur sur http://localhost:3000');
});
```

Lancer :
```bash
node server.js
```

---

## 5. Docker - Conteneurs

### Installation

```bash
# Ubuntu 20.04+
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER
# Redémarrer la session
exit
```

### Vérifier l'installation

```bash
docker --version
docker run hello-world          # Test
```

### Commandes de base

```bash
# Images
docker images                   # Voir les images
docker pull ubuntu              # Télécharger
docker rmi image_id             # Supprimer

# Conteneurs
docker run -it ubuntu /bin/bash # Lancer interactif
docker ps                       # Conteneurs en cours
docker ps -a                    # Tous les conteneurs
docker stop container_id        # Arrêter
docker rm container_id          # Supprimer
```

### Dockerfile exemple

```dockerfile
# Dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

Construire et lancer :
```bash
docker build -t mon_app .
docker run -p 5000:5000 mon_app
```

---

## 6. Base de données

### PostgreSQL

```bash
# Installation
sudo apt install postgresql postgresql-contrib -y

# Démarrer
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Accéder
sudo -u postgres psql

# Créer une base
CREATE DATABASE ma_base;
CREATE USER arthur WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE ma_base TO arthur;
\q    # Quitter
```

### MySQL/MariaDB

```bash
# Installation
sudo apt install mysql-server -y

# Sécurisation
sudo mysql_secure_installation

# Accéder
mysql -u root -p
```

### SQLite (simple)

```bash
# Aucune installation
sqlite3 ma_db.db

# Voir les tables
.tables

# Quitter
.quit
```

---

## 7. Compilateurs et outils

### C/C++

```bash
# Installation
sudo apt install build-essential gcc g++ gdb -y

# Compiler
gcc main.c -o main
./main

# Avec optimisations
gcc -O2 -Wall main.c -o main
```

### Java

```bash
sudo apt install default-jdk -y
javac --version

javac HelloWorld.java
java HelloWorld
```

### Go

```bash
sudo apt install golang-go -y
go version

go run main.go
```

### Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

rustc --version
```

---

## 8. Débogage

### GDB (GNU Debugger)

```bash
# Compiler avec info debug
gcc -g main.c -o main

# Débogage
gdb main

# Commandes GDB
run                             # Lancer
break main                      # Point d'arrêt
step                            # Exécuter une ligne
continue                        # Continuer
print variable                  # Voir une variable
backtrace                       # Pile d'appels
quit                            # Quitter
```

### Profiling

```bash
# Voir temps d'exécution
time ./mon_programme

# Profiler CPU
perf record ./mon_programme
perf report
```

---

## 9. Contrôle de version (avancé)

### Workflow professionnel

```bash
# 1. Créer une branche de feature
git checkout -b feature/ma-feature

# 2. Faire des commits réguliers
git add fichier.py
git commit -m "Ajouter fonctionnalité X"

# 3. Push
git push origin feature/ma-feature

# 4. Pull request sur GitHub/GitLab
# (Via interface web)

# 5. Rebase/Merge
git checkout main
git pull
git merge feature/ma-feature

# 6. Push et supprimer branche
git push origin main
git branch -d feature/ma-feature
```

### Ignorer des fichiers

```bash
# .gitignore
cat > .gitignore << EOF
*.pyc
__pycache__/
env/
.vscode/
.env
build/
dist/
*.egg-info/
EOF

git add .gitignore
git commit -m "Ajouter .gitignore"
```

---

## 10. Testing

### Tests Python avec pytest

```bash
pip install pytest

# test_app.py
def test_addition():
    assert 2 + 2 == 4

def test_string():
    assert "hello".upper() == "HELLO"
```

Lancer :
```bash
pytest test_app.py -v
```

### Tests JavaScript

```bash
npm install --save-dev jest

# package.json
{
  "test": "jest"
}

# test.js
test('2 + 2 = 4', () => {
    expect(2 + 2).toBe(4);
});
```

Lancer :
```bash
npm test
```

---

## Checklist pour bien développer sous Linux

- ✅ Git configuré et maîtrisé
- ✅ Éditeur (VS Code) installé et configuré
- ✅ Python ou Node.js installé
- ✅ Environnements virtuels utilisés
- ✅ Git ignore bien configuré
- ✅ Tests automatisés
- ✅ Logs et monitoring
- ✅ Documentation du code

**Linux est l'OS préféré des développeurs pour sa flexibilité et ses outils !**

