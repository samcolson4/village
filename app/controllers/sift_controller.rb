class SiftController < ApplicationController
  SIFTS = 2

  def index
    @all_sifts = Submission.where(used: false).where(today: false).to_a

    @sifts = []
    @sifts.append(@all_sifts[0])
    @sifts.append(@all_sifts[1])
  end

end
