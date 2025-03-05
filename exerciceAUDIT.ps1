<#
==========================================================================
Description : Audit graphique avec exécution des scripts en arrière-plan et messages de confirmation
Auteur      : FRTDev
Date        : 05/03/2025
Version     : 1.4
==========================================================================
#>

# Charger les assemblies nécessaires
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Définir les chemins des scripts et des résultats
$scriptPath = "C:\Users\Administrateur\Desktop\script\contextecubsituation10"
$resultPath = Join-Path $scriptPath "Resultats"

# Création du formulaire principal avec une taille prédéfinie
$form = New-Object System.Windows.Forms.Form
$form.Text = "Audit Graphique"
$form.Size = New-Object System.Drawing.Size(600,450)

# Création de la barre de menu
$menuStrip = New-Object System.Windows.Forms.MenuStrip

# Onglet Fichier avec uniquement le bouton Quitter
$fichierMenu = New-Object System.Windows.Forms.ToolStripMenuItem "Fichier"
$quitterItem = New-Object System.Windows.Forms.ToolStripMenuItem "Quitter"
$quitterItem.Add_Click({ $form.Close() })
$fichierMenu.DropDownItems.Add($quitterItem)

# Menu Audit : parcourir les fichiers textes du dossier des résultats
$menuAudit = New-Object System.Windows.Forms.ToolStripMenuItem "Menu Audit"
Get-ChildItem -Path $resultPath -Filter "audit*.txt" | ForEach-Object {
    $displayName = $_.Name `
        -replace "auditServices.txt", "Services en cours d'exécution" `
        -replace "auditDHCP.txt", "Liste des plages DHCP" `
        -replace "auditDNS.txt", "Liste des enregistrements DNS" `
        -replace "auditAD.txt", "Liste des utilisateurs de l'AD"
    $currentFilePath = $_.FullName
    $item = New-Object System.Windows.Forms.ToolStripMenuItem $displayName
    $item.Tag = $currentFilePath
    $item.Add_Click({
        param($sender, $eventArgs)
        Start-Process notepad.exe -ArgumentList $sender.Tag
    })
    $menuAudit.DropDownItems.Add($item)
}

# A propos
$aProposMenu = New-Object System.Windows.Forms.ToolStripMenuItem "A propos"
$aProposMenu.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Audit Graphique v1`nCréé par FRTDev le 05/03/2025", "A propos")
})

$menuStrip.Items.Add($fichierMenu)
$menuStrip.Items.Add($menuAudit)
$menuStrip.Items.Add($aProposMenu)
$form.MainMenuStrip = $menuStrip
$form.Controls.Add($menuStrip)

# Création d'un GroupBox pour contenir les boutons
$groupBoxScripts = New-Object System.Windows.Forms.GroupBox
$groupBoxScripts.Location = New-Object System.Drawing.Point(50,70)
$groupBoxScripts.Size = New-Object System.Drawing.Size(500,300)
$groupBoxScripts.Text = "Exécution des Scripts"
$form.Controls.Add($groupBoxScripts)

# Fonction pour exécuter un script et afficher un message de confirmation
function Execute-Script {
    param (
        [string]$scriptName,
        [string]$scriptFile
    )
    Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "-File `"$scriptFile`""
    [System.Windows.Forms.MessageBox]::Show("Le script $scriptName a été exécuté avec succès.", "Confirmation", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

#-----------------------------------------------
# Panel et bouton pour "Script - Services"
$panelServices = New-Object System.Windows.Forms.Panel
$panelServices.Location = New-Object System.Drawing.Point(20,30)
$panelServices.Size = New-Object System.Drawing.Size(200,70)
$panelServices.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

$btnServices = New-Object System.Windows.Forms.Button
$btnServices.Location = New-Object System.Drawing.Point(10,15)
$btnServices.Size = New-Object System.Drawing.Size(180,40)
$btnServices.Text = "Script - Services"
$btnServices.Add_Click({
    $scriptFile = Join-Path $scriptPath "exerciceAUDIT1services.ps1"
    Execute-Script -scriptName "Services" -scriptFile $scriptFile
})
$panelServices.Controls.Add($btnServices)
$groupBoxScripts.Controls.Add($panelServices)

#-----------------------------------------------
# Panel et bouton pour "Script - DHCP"
$panelDHCP = New-Object System.Windows.Forms.Panel
$panelDHCP.Location = New-Object System.Drawing.Point(250,30)
$panelDHCP.Size = New-Object System.Drawing.Size(200,70)
$panelDHCP.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

$btnDHCP = New-Object System.Windows.Forms.Button
$btnDHCP.Location = New-Object System.Drawing.Point(10,15)
$btnDHCP.Size = New-Object System.Drawing.Size(180,40)
$btnDHCP.Text = "Script - DHCP"
$btnDHCP.Add_Click({
    $scriptFile = Join-Path $scriptPath "exerciceAUDIT2dhcp.ps1"
    Execute-Script -scriptName "DHCP" -scriptFile $scriptFile
})
$panelDHCP.Controls.Add($btnDHCP)
$groupBoxScripts.Controls.Add($panelDHCP)

#-----------------------------------------------
# Panel et bouton pour "Script - DNS"
$panelDNS = New-Object System.Windows.Forms.Panel
$panelDNS.Location = New-Object System.Drawing.Point(20,120)
$panelDNS.Size = New-Object System.Drawing.Size(200,70)
$panelDNS.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

$btnDNS = New-Object System.Windows.Forms.Button
$btnDNS.Location = New-Object System.Drawing.Point(10,15)
$btnDNS.Size = New-Object System.Drawing.Size(180,40)
$btnDNS.Text = "Script - DNS"
$btnDNS.Add_Click({
    $scriptFile = Join-Path $scriptPath "exerciceAUDIT3dns.ps1"
    Execute-Script -scriptName "DNS" -scriptFile $scriptFile
})
$panelDNS.Controls.Add($btnDNS)
$groupBoxScripts.Controls.Add($panelDNS)

#-----------------------------------------------
# Panel et bouton pour "Script - AD"
$panelAD = New-Object System.Windows.Forms.Panel
$panelAD.Location = New-Object System.Drawing.Point(250,120)
$panelAD.Size = New-Object System.Drawing.Size(200,70)
$panelAD.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

$btnAD = New-Object System.Windows.Forms.Button
$btnAD.Location = New-Object System.Drawing.Point(10,15)
$btnAD.Size = New-Object System.Drawing.Size(180,40)
$btnAD.Text = "Script - AD"
$btnAD.Add_Click({
    $scriptFile = Join-Path $scriptPath "exerciceAUDIT4ad.ps1"
    Execute-Script -scriptName "AD" -scriptFile $scriptFile
})
$panelAD.Controls.Add($btnAD)
$groupBoxScripts.Controls.Add($panelAD)

#-----------------------------------------------
# Panel et bouton pour "Lancer tous les scripts"
$panelAll = New-Object System.Windows.Forms.Panel
$panelAll.Location = New-Object System.Drawing.Point(20,210)
$panelAll.Size = New-Object System.Drawing.Size(430,70)
$panelAll.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

$btnAll = New-Object System.Windows.Forms.Button
$btnAll.Location = New-Object System.Drawing.Point(10,15)
$btnAll.Size = New-Object System.Drawing.Size(410,40)
$btnAll.Text = "Lancer tous les scripts"
$btnAll.Add_Click({
    $scriptFile1 = Join-Path $scriptPath "exerciceAUDIT1services.ps1"
    $scriptFile2 = Join-Path $scriptPath "exerciceAUDIT2dhcp.ps1"
    $scriptFile3 = Join-Path $scriptPath "exerciceAUDIT3dns.ps1"
    $scriptFile4 = Join-Path $scriptPath "exerciceAUDIT4ad.ps1"
    
    Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "-File `"$scriptFile1`""
    Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "-File `"$scriptFile2`""
    Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "-File `"$scriptFile3`""
    Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "-File `"$scriptFile4`""
    
    [System.Windows.Forms.MessageBox]::Show("Tous les scripts ont été exécutés avec succès.", "Confirmation", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})
$panelAll.Controls.Add($btnAll)
$groupBoxScripts.Controls.Add($panelAll)

# Lancer l'interface graphique
[System.Windows.Forms.Application]::Run($form)
