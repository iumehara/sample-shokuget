class Job < ActiveRecord::Base
	include ActionView::Helpers::SanitizeHelper

	has_many :filters, as: :form, dependent: :destroy
	has_many :submissions
	has_one :redemption
	has_one :promo, through: :redemption
	has_one :order
	belongs_to :admin

	validates :email , format: { with: VALID_EMAIL_REGEX }, if: :email?
	validates_presence_of :title, :industry, :location, :type_of, :company, :email
	validate :description_present_after_stripping_tags?

	before_create :create_and_set_token
	after_save :create_or_update_default_filters


	def self.find_related job
		where.not(id: job.id).where(active: true, industry: job.industry, type_of: job.type_of).shuffle.first(10)
	end

	def promotion?
		true
		# self.redemption && self.redemption.amount == 0
	end

	def active?
		self.active == true
	end

	def amount_promo
		self.promo.rate
	end

	def amount_total
		self.redemption.amount || 100
	end

	def description_stripped
		strip_tags self.description
	end

	def sns_text
		"職Get 就職速報 | #{self.company} | #{self.title}"
	end

	def sns_hashtags
		"#ニューヨーク"
	end

	def post_to_sns
		post_to_twitter
		post_to_facebook
	end

	def post_to_twitter
		twitter_client = init_twitter_client
		if Rails.env.production?
    	twitter_client.update("#{self.sns_text} | shokuget.com/jobs/#{self.id}")
		end
	end

	def post_to_facebook
		post_content = "#{self.sns_text} | shokuget.com/jobs/#{self.id}"
		facebook_client = init_facebook_client
		if Rails.env.production?
			facebook_client.put_wall_post(post_content)
		end
	end


	private

		def create_and_set_token
			self.token = Job.create_token
		end

		def self.create_token
			Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)
		end

		def description_present_after_stripping_tags?
			unless strip_tags(description).present?
				errors.add(:description, "を読み取ることができませんでした。確認して再度入力してください。")
			end
		end

		def init_twitter_client
			Twitter::REST::Client.new do |config|
	      config.consumer_key        = "A2ck14gv2M7WoJCdyBd0PBNkn"
	      config.consumer_secret     = "aXV85Xj0MJLUZPo2BjROhkHXwGRhtrfijWZ3AXZazY11Of7cVx"
	      config.access_token        = "2431077559-PSoF67RbePBGQdijQlLXj32RSoXl8DdfIYWFYOb"
	      config.access_token_secret = "ozvAQyzhImx1a2euAMb2kOXQTRO2PhZbxABNQEcjs4qbo"
	    end
		end

		def init_facebook_client
			Koala::Facebook::API.new("CAAD0CZBNiTQkBAEI9ceBByQEIAeZChmmrdiULBEuXZBTr5uQZBrlTugviYzCrZAssaBxtavAZCPSLrh5bZCPnoVxiZBQOdeBW0olW7GS0I4nnyjnoi3nlQNvX5y69eN61xbV1Pwr5OEBE4aJCxWAE82msB2yLTPAUHRAZCWOHGnvByk1XpMHQkxdPiMGQ4bo0vXAZD")
			#token updated 5/25 9PM
		end

		def create_or_update_default_filters
			create_or_update_visa_filter
			create_home_filter
			create_commute_filter
		end

		def create_or_update_visa_filter
			if self.visa
				a_int = 10
			else
				a_int = 30
			end
			if filter = self.filters.where(section:"visa").first
				filter.update(a_int: a_int) if filter.a_int != a_int
			else
				filter = self.filters.build(
					section: "visa",
					q_text: "現在のビザステータス",
					select_options: VISA_OPTIONS.to_json,
					a_type: "Integer",
					a_int: a_int)
				filter.save
			end
		end

		def create_home_filter
			unless self.filters.where(section:"home").present?
				home_filter = self.filters.build(
					section: "home",
					q_text: "現在のお住まい",
					select_options: HOME_OPTIONS.to_json,
					a_type: "Integer",
					a_int: 0)
				home_filter.save
			end
		end

		def create_commute_filter
			unless self.filters.where(section: "commute").present?
				commute_filter = self.filters.build(
					section: "commute",
					q_text: "#{self.location}への通勤の可・不可",
					select_options: [["可能", 1], ["不可能", 0]].to_json,
					a_type: "Integer",
					a_int: 1)
				commute_filter.save
			end
		end

end

# == Schema Information
#
# Table name: jobs
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  title           :string(255)
#  industry        :string(255)
#  visa            :boolean
#  description     :text
#  apply_info      :string(255)
#  company         :string(255)
#  url             :string(255)
#  location        :string(255)
#  active          :boolean
#  type_of         :string(255)
#  expire_date     :date
#  token           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  admin_id        :integer
#

