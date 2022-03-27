class Admin::DashboardController < Admin::AdminController
  authorize_resource class: false

  before_action :dashboard_and_filter_objects, only: %i[index filter_dashboard_by_date_range]

  def index; end

  def filter_dashboard_by_date_range; end

  def export
    ExportJob.perform_later(export_id: params[:export_id],
                            start_date: params[:start],
                            end_date: params[:end],
                            user_id: current_user.id)

    head :accepted
  end

  private

  def dashboard_and_filter_objects
    # N de Imóveis Trabalhados;             ✔
    # N de Imóveis Trabalhados c Foco;      ✔
    # N de Imóveis tratados c Larvicida;
    # N de Imóveis Fechados;                ✔
    # N de Visitas Recusadas                ✔
    # N de Imóveis Recuperados
    # N de Imóveis Recuperados  c Foco
    # N de Imóveis Recuperados tratados c Larvicida
    # Observações

    field_forms_base_query = FieldForm.based_on_role_for(current_user)
                                      .by_dashboard_range(dashboard_date_range).distinct

    shed_type_base_query   = ShedType.based_on_role_for(current_user)
                                     .contaminated_places_per_range(dashboard_date_range)

    @total_visits      = field_forms_base_query.size
    @completed_visits  = field_forms_base_query.completed.size
    @clean             = field_forms_base_query.find_all { |ff| !ff.larvae_found and ff.visit_status == 'allowed' }.size
    @with_larvae       = field_forms_base_query.find_all(&:larvae_found).size
    @closed_or_refused = field_forms_base_query.find_all { |ff| ff.visit_status == 'refused' or ff.visit_status == 'closed_location' }.size

    @contaminated_places = shed_type_base_query.group_by { |hsh| hsh[:place].itself }
                                               .map do |key, val|
                                                 { name: key, data: val.map do |q|
                                                   { q.property => q.count }
                                                 end.reduce({}, :merge) }
                                               end

    @number_of_larvae_per_region = TestTube.based_on_role_for(current_user)
                                           .total_larvae_per_region_range(dashboard_date_range)
                                           .group_by { |hsh| hsh[:region].itself }
                                           .map { |key, val| { key => val[0].sum } }
                                           .reduce({}, :merge)

    @property_types = PropertyType.based_on_role_for(current_user)
                                  .visited_per_range(dashboard_date_range)
                                  .group_by { |hsh| hsh[:name].itself }
                                  .map { |key, val| { key => val[0].count } }
                                  .reduce({}, :merge)

    @number_of_larvae_per_shed_type = shed_type_base_query.group_by { |hsh| hsh[:property].itself }
                                                          .map { |key, val| { key => val.size } }
                                                          .reduce({}, :merge)

    @species_per_region = LarvaSpecies.based_on_role_for(current_user)
                                      .species_by_region_per_range(dashboard_date_range)
                                      .group_by { |hsh| hsh[:specie].itself }
                                      .map do |key, val|
                                        { name: key, data: val.map do |q|
                                          { q.region => q.count }
                                        end.reduce({}, :merge) }
                                      end
  end

  def dashboard_date_range
    if params[:start].present? && params[:end].present?
      return params[:start].to_datetime.beginning_of_day..params[:end].to_datetime.end_of_day
    end

    DateTime.now.beginning_of_month..DateTime.now.end_of_month
  end
end
