# Lancer Setup.cmd et obtenir son processus
$proc = Start-Process -WindowStyle Hidden -FilePath "$PSScriptRoot\Setup.cmd" -ArgumentList "/Ohook" -PassThru

# Charger l'API Windows pour manipuler les fenêtres
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class WinAPI {
    [DllImport("user32.dll")]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
"@

# Attendre que la fenêtre principale soit disponible (max 5 sec)
$timeout = 0
while ($proc.MainWindowHandle -eq 0 -and $timeout -lt 50) {
    Start-Sleep -Milliseconds 100
    $proc.Refresh()
    $timeout++
}

# Si la fenêtre est apparue, la déplacer hors écran
if ($proc.MainWindowHandle -ne 0) {
    [WinAPI]::MoveWindow($proc.MainWindowHandle, -32000, -32000, 0, 0, $true)
}
