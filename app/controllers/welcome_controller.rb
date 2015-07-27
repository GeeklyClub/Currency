class WelcomeController < ApplicationController

  def index
    data = CSV.read(Rails.root.join("public/rms.xls"), { :col_sep => "\t" })
    from = params[:from] || "Thai Baht"
    from = data[60..110].select { |data| data[0] == from }[0][2]

    @exchange = []
    data[60..110].each_with_index do |d, index|
      @exchange << { currency: d[0], value: d[2].to_f / from.to_f, iso_code: iso_code[index] }
    end
  end

  def iso_code
    # ref http://www.oanda.com/help/currency-iso-code-country#U
    %w(EUR JPY GBP USD DZD AUD BHD BWP BRL BND CAD CLP CNY COP CZK DKK HUF ISK INR IDR IRR ILS KZT KRW KWD LYD MYR MUR MXN NPR NZD NOK OMR PKR PEN PHP PLN QAR RUB SAR SGD ZAR LKR SEK CHF THB TTD TND AED ARS VEF)
  end
end
