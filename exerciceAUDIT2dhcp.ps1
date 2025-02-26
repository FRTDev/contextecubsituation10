<#
==========================================================================
Description : Audit des plages DHCP

Auteur : FRTDev
Date : 26/02/2025

Version : 1
==========================================================================
#>

# Définir le chemin du fichier de sortie
$outputFile = "C:\Users\Administrateur\Desktop\script\contextecubsituation10\Resultats\auditDHCP.txt"

# Obtenir la date actuelle
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Créer le contenu initial du fichier
$content = "Audit des plages DHCP - Lancé le $currentDate`n`n"

# Obtenir toutes les plages DHCP
$scopes = Get-DhcpServerv4Scope

# Vérifier chaque plage
foreach ($scope in $scopes) {
    $status = if ($scope.State -eq "Active") { "Activée" } else { "Désactivée" }
    $content += "Plage $($scope.Name) : $status`n"
    
    # Affichage à l'écran
    if ($status -eq "Activée") {
        Write-Host "Plage $($scope.Name) : $status" -ForegroundColor Green
    } else {
        Write-Host "Plage $($scope.Name) : $status" -ForegroundColor Red
    }
}

# Écrire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "`nL'audit des plages DHCP a été enregistré dans $outputFile"
