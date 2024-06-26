# Définition des serveurs DNS de Cloudflare
$dnsServersIPv4 = "1.1.1.1", "1.0.0.1"
$dnsServersIPv6 = "2606:4700:4700::1111", "2606:4700:4700::1001"

# Fonction pour configurer les serveurs DNS pour une carte réseau donnée
function Set-DnsServers {
    param (
        [string]$interfaceAlias,
        [string[]]$dnsServersIPv4,
        [string[]]$dnsServersIPv6
    )
    # Configuration des serveurs DNS pour IPv4
    if ($dnsServersIPv4) {
        Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses $dnsServersIPv4
    }
    # Configuration des serveurs DNS pour IPv6
    if ($dnsServersIPv6) {
        Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses $dnsServersIPv6
    }
}

# Demande à l'utilisateur de saisir les noms des interfaces Ethernet et Wi-Fi
$ethernetInterfaces = Read-Host "Entrez les noms des interfaces Ethernet séparés par des virgules (laissez vide si aucune)"
$wifiInterfaces = Read-Host "Entrez les noms des interfaces Wi-Fi séparés par des virgules (laissez vide si aucune)"

# Convertion des entrées utilisateur en tableaux, gérer les cas où les entrées sont vides
$ethernetInterfacesArray = if ($ethernetInterfaces) { $ethernetInterfaces -split "," } else { @() }
$wifiInterfacesArray = if ($wifiInterfaces) { $wifiInterfaces -split "," } else { @() }

# Configuration des serveurs DNS pour les interfaces Ethernet
foreach ($interface in $ethernetInterfacesArray) {
    if ($interface.Trim()) {
        Set-DnsServers -interfaceAlias $interface.Trim() -dnsServersIPv4 $dnsServersIPv4 -dnsServersIPv6 $dnsServersIPv6
    }
}

# Configuration des serveurs DNS pour les interfaces Wi-Fi
foreach ($interface in $wifiInterfacesArray) {
    if ($interface.Trim()) {
        Set-DnsServers -interfaceAlias $interface.Trim() -dnsServersIPv4 $dnsServersIPv4 -dnsServersIPv6 $dnsServersIPv6
    }
}

# Nettoyage du cache DNS
Write-Host "Nettoyage du cache DNS..." -ForegroundColor Yellow
ipconfig /flushdns > $null 2>&1

Write-Host ""
Write-Host "Les serveurs DNS de Cloudflare ont été configurés pour les interfaces spécifiées." -ForegroundColor Green