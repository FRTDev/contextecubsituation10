<#
==========================================================================
Description : Audit de l'AD

Auteur : FRTDev
Date : 05/03/2025

Version : 1
==========================================================================
#>

# Définir le chemin du fichier de sortie
$outputFile = "C:\Users\Administrateur\Desktop\script\contextecubsituation10\Resultats\auditAD.txt"

# Obtenir la date actuelle
$currentDate = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Créer le contenu initial du fichier
$content = "Audit de l'AD - Lancé le $currentDate`n`n"

# Obtenir tous les utilisateurs de l'AD
$users = Get-ADUser -Filter * -Properties *

# Itérer sur chaque utilisateur
foreach ($user in $users) {
    $content += "Utilisateur : $($user.SamAccountName)`n"
    $content += "  Nom complet : $($user.Name)`n"
    $content += "  Activé : $($user.Enabled)`n"
    $content += "  Dernière connexion : $($user.LastLogonDate)`n"
    $content += "  Date de création : $($user.Created)`n"
    $content += "  Groupes : $((Get-ADPrincipalGroupMembership $user.SamAccountName).Name -join ', ')`n"
    $content += "`n"

    # Affichage à l'écran
    Write-Host "Audit de l'utilisateur : $($user.SamAccountName)" -ForegroundColor Cyan
}

# Écrire le contenu dans le fichier
Set-Content -Path $outputFile -Value $content

Write-Host "`nL'audit de l'AD a été enregistré dans $outputFile"
