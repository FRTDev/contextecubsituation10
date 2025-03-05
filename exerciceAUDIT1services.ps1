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
    $status = Get-Service -Name $service -ErrorAction SilentlyContinue

    if ($status) {
        $content += "Service $service : $($status.Status)`n"
    } else {
        $content += "Service $service : Non trouv�`n"
    }
}

# �crire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "L'audit des services a �t� enregistr� dans $outputFile"
