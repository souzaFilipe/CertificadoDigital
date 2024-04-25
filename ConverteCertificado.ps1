[Byte[]]$pfxContent = Get-Content -Path '<diretorioDoCertificadoPFX>' -Encoding Byte
[String]$pfxBase64 = [System.Convert]::ToBase64String($pfxContent)
$pfxBase64 | Out-File '<DiretorioDeSaidaDoCertificadoConvertido>'