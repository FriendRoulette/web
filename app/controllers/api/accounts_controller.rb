class Api::AccountsController < ApplicationController
	def index
		@accounts = Account.all

		respond_to do |format|
			format.json { render json: @accounts }
		end
	end

	def show
		@account = Account.find(params[:id])

		respond_to do |format|
			format.json { render json: @account }
		end
	end

	def create
	end

	def update
	end

	def destroy
	end
end
