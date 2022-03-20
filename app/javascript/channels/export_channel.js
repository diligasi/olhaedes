import consumer from 'channels/consumer'

if (window.ExportChannel == null) {
  window.ExportChannel = {};
}

window.ExportChannel.Subscribe = function(export_id, callback) {
  let exportSubscription = consumer.subscriptions.create(
      { channel: 'ExportChannel', export_id: export_id },
      {
        connected: function() {
          callback();
        },
        disconnected: function() {},
        received: function(data) {
          let blob, csv_download_link;

          blob = new Blob([data['csv_file']['content']], { type: 'text/csv;charset=utf-8' });

          csv_download_link = document.createElement('a');
          csv_download_link.href = window.URL.createObjectURL(blob);
          csv_download_link.download = data['csv_file']['file_name'];
          csv_download_link.click();

          $('.export-btn').html("<i class='fa fa-file-excel'></i>&nbsp;&nbsp;&nbsp;Baixar relatório");
          $('.export-btn').removeClass('disabled');

          consumer.subscriptions.remove(exportSubscription);
        }
      }
  );
}
