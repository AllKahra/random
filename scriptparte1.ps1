# Criando script no PowerShell

# Caminho para o OU de usuários
$ouPathUsuarios = "OU=Usuarios,DC=anna,DC=local"

# Caminho para o OU de grupos
$ouPathGrupos = "OU=Grupos,DC=anna,DC=local"

# Criação de grupos no AD
    # Definindo os grupos a serem criados
$grupos = @(
    @{Nome= 'TI'; descricao= 'Time de TI'},
    @{Nome= 'Comercial'; descricao= 'Time de Comercial'},
    @{Nome= 'Financeiro'; descricao= 'Time de Financeiro'},
    @{Nome= 'Compras'; descricao= 'Time de Compras'},
    @{Nome= 'Producao'; descricao= 'Time de Producao'}
)

# Criação dos usuários no AD
$usuarios = @(
    "Beatrice.Williams", "John.Henry", "Laura.Black", "Philip.Martin", "Victoria.Johnson",
    "Peter.Ross", "Alice.Clark", "Felix.Green", "Camille.White", "Daniel.Brown",
    "Luke.Harris", "Rachel.Adams", "Henry.Scott", "Bianca.Walker", "Julie.Carter",
    "Edward.Stone", "Maria.Hall", "Thomas.Taylor", "Carla.Evans", "Brian.Moore"
)

# Função para gerar senha aleatória
function Generate-RandomPassword {
    $length = 12
    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"
    $password = -join ((1..$length) | ForEach-Object { $chars | Get-Random })
    return $password
}

# Laço para criar e associar usuários
for ($i = 0; $i -lt $usuarios.Count; $i++) {
    $usuario = $usuarios[$i]
    $grupo = $grupos[$i % $grupos.Count].Nome  
    # Escolhe o grupo de forma circular

    # Verifica se o grupo existe, se não, cria o grupo
    $grupoExistente = Get-ADGroup -Filter {Name -eq $grupo} -ErrorAction SilentlyContinue
    if (-not $grupoExistente) {
        New-ADGroup -Name $grupo -Description $grupos[$i % $grupos.Count].descricao
        Write-Output "O Grupo $grupo foi criado com sucesso!" -ForegroundColor Green
    } 
    else {
        Write-Output "O Grupo $grupo já foi criado!" -ForegroundColor Yellow
    }
    # Criação do usuário com senha aleatória e forçando a troca de senha no primeiro login
    $senha = Generate-RandomPassword
    New-ADUser -SamAccountName $usuario 
    -UserPrincipalName "$usuario@dominio.local" 
    -Name $usuario 
    -GivenName $usuario.Split('.')[0] 
    -Surname $usuario.Split('.')[1] 
    -Enabled $true 
    -PasswordNeverExpires $false 
    -AccountPassword (ConvertTo-SecureString -AsPlainText $senha -Force) 
    -ChangePasswordAtLogon $true
    Write-Output "Usuário $usuario criado com senha temporária" -ForegroundColor Green

    # Adiciona o usuário ao grupo
    Add-ADGroupMember -Identity $grupo -Members $usuario

}

# Validação da criação dos usuários e grupos
$gruposCriados = Get-ADGroup -Filter *
$usuariosCriados = Get-ADUser -Filter *

# Exibindo grupos e usuários criados
Write-Output "Grupos Criados: $($gruposCriados.Name)" -ForegroundColor Cyan
$gruposCriados | ForEach-Object { Write-Output $_.Name }
Write-Output "Usuários Criados: $($usuariosCriados.SamAccountName)" -ForegroundColor Cyan
$usuariosCriados | ForEach-Object { Write-Output $_.SamAccountName }

# Exportando a lista de grupos e usuários criados
$gruposCriados | Select-Object Name | Export-Csv -Path "C:\caminho\grupos_criados.csv" -NoTypeInformation
$usuariosCriados | Select-Object SamAccountName, UserPrincipalName | Export-Csv -Path "C:\caminho\usuarios_criados.csv" -NoTypeInformation

Write-Output "Exportação dos grupos e usuários criados concluída."

# Verificando se o usuário foi adicionado corretamente ao grupo
foreach ($grupo in $grupos) {
    $membros = Get-ADGroupMember -Identity $grupo.Nome
    Write-Output "Membros do grupo $($grupo.Nome):"
    $membros | ForEach-Object { Write-Output $_.SamAccountName }
}

