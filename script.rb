require 'selenium-webdriver'
require 'dotenv/load'
require 'pry-byebug'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--remote-debugging-port=9555')

driver = Selenium::WebDriver.for :chrome, options: options
wait = Selenium::WebDriver::Wait.new(timeout: 10)
driver.manage.window.maximize

def login(driver, wait)
  sign_in_button = wait.until { driver.find_element(css: '.sign-in-button') }
  sign_in_button.click

  driver.find_element(id: 'ap_email').send_keys(ENV['EMAIL'])
  wait.until { driver.find_element(id: 'continue') }.click

  driver.find_element(id: 'ap_password').send_keys(ENV['PASSWORD'])
  wait.until { driver.find_element(id: 'signInSubmit') }.click
end

def navigate_to_free_games(driver, wait)
  freegames_button = wait.until { driver.find_element(css: '[data-a-target="offer-filter-button-Game"]') }
  driver.execute_script("arguments[0].scrollIntoView(true);", freegames_button)
  freegames_button.click
end

def claim_game(driver, wait, url, game_title)
  driver.get url
  platform_name = url.match(/(\w+)(?=\/dp)/).captures.first.capitalize
  claim_button = wait.until { driver.find_element(css: '[data-a-target="buy-box_call-to-action-text"]') }
  driver.execute_script("arguments[0].scrollIntoView(true);", claim_button)
  claim_button.click

  puts "#{game_title} claimed with #{platform_name} code"

  write_gog_code(driver, wait) if platform_name == 'Gog'
end

def write_gog_code(driver, wait)
  claim_code = wait.until { driver.find_element(css: '[data-a-target="claim-code"]').attribute('href') }
  File.write('gog_codes.txt', "#{claim_code}\n", mode: 'a')
end

def get_game_links_and_titles(driver, wait)
  game_elements = wait.until { driver.find_elements(css: '[data-a-target="FGWPOffer"]') }

  games = {}
  game_elements.each do |element|
    game_title = element.attribute('aria-label')&.gsub(/^Resgatar |^Claim /, '')
    game_link = element.attribute('href')

    next unless game_link && game_title

    games[game_title] = game_link
  end

  games.each do |title, link|
    claim_game(driver, wait, link, title)
  end
end

begin
  driver.get ENV['AMAZON_GAMING_URL']
  login(driver, wait)
  navigate_to_free_games(driver, wait)
  get_game_links_and_titles(driver, wait)

rescue Selenium::WebDriver::Error::NoSuchElementError => e
  puts "Erro: Elemento não encontrado. Detalhes: #{e.message}"
rescue => e
  puts "Erro: #{e.message}"
ensure
  driver.quit
end
