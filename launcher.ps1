# Lancer Setup.cmd de façon invisible (autant que possible)
$proc = Start-Process -WindowStyle Hidden -FilePath "$PSScriptRoot\Setup.cmd" -ArgumentList "/Ohook" -PassThru

# Attendre brièvement que la fenêtre apparaisse
Start-Sleep -Milliseconds 300

# Charger l'API Windows pour manipuler la fenêtre
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class WinAPI {
    [DllImport("user32.dll")]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
"@

# Chercher la fenêtre de cmd.exe liée au Setup
$cmdWindows = Get-Process cmd | Where-Object { $_.MainWindowTitle -like "*Setup*" }

foreach ($win in $cmdWindows) {
    [WinAPI]::MoveWindow($win.MainWindowHandle, -32000, -32000, 0, 0, $true)
}

