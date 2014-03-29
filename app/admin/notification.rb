  ActiveAdmin.register_page 'Notifications' do

    controller do

      def notify
        message = params[:message]
        id = params[:id]
        if id.nil?
          User.all.each do |i|
            i.device_tokens.each do |e|
              APNS.delay.send_notification(e.token, message) unless e.token == 'NONE' || e.token.nil?
            end
          end
        else
          User.find(id).device_tokens.each do |i|
            APNS.delay.send_notification(i.token, message)
          end
        end
        redirect_to admin_notifications_path
      end

    end

   #  form do |f|
   #    f.inputs 'Message to send' do
   #      f.input :message
   #    end
   #  f.actions
   # end
    content do
      para 'Notify All Users'
      para 'This will take a long while. DO NOT REFRESH'
      render 'new_notification'
    end
  end
