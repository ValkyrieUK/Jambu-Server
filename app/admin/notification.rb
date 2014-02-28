  ActiveAdmin.register_page 'Notifications' do

    controller do

      def notify
        message = params[:message]
        User.all.each do |i|
          APNS.send_notification(i.device_token, message) unless i.device_token == 'NONE' || i.device_token.nil?
        end
        redirect_to root_path
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