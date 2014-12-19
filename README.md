# Rapporto

Library to communicate with Mobile Finance Management Solutions

## Installation

Add this line to your application's Gemfile:

    $ gem 'rapporto'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rapporto

## Usage

Define settings:

    Rapporto::SMS.settings = {
      :server   => 'lk.rapporto.ru',
      :port     => 9002,
    }

Initialize sms:

    sms = Rapporto::SMS.new('phone','title','text') # initialize sms
    sms = Rapporto::SMS.new('phone','title','text') # last parameter overrides 'translit' option

Send it and get sent sms id and dispatch code:

    sms.send # send sms. returns sms id or dispatch code if something went wrong
    sms.id # get sms id

Ex.:

    sms = Rapporto::SMS.new('79031111111','MyFavouriteCompany','Testing rapporto gem')
    sms.send # => 1032
    sms.id # => 1032

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
