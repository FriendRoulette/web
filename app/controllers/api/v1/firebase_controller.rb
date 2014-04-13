module Api
	module V1
		class FirebaseController < ApplicationController
			skip_before_filter  :verify_authenticity_token
			
			def get_firebase
				user = User.find(params[:id])
			end
		end
	end
end