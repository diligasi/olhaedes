class Pwa::InstitutionalController < Pwa::PwaController

  def index
    @institutional = Institutional.first
  end
end
