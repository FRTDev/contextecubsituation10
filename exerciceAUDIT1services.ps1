<#
==========================================================================
Description : Audit des services

Auteur : FRTDev
Date : 26/02/2025

Version : 1
==========================================================================
#>

# D�finir le chemin du fichier de sortie
$outputFile = "C:\Users\Administrateur\Desktop\script\contextecubsituation10\Resultats\auditServices.txt"

# Obtenir la date actuelle
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Cr�er le contenu initial du fichier
$content = "Audit des services - Lanc� le $currentDate`n`n"

# Liste des services � v�rifier
$services = @("DHCP", "DNS", "ADWS")

# V�rifier chaque service
foreach ($service in $services) {
    $serviceStatus = Get-Service -Name $service
    $status = if ($serviceStatus.Status -eq "Running") { "Activ�" } else { "D�sactiv�" }
    $content += "Service $service : $status`n"

    # Affichage � l'�cran
    if ($status -eq "Activ�") {
        Write-Host "Service $service : $status" -ForegroundColor Green
    } else {
        Write-Host "Service $service : $status" -ForegroundColor Red
    }
}

# �crire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "L'audit des services a �t� enregistr� dans $outputFile"
