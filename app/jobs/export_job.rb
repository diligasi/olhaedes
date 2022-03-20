class ExportJob < ApplicationJob
  queue_as :default

  def perform(export_id: nil, start_date: nil, end_date: nil, user_id: nil)
    return if export_id.blank?

    field_forms = FieldForm.based_on_role_for(user(user_id))
                           .by_dashboard_range(start_date.to_datetime.beginning_of_day..end_date.to_datetime.end_of_day)

    csv_content = ExportCommand.call(field_forms)

    ActionCable.server.broadcast(
      "export_channel_#{export_id}", {
        csv_file: {
          file_name: "Relatório de fichas ( #{start_date}_-_#{end_date} ).csv",
          content: csv_content
        }
      }
    )
  end

  private

  def user(id)
    User.find(id)
  end
end
