class InviteCollaboratorsMailer < ApplicationMailer
    default from: 'trungtinbkit@gmail.com'
    def invite_collaborator(sender, receiver, note) 
        if User.find_by_email(receiver).nil?
            @password = rand(111111...999999).to_s
            user = User.create(name: receiver, 
                password: @password, 
                password_confirmation: @password, 
                email: receiver,
                changed_password: "false")
        end
        @sender = sender
        @receiver = receiver
        @note = note
        mail :to => @receiver, :subject => "You have an invitation from #{@sender.email} !"
    end
    
end
