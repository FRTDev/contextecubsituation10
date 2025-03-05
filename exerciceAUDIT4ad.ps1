<#
==========================================================================
Description : Audit de l'AD

Auteur : FRTDev
Date : 05/03/2025

Version : 1
==========================================================================
#>

# D�finir le chemin du fichier de sortie
$outputFile = "C:\Users\Administrateur\Desktop\script\contextecubsituation10\Resultats\auditAD.txt"

# Obtenir la date actuelle
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Cr�er le contenu initial du fichier
$content = "Audit de l'AD - Lanc� le $currentDate`n`n"

# Obtenir tous les utilisateurs de l'AD
$users = Get-ADUser -Filter * -Properties *

# It�rer sur chaque utilisateur
foreach ($user in $users) {
    $content += "Utilisateur : $($user.SamAccountName)`n"
    $content += "  Nom complet : $($user.Name)`n"
    $content += "  Activ� : $($user.Enabled)`n"
    $content += "  Derni�re connexion : $($user.LastLogonDate)`n"
    $content += "  Date de cr�ation : $($user.Created)`n"
    $content += "  Groupes : $((Get-ADPrincipalGroupMembership $user.SamAccountName).Name -join ', ')`n"
    $content += "`n"

    # Affichage � l'�cran
    Write-Host "Audit de l'utilisateur : $($user.SamAccountName)" -ForegroundColor Cyan
}

# �crire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "`nL'audit de l'AD a �t� enregistr� dans $outputFile"
