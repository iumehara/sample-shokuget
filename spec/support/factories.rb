FactoryGirl.define do

	factory :admin do
		name "firstguy"
		email "firstguy@email.com"
	end

	factory :captcha do
		name "ashitahare"
		photo { File.new("#{Rails.root}/spec/support/attachments/captcha-1.png") }
	end

	factory :feedback do
		email "ana@email.com"
		name "おじさん"
		content "良いサイトだねぇ。"
	end

	factory :filter do
		form_type        "Job"
		form_id          1
		q_text           "What is the answer?"
		a_int            5
		parent_id        1
	end

	factory :job do
		email	"ana@email.com"
		title "笑うセールスマン"
		industry "商社"
		description "とても良い経験になると思います。「笑い」をセールスする仕事です。"
		apply_info "履歴書とカバーレターをemail@email.comまで"
		company "マンハッタン工業"
		url "http://www.website.com"
		location "マンハッタン"
		active true
		type_of "Full-time"
		visa true
		expire_date (Time.now + 30.days).to_date
	end

	factory :order do
		amount 10
	end

	factory :promo do
		type_of "single"
		code    "promopromo"
		rate    100
	end

	factory :redemption do
		job_id    1
		promo_id  1
		amount    0
	end

	factory :submission do
		job_id     1
		from_email "bob@email.com"
		name       "Bob Barker"
		subject    "Hello, this is bob"
		content    "Hope I can get this job!"
		resume_file_size 1024
		resume_file_name 'bob-barker.pdf'
		resume_content_type 'application/pdf'
	end

end
