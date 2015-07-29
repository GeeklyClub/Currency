class WelcomeController < ApplicationController

  def index
    data = CSV.read(Rails.root.join("public/rms.xls"), { :col_sep => "\t" })

    loop_start = 0
    loop_end = 0

    data.each_with_index do |x, i|
      case x.first
      when /Currency/
        loop_start = i + 1
      when /Bolivar Fuerte/
        loop_end = i
      end
    end
    data = data.values_at(loop_start..loop_end)
    data.each_with_index { |d, i| d.push(iso_code[i]) }

    from = params[:from] || "THB"
    from = data.select { |data| data.last == from }

    @exchange = []
    data.each_with_index do |d, index|
      @exchange << {
        currency: d.first,
        iso_code: d.last,
        value: d.third.to_f / from.first.third.to_f
      }
    end
  end

  def iso_code
    # ref http://www.oanda.com/help/currency-iso-code-country#U
    %w(EUR JPY GBP USD DZD AUD BHD BWP BRL BND CAD CLP CNY COP CZK DKK HUF ISK INR IDR IRR ILS KZT KRW KWD LYD MYR MUR MXN NPR NZD NOK OMR PKR PEN PHP PLN QAR RUB SAR SGD ZAR LKR SEK CHF THB TTD TND AED ARS VEF)
  end
end
