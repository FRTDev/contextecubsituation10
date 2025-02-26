<#
==========================================================================
Description : Audit des plages DHCP

Auteur : FRTDev
Date : 26/02/2025

Version : 1
==========================================================================
#>

# D�finir le chemin du fichier de sortie
$outputFile = "C:\Users\Administrateur\Desktop\script\contextecubsituation10\Resultats\auditDHCP.txt"

# Obtenir la date actuelle
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Cr�er le contenu initial du fichier
$content = "Audit des plages DHCP - Lanc� le $currentDate`n`n"

# Obtenir toutes les plages DHCP
$scopes = Get-DhcpServerv4Scope

# V�rifier chaque plage
foreach ($scope in $scopes) {
    $status = if ($scope.State -eq "Active") { "Activ�e" } else { "D�sactiv�e" }
    $content += "Plage $($scope.Name) : $status`n"
    
    # Affichage � l'�cran
    if ($status -eq "Activ�e") {
        Write-Host "Plage $($scope.Name) : $status" -ForegroundColor Green
    } else {
        Write-Host "Plage $($scope.Name) : $status" -ForegroundColor Red
    }
}

# �crire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "`nL'audit des plages DHCP a �t� enregistr� dans $outputFile"
