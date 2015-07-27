class WelcomeController < ApplicationController

  def index
    data = CSV.read(Rails.root.join("public/rms.xls"), { :col_sep => "\t" })
    from = data[60..110].select { |data| data[0] == params[:from] }[0][2]

    @exchange = []
    data[60..110].each do |d|
      @exchange << { currency: d[0], value: d[3].to_f / from.to_f }
    end
  end
end
