# Resgatador de Jogos Amazon Prime Gaming
Todo més a amazon oferece varios jogos no amazon prime gaming, o objetivo do script é pegar os jogos de forma automatica

## O script realiza as seguintes operações:

* Login na conta da Amazon
* Resgate dos jogos gratuitos do primegaming

## Tecnologias

* Ruby: Linguagem de programação usada para o desenvolvimento do script.
* Selenium WebDriver: Biblioteca usada para controlar o navegador e interagir com os elementos da página.

## Dependências

Antes de executar o script, você precisará instalar as dependências necessárias:

    Selenium WebDriver: Para interagir com o navegador.
    dotenv: Para as variaveis de ambiente
    ruby ou docker

gem install selenium-webdriver
gem install dotenv

## Como Usar
### Sessão Já Existente

Se você já tiver uma sessão do Chrome aberta e preferir usar o modo debug para pular o login e os captchas:

Abra o Chrome em modo debug executando o comando abaixo no terminal:

    google-chrome --remote-debugging-port=9555

Certifique-se de que o Ruby esteja instalado no seu sistema e execute o script com o comando:

    ruby script.rb

Nota: O modo debug permite usar uma sessão já existente do Chrome, o que pode ajudar a evitar captchas e agilizar o processo de login.
Uma vez que você pode usar uma sessão que já tenha os logins necessarios no prime gaming
### Iniciando Nova Sessão

Se você preferir iniciar uma nova sessão com login, siga estas etapas:

1.Crie um arquivo .env na raiz do projeto.

2.Adicione as variáveis de ambiente EMAIL e PASSWORD no arquivo .env:

    EMAIL=bla@gmail.com
    PASSWORD=senhagenerica
    AMAZON_GAMING_URL=https://gaming.amazon.com/home

Execute o script com o comando:

ruby script.rb

Ou, se estiver usando Docker, execute:

docker compose run --rm ruby-app bash -c "ruby script.rb"


# Configuração do driver
    driver = Selenium::WebDriver.for :chrome
    wait = Selenium::WebDriver::Wait.new(timeout: 10)

### Exemplo de Saída

Ao executar o script, você verá mensagens no console indicando que está resgatando os jogos:

Resgatando Call of Juarez: Gunslinger...
Resgatando Tomb Raider...
