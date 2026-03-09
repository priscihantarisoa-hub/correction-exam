# Guide Git - Projet Correction Exam

## Commandes Git de base

### 1. Initialiser Git (première fois)
```bash
git init
git add .
git commit -m "Premier commit"
git checkout -b develop
```

### 2. Créer un dépôt sur GitHub
1. Aller sur github.com
2. Cliquer "New repository"
3. Nommer "correction-exam"
4. Cliquer "Create repository"

### 3. Connecter et pousser vers GitHub
```bash
git remote add origin https://github.com/votre-username/correction-exam.git
git push -u origin master
git push -u origin develop
```

### 4. Sauvegarder des modifications
```bash
git status                    # voir l'état
git add .                    # sélectionner tous les fichiers
git commit -m "Description"   # sauvegarder
git push origin develop      # envoyer vers GitHub
```

### 5. Créer un Pull Request
1. Aller sur github.com/votre-username/correction-exam
2. Cliquer "Compare & pull request"
3. Base: master, Compare: develop
4. Cliquer "Create pull request"

---

## Définitions

- **Commit** = Sauvegarder les modifications
- **Push** = Envoyer vers GitHub
- **Pull Request** = Proposer ses changements au prof
- **Merge** = Intégrer les changements

---

## Branches

- **master** = version principale
- **develop** = version de travail

---

## Si le prof veut corriger votre travail

1. Vous faites vos modifications
2. Vous committez
3. Vous poussez vers develop
4. Vous créez un Pull Request de develop vers master
5. Le prof review et merge
