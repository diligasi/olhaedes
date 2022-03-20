require 'csv'

class ExportCommand
  HEADER = ['Id Ficha', 'Id Agente', 'Secretaria', 'Região', 'Rua', 'Número', 'Complemento', 'Quadra', 'Bairro',
            'Município', 'Estado', 'País', 'CEP', 'Tipo de imóvel', 'Permitiu visita?', 'Comentário da visita',
            'Larvas presentes?', 'Quantas larvas?', 'Uso de larvicida?', 'Uso de raticida?', 'Status da Ficha',
            'Data de criação'].freeze

  def self.call(field_forms)
    new(field_forms).call
  end

  def initialize(field_forms)
    @field_forms = field_forms
  end

  def call
    CSV.generate("\uFEFF", col_sep: ';') do |csv|
      csv << HEADER

      @field_forms.each do |field_form|
        csv << [
          field_form.id,                                  # Id Ficha
          field_form.user_id,                             # Id Agente
          department_name(field_form),                    # Secretaria
          region_name(field_form),                        # Região
          field_form.street,                              # Rua
          field_form.number,                              # Número
          field_form.complement,                          # Complemento
          field_form.block,                               # Quadra
          field_form.district,                            # Bairro
          field_form.city,                                # Município
          field_form.state,                               # Estado
          'Brasil',                                       # País
          field_form.zipcode,                             # CEP
          property_type_name(field_form),                 # Tipo de imóvel
          humanize_status_for(field_form.visit_status),   # Permitiu visita?
          field_form.visit_comment,                       # Comentário da visit
          humanize_status_for(field_form.larvae_found),   # Larvas presentes?
          amount_of_larvae(field_form),                   # Quantas larvas?
          humanize_status_for(field_form.larvicide),      # Uso de larvicida?
          humanize_status_for(field_form.rodenticide),    # Uso de raticida?
          humanize_field_form_status_for(field_form),     # Status da Ficha
          field_form.created_at.rfc3339                   # Data de criação
        ]
      end
    end
  end

  private

  def department_name(field_form)
    field_form.user.region.department.name
  end

  def region_name(field_form)
    field_form.user.region.name
  end

  def property_type_name(field_form)
    field_form.property_type&.name
  end

  def humanize_status_for(field)
    field ? 'Sim' : 'Não'
  end

  def amount_of_larvae(field_form)
    field_form.test_tubes&.reduce(0) { |sum, n| sum + n.collected_amount }
  end

  def humanize_field_form_status_for(field_form)
    field_form.complete? ? 'Concluída' : 'Pendente'
  end
end
