class WelcomeController < ApplicationController

  def index
    # datas = CSV.read(Rails.root.join("public/rms.xls"), { :col_sep => "\t" })

    # loop_start = 0
    # loop_end = 0

    # datas.each_with_index do |data, index|
    #   case data.first
    #   when /Currency/
    #     loop_start = index + 1
    #   when /\(1\) Exchange rates are published daily except on IMF holidays or/
    #     loop_end = index - 3
    #   end
    # end

    # datas = datas.values_at(loop_start..loop_end)
    # datas.push(["Vietnamese dong", nil, 1 / 0.00003278, "VND"])
    # datas.each_with_index { |data| data.push(currency_iso_code[data.first.to_s.split.join.downcase]) }

    # from = params[:from] || "THB"
    # from = datas.select { |data| data.last == from.upcase }
    # return if from.empty?
    # from = from.first.third || from.first.fourth

    # @exchange = []
    # datas.each_with_index do |data, index|
    #   to = data.third || data.fourth
    #   @exchange << {
    #     currency: data.first,
    #     iso_code: data.last,
    #     value: to.to_s.gsub(/[^\d^\.]/, '').to_f / from.to_s.gsub(/[^\d^\.]/, '').to_f,
    #   }
    # end
  end

  def exchange
    datas = CSV.read(Rails.root.join("public/rms.xls"), { :col_sep => "\t" })

    loop_start = 0
    loop_end = 0

    datas.each_with_index do |data, index|
      case data.first
      when /Currency/
        loop_start = index + 1
      when /\(1\) Exchange rates are published daily except on IMF holidays or/
        loop_end = index - 3
      end
    end

    datas = datas.values_at(loop_start..loop_end)
    datas.push(["Vietnamese dong", nil, 1 / 0.00003278, "VND"])
    datas.each_with_index { |data| data.push(currency_iso_code[data.first.to_s.split.join.downcase]) }

    @selection = currency_iso_code.to_a

    from = params[:from] || "THB"
    from = datas.select { |data| data.last == from.upcase }
    return if from.empty?
    from = from.first.third || from.first.fourth

    @exchange = []
    datas.each_with_index do |data, index|
      to = data.third || data.fourth
      @exchange << {
        currency: data.first,
        iso_code: data.last,
        value: to.to_s.gsub(/[^\d^\.]/, '').to_f / from.to_s.gsub(/[^\d^\.]/, '').to_f,
      }
    end
  end

  def currency_iso_code
    # ref http://www.oanda.com/help/currency-iso-code-country#U
    {
      "euro" =>                     "EUR",
      "japaneseyen" =>              "JPY",
      "u.k.poundsterling" =>        "GBP",
      "u.s.dollar" =>               "USD",
      "algeriandinar" =>            "DZD",
      "australiandollar" =>         "AUD",
      "bahraindinar" =>             "BHD",
      "botswanapula" =>             "BWP",
      "brazilianreal" =>            "BRL",
      "bruneidollar" =>             "BND",
      "canadiandollar" =>           "CAD",
      "chileanpeso" =>              "CLP",
      "chineseyuan" =>              "CNY",
      "colombianpeso" =>            "COP",
      "czechkoruna" =>              "CZK",
      "danishkrone" =>              "DKK",
      "hungarianforint" =>          "HUF",
      "icelandickrona" =>           "ISK",
      "indianrupee" =>              "INR",
      "indonesianrupiah" =>         "IDR",
      "iranianrial" =>              "IRR",
      "israelinewsheqel" =>         "ILS",
      "kazakhstanitenge" =>         "KZT",
      "koreanwon" =>                "KRW",
      "kuwaitidinar" =>             "KWD",
      "libyandinar" =>              "LYD",
      "malaysianringgit" =>         "MYR",
      "mauritianrupee" =>           "MUR",
      "mexicanpeso" =>              "MXN",
      "nepaleserupee" =>            "NPR",
      "newzealanddollar" =>         "NZD",
      "norwegiankrone" =>           "NOK",
      "rialomani" =>                "OMR",
      "pakistanirupee" =>           "PKR",
      "nuevosol" =>                 "PEN",
      "philippinepeso" =>           "PHP",
      "polishzloty" =>              "PLN",
      "qatarriyal" =>               "QAR",
      "russianruble" =>             "RUB",
      "saudiarabianriyal" =>        "SAR",
      "singaporedollar" =>          "SGD",
      "southafricanrand" =>         "ZAR",
      "srilankarupee" =>            "LKR",
      "swedishkrona" =>             "SEK",
      "swissfranc" =>               "CHF",
      "thaibaht" =>                 "THB",
      "trinidadandtobagodollar" =>  "TTD",
      "tunisiandinar" =>            "TND",
      "u.a.e.dirham" =>             "AED",
      "pesouruguayo" =>             "ARS",
      "bolivarfuerte" =>            "VEF",
      "vietnamesedong" =>           "VND"
    }
  end
end
