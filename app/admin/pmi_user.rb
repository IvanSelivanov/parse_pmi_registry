ActiveAdmin.register PmiUser do
  actions :index, :show

  remove_filter :pmi_credentials
  remove_filter :created_at
  remove_filter :updated_at

  index do
    id_column
    column :name
    column :city
    column :credentials do |user|
      user.pmi_credentials.pluck(:credential).join(', ')
    end

    actions
  end

  action_item :update_data do
    link_to 'Update data', pmi_data_path, method: :patch
  end
end