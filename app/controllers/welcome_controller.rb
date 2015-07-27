class WelcomeController < ApplicationController

  def index
    data = CSV.read(Rails.root.join("public/rms.xls"), { :col_sep => "\t" })
    from = params[:from] || "Thai Baht"
    from = data[60..110].select { |data| data[0] == from }[0][2]

    @exchange = []
    data[60..110].each do |d|
      @exchange << { currency: d[0], value: d[2].to_f / from.to_f }
    end
  end
end
