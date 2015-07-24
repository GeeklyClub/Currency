class WelcomeController < ApplicationController

  def index
    data = SmarterCSV.process('public/rms_five.csv')

    from  = params[:from]
    to    = params[:to]

    unless from.nil? or to.nil?
      # date = Date.yesterday.strftime("%d/%m//%Y")
      @from = data.select { |data| data[:currency] == from }[0][:"23/07/2015"]
      @to   = data.select { |data| data[:currency] == to }[0][:"23/07/2015"]
      @exchange = @from / @to
    else
      from = from.nil? ? "Thai Baht" : from

      @from = data.select { |data| data[:currency] == from }[0][:currency]


      # raise @from.inspect
      @exchange = []
      data.each do |d|
        @exchange << { currency: d[:currency], value: @from.to_f / d[:"23/07/2015"].to_f }
      end
    end
  end
end
