#Criando um Script no PowerShell

#Criação de Grupos
$grupo@(
    @{Nome= 'TI' descricao= 'Time de TI'}
    @{Nome= 'Comercial' descricao= 'Time de Comercial'}
    @{Nome= 'Financeiro' descricao= 'Time de Financeiro'}
    @{Nome= 'Compras' descricao= 'Time de Compras'}
    @{Nome= 'Producao' descricao= 'Time de Producao'}
)

#Criação dos usuários
$usuario = @(
    @{Nome = "Lucas Adams"; Senha = "Lucas@2025"},
    @{Nome = "Julia Cooper"; Senha = "Julia@2025"},
    @{Nome = "Ralph Peterson"; Senha = "Ralph@2025"},
    @{Nome = "Mary Smith"; Senha = "Mary@2025"},
    @{Nome = "Gus Lee"; Senha = "Gus@2025"},
    @{Nome = "Beatrice Williams"; Senha = "Beatrice@2025"},
    @{Nome = "John Henry"; Senha = "John@2025"},
    @{Nome = "Laura Black"; Senha = "Laura@2025"},
    @{Nome = "Philip Martin"; Senha = "Philip@2025"},
    @{Nome = "Victoria Johnson"; Senha = "Victoria@2025"},
    @{Nome = "Peter Ross"; Senha = "Peter@2025"},
    @{Nome = "Alice Clark"; Senha = "Alice@2025"},
    @{Nome = "Felix Green"; Senha = "Felix@2025"},
    @{Nome = "Camille White"; Senha = "Camille@2025"},
    @{Nome = "Daniel Brown"; Senha = "Daniel@2025"},
    @{Nome = "Luke Harris"; Senha = "Luke@2025"},
    @{Nome = "Rachel Adams"; Senha = "Rachel@2025"},
    @{Nome = "Henry Scott"; Senha = "Henry@2025"},
    @{Nome = "Bianca Walker"; Senha = "Bianca@2025"},
    @{Nome = "Julie Carter"; Senha = "Julie@2025"},
    @{Nome = "Edward Stone"; Senha = "Edward@2025"},
    @{Nome = "Maria Hall"; Senha = "Maria@2025"},
    @{Nome = "Thomas Taylor"; Senha = "Thomas@2025"},
    @{Nome = "Carla Evans"; Senha = "Carla@2025"},
    @{Nome = "Brian Moore"; Senha = "Brian@2025"}
)

#
foreach($grupo in $groups) {
    $nomeGrupo = $grupo.Nome
    $desc = $grupo.descricao
    #

    #Correções
    if(-not (Get-LocalGroup -Name $nomeGrupo - ErrorAction SilentilyContinue -foregroundColor red )) {
        new-localgroup -Name $nomeGrupo -Description $descGrupo
        Write-host "O Grupo $nomeGrupo foi criado com sucesso!" -ForegroundColor green
    else 
        Write-host "O Grupo $nomeGrupo já foi criado!" -ForegroundColor yellow

}

}

#
foreach($usuario in $usuarios) 
    $nomeusuario = $usuario.Nome
    $passusuario = $usuario.Senha

