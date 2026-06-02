#!/bin/bash

# Script pour automatiser la fusion des fichiers markdown en file_list.txt
# Usage: ./fusion.sh
# Crée aussi un fichier de logs (fusion.log) pour tracer chaque exécution

# Récupérer le répertoire courant
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Fichiers source à fusionner (en ordre de présentation)
FILES=("00_TABLE_MATIERES.md" " terminale.md" "git_use.md" "installation_linux.md" "linux_structure.md" "linux_commands.md" "linux_users_services.md" "linux_troubleshooting.md" "linux_security.md" "linux_development.md" "linux_bonnes_pratiques.md" "linux_tp.md")

# Fichier de sortie
OUTPUT_FILE="$PROJECT_ROOT/file_list.txt"
LOG_FILE="$PROJECT_ROOT/fusion.log"

# Timestamp pour les logs
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
DATE_HEADER=$(date '+%A %d %B %Y à %H:%M:%S')

# Vérifier que les fichiers existent
for file in "${FILES[@]}"; do
    if [ ! -f "$PROJECT_ROOT/$file" ]; then
        echo "⚠️  Erreur: Le fichier '$file' n'existe pas dans $PROJECT_ROOT"
        echo "[$TIMESTAMP] ❌ ERREUR: Fichier manquant - $file" >> "$LOG_FILE"
        exit 1
    fi
done

echo "📝 Fusion en cours..."

# Créer le fichier fusionné avec header avec timestamp
{
    echo "=================================================================================="
    echo "📄 FICHIER GÉNÉRÉ AUTOMATIQUEMENT - Dernière mise à jour: $DATE_HEADER"
    echo "=================================================================================="
    echo ""
    
    # Boucle pour fusionner tous les fichiers
    for i in "${!FILES[@]}"; do
        file="${FILES[$i]}"
        cat "$PROJECT_ROOT/$file"
        
        # Ajouter un séparateur entre les fichiers (sauf après le dernier)
        if [ $i -lt $((${#FILES[@]} - 1)) ]; then
            echo ""
            echo "=================================================================================="
            echo ""
        fi
    done
    
    echo ""
    echo "=================================================================================="
    echo "✅ Fin du fichier fusionné"
    echo "=================================================================================="
} > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    LINE_COUNT=$(wc -l < "$OUTPUT_FILE")
    
    echo "✅ Fusion réussie!"
    echo "📄 Fichier de sortie: $OUTPUT_FILE"
    echo "📊 Taille du fichier: $FILE_SIZE"
    echo "📝 Nombre de lignes: $LINE_COUNT"
    
    # Écrire dans les logs
    echo "[$TIMESTAMP] ✅ Fusion réussie | Taille: $FILE_SIZE | Lignes: $LINE_COUNT | Fichiers: ${#FILES[@]}" >> "$LOG_FILE"
    echo "📋 Logs sauvegardés dans: $LOG_FILE"
else
    echo "❌ Erreur lors de la fusion"
    echo "[$TIMESTAMP] ❌ ERREUR: La fusion a échoué" >> "$LOG_FILE"
    exit 1
fi
