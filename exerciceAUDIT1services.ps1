<#
==========================================================================
Description : Audit des services

Auteur : FRTDev
Date : 26/02/2025

Version : 1
==========================================================================
#>

# Définir le chemin du fichier de sortie
$outputFile = "C:\Users\Administrateur\Desktop\script\contextecubsituation10\Resultats\auditServices.txt"

# Obtenir la date actuelle
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Créer le contenu initial du fichier
$content = "Audit des services - Lancé le $currentDate`n`n"

# Liste des services à vérifier
$services = @("DHCP", "DNS", "ADWS")

# Vérifier chaque service
foreach ($service in $services) {
    $serviceStatus = Get-Service -Name $service
    $status = if ($serviceStatus.Status -eq "Running") { "Activé" } else { "Désactivé" }
    $content += "Service $service : $status`n"

    # Affichage à l'écran
    if ($status -eq "Activé") {
        Write-Host "Service $service : $status" -ForegroundColor Green
    } else {
        Write-Host "Service $service : $status" -ForegroundColor Red
    }
}

# Écrire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "L'audit des services a été enregistré dans $outputFile"
