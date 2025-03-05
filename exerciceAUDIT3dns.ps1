<#
==========================================================================
Description : Audit des enregistrements DNS

Auteur : FRTDev
Date : 05/03/2025

Version : 1
==========================================================================
#>

# Définir le chemin du fichier de sortie
$outputFile = "C:\Users\Administrateur\Desktop\script\contextecubsituation10\Resultats\auditDNS.txt"

# Obtenir la date actuelle
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Créer le contenu initial du fichier
$content = "Audit des enregistrements DNS - Lancé le $currentDate`n`n"

# Obtenir toutes les zones DNS
$dnsZones = Get-DnsServerZone

# Itérer sur chaque zone DNS
foreach ($zone in $dnsZones) {
    # Obtenir tous les enregistrements DNS de type A pour cette zone
    $dnsRecords = Get-DnsServerResourceRecord -ZoneName $zone.ZoneName -RRType A

    # Vérifier si la zone contient des enregistrements de type A
    if ($dnsRecords.Count -gt 0) {
        $content += "Zone : $($zone.ZoneName)`n"
        
        # Vérifier chaque enregistrement DNS
        foreach ($record in $dnsRecords) {
            $content += "  Nom : $($record.HostName), Adresse IP : $($record.RecordData.IPv4Address)`n"
            
            # Affichage à l'écran
            Write-Host "Zone : $($zone.ZoneName), Nom : $($record.HostName), Adresse IP : $($record.RecordData.IPv4Address)" -ForegroundColor Cyan
        }
        
        $content += "`n"
    }
}

# Écrire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "`nL'audit des enregistrements DNS a été enregistré dans $outputFile"
