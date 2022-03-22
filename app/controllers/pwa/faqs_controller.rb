class Pwa::FaqsController < Pwa::PwaController

  def index
    @faqs = Faq.order(:id)
  end
end
