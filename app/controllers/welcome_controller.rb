class WelcomeController < ApplicationController

  def index
    datas = CSV.read(Rails.root.join("public/rms.xls"), { :col_sep => "\t" })

    loop_start = 0
    loop_end = 0

    datas.each_with_index do |data, index|
      case data.first
      when /Currency/
        loop_start = index + 1
      when /Bolivar Fuerte/
        loop_end = index
      end
    end

    datas = data.values_at(loop_start..loop_end)
    datas.each_with_index { |data, index| data.push(iso_code[index]) }

    from = params[:from] || "THB"
    from = data.select { |data| data.last == from.upcase }
    from = from.first.third || from.first.fourth

    @exchange = []
    datas.each_with_index do |data, index|
      to = data.third || data.fourth
      @exchange << {
        currency: data.first,
        iso_code: data.last,
        value: to.to_f / from.to_f
      }
    end
  end

  def iso_code
    # ref http://www.oanda.com/help/currency-iso-code-country#U
    %w(EUR JPY GBP USD DZD AUD BHD BWP BRL BND CAD CLP CNY COP CZK DKK HUF ISK INR IDR IRR ILS KZT KRW KWD LYD MYR MUR MXN NPR NZD NOK OMR PKR PEN PHP PLN QAR RUB SAR SGD ZAR LKR SEK CHF THB TTD TND AED ARS VEF)
  end
end
