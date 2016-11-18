require 'httparty'

PVP_URL = 'https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=all&api_key=RGAPI-6649824c-a7bc-4124-9ac4-ca3d6a066bf8'

def get_champ_info
  api_response = HTTParty.get(PVP_URL)['data']

  champions = []

  api_response.each do |champ_name| # Going through each champion hash.
    champ_name.each do |champ_data| # Going through the keys inside each champion.

      next if champ_data['name'].nil?

      individual_champ_spells = champ_data['spells'].map { |spell|
        {spell: spell['name'], cooldown: spell['cooldown'], description: spell['description']}
      }

      champions << {
                    name: champ_data['name'], title: champ_data['title'], spells: individual_champ_spells,
                    mana: champ_data['stats']['mp'], health: champ_data['stats']['hp'], mpperlevel: champ_data['stats']['mpperlevel'],
                    hpperlevel: champ_data['stats']['hpperlevel'], attackdamage: champ_data['stats']['attackdamage'],
                    adperlevel: champ_data['stats']['attackdamageperlevel'],
                    }
    end
  end
  champions
end

puts get_champ_info
