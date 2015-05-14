require 'spec_helper'

describe OrdersController do

	before do
		@job = FactoryGirl.create	:job, active:false
		admin  = FactoryGirl.create :admin
		@promo = FactoryGirl.create :promo, code: "test", admin_id: admin.id
		@redemption = FactoryGirl.create :redemption, job_id: @job.id, promo_code: "test"
	end

	it "should hit Twitter/FB client on create" do
		Twitter::REST::Client.should_receive(:new).and_return(Twitter::REST::Client)
		Koala::Facebook::API.should_receive(:new).and_return(Koala::Facebook::API)
		order_params = FactoryGirl.attributes_for(:order, job_id: @job.id)
		post :create, id: @job.id, order: order_params, sns_posts: "1"
	end

	it "should hit mailer if order_email is checked" do
		OrdersMailer.should_receive(:new_order).and_return(OrdersMailer)
		OrdersMailer.should_receive(:deliver).and_return(true)
		order_params = FactoryGirl.attributes_for(:order, job_id: @job.id)
		post :create, id: @job.id, order: order_params, order_email: "1"
	end

end
