param (
    [string]$RutaPHP = 'php',
    [switch]$NoIniciarServidor
)

$archivoOrigen = Join-Path $PSScriptRoot 'origen\index.php'
$archivoDestino = Join-Path $PSScriptRoot 'pruebas\index.php'

& $RutaPHP -l $archivoOrigen

if ($LASTEXITCODE -ne 0) {
    Write-Host "Hay un error de sintaxis. No se publicó el cambio."
    exit 1
}
Copy-Item $archivoOrigen $archivoDestino -Force -ErrorAction Stop
Write-Host "Versión publicada en el ambiente de pruebas."

if (-not $NoIniciarServidor) {
    & 'C:\xampp\php\php.exe' -S localhost:8080 -t .\pruebas
}