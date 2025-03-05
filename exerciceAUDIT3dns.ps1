<#
==========================================================================
Description : Audit des enregistrements DNS

Auteur : FRTDev
Date : 05/03/2025

Version : 1
==========================================================================
#>

# D�finir le chemin du fichier de sortie
$outputFile = "C:\Users\Administrateur\Desktop\script\contextecubsituation10\Resultats\auditDNS.txt"

# Obtenir la date actuelle
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Cr�er le contenu initial du fichier
$content = "Audit des enregistrements DNS - Lanc� le $currentDate`n`n"

# Obtenir toutes les zones DNS
$dnsZones = Get-DnsServerZone

# It�rer sur chaque zone DNS
foreach ($zone in $dnsZones) {
    # Obtenir tous les enregistrements DNS de type A pour cette zone
    $dnsRecords = Get-DnsServerResourceRecord -ZoneName $zone.ZoneName -RRType A

    # V�rifier si la zone contient des enregistrements de type A
    if ($dnsRecords.Count -gt 0) {
        $content += "Zone : $($zone.ZoneName)`n"
        
        # V�rifier chaque enregistrement DNS
        foreach ($record in $dnsRecords) {
            $content += "  Nom : $($record.HostName), Adresse IP : $($record.RecordData.IPv4Address)`n"
            
            # Affichage � l'�cran
            Write-Host "Zone : $($zone.ZoneName), Nom : $($record.HostName), Adresse IP : $($record.RecordData.IPv4Address)" -ForegroundColor Cyan
        }
        
        $content += "`n"
    }
}

# �crire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "`nL'audit des enregistrements DNS a �t� enregistr� dans $outputFile"
