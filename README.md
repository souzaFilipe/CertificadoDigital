# CertificadoDigital
Script para atualizar certificado digital
Esse repositório contém dois arquivos para instalar certificado digital via powershell. Para que isso seja possível primeiro convertemos o certificado .PFX em base64 com o script 'converteCertificado.ps1' e depois de gerar a string base64 adicionamos ela e a senha no script 'InstalaCertificadoBase64_template.ps1'.
O intuíto é gerar automação de instalação de certificados digitais em ferramentas de gerenciamento remoto como NinjaRMM.
