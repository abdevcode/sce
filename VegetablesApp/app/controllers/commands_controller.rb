class CommandsController < ApplicationController
  def show
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end


    @Commands = current_client.commands.where(ended: true)
  end
end
