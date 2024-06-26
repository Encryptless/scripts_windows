# Vérifie si le script est exécuté avec des privilèges administrateur
$ELEVATED = [bool](New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $ELEVATED) {
    Write-Host "Le script doit être exécuté avec des privilèges administrateur. Veuillez relancer le script en tant qu'administrateur."
    pause
    exit
}

# Affiche le menu
function Afficher-Menu {
    Clear-Host
    Write-Host "Script créé par Liam L. - https://github.com/liam-bzh"
    Write-Host
    Write-Host "Menu Chocolatey :"
    Write-Host "1. Installer Chocolatey"
    Write-Host "2. Installer des logiciels via Chocolatey (liste dans le script)"
    Write-Host "3. Mettre à jour les logiciels Chocolatey installés"
    Write-Host "4. Quitter"
}

# Option pour installer Chocolatey
function Installer-Chocolatey {
    Write-Host "Installation de Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Option pour installer les logiciels Chocolatey présents dans le script
function Installer-Logiciels {
    Write-Host "Installation des logiciels Chocolatey présents dans le script..."
    choco install 7zip discord everything googlechrome notion paint.net protonvpn putty sharex tidal veracrypt virtualbox vlc vscode winscp
}

# Option pour mettre à jour les logiciels Chocolatey installés
function MaJ-Logiciels {
    Write-Host "Mise à jour des logiciels Chocolatey installés..."
    choco upgrade all
}

# Boucle du menu
do {
    Afficher-Menu
    $choix = Read-Host "Veuillez choisir une option (1-4)"

    switch ($choix) {
        "1" { Installer-Chocolatey }
        "2" { Installer-Logiciels }
        "3" { MaJ-Logiciels }
        "4" { break }
        default { Write-Host "Choix non valide. Veuillez réessayer." }
    }

    pause # Optionnel: Pour faire une pause avant de réafficher le menu
} while ($choix -ne "4")