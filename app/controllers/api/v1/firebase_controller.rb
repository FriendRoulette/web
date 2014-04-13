module Api
	module V1
		class FirebaseController < ApplicationController
			def get_firebase
				user = User.find(params[:id])
			end
		end
	end
end