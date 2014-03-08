ActiveAdmin.register_page 'Dashboard' do

  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Facts and Figures !' do
          ul do
            li "There are #{User.count} users"
            li "There are #{Event.count} events"
            li "There are #{DeviceToken.count} registerd devices"
            end
          end
        end
      end

    #   column do
    #     panel 'Info' do
    #       para 'Welcome to ActiveAdmin.'
    #     end
    #   end
    # end
  end # content
end
