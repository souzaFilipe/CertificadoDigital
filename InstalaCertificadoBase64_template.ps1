# Importa o modulo necessario para manipulacao de certificados
Import-Module -Name PKI

# ==========================
# = Preencha as informacoes necessarias abaixo =
# ==========================

# Define a string Base64 do certificado (Substitua o texto entre as aspas)
$pfxBase64 = "ColeAquiSuaStringBase64DoCertificado"

# Define a senha do certificado (Substitua o texto entre as aspas)
$pfxPasswordPlainText = "SuaSenhaAqui"

# ==========================
# = Fim das informacoes necessarias =
# ==========================

# Converte a senha para o formato seguro
$pfxPassword = ConvertTo-SecureString -String $pfxPasswordPlainText -Force -AsPlainText

# Decodifica a string Base64 de volta para um array de bytes
$pfxBytes = [System.Convert]::FromBase64String($pfxBase64)

# Cria um objeto de certificado temporario em memoria usando o array de bytes
$certTempPath = [System.IO.Path]::GetTempFileName()

# Escreve o array de bytes no arquivo temporário
[System.IO.File]::WriteAllBytes($certTempPath, $pfxBytes)

# Importa o certificado para o armazenamento de certificados do usuário atual
$cert = Import-PfxCertificate -FilePath $certTempPath -CertStoreLocation Cert:\CurrentUser\My -Password $pfxPassword

# Remove o arquivo temporario importacao
Remove-Item -Path $certTempPath -Force

# Exibe informacoes sobre o certificado importado
Write-Host "Certificado importado com sucesso para o usuario atual. Detalhes do Certificado: `n$cert"