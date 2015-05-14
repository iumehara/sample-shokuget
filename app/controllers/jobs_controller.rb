class JobsController < ApplicationController
  # before_action :has_token, only: [:review, :edit, :update, :destroy]

  def index
    @jobs = Job.where(active: true)
    respond_to do |format|
      format.html
      format.json { render json: @jobs.to_json(methods: :description_stripped)  }
    end
  end

  def new
    @job = Job.new
    @work_filters      = FilterForm.work_filters

    @language_filters  = FilterForm.language_filters
    @language_offset   = @work_filters.length

    @education_filters = FilterForm.education_filters
    @education_offset  = @language_offset + @language_filters.length

    @software_filters  = FilterForm.software_filters
    @software_offset   = @education_offset + @education_filters.length
  end

  def edit
    if params[:token].present? && Job.find_by(token: params[:token])
      @job = Job.find_by token: params[:token]
      filters = @job.filters
      @work_filters      = FilterForm.work_filters @job

      @language_filters = FilterForm.language_filters @job
      @language_offset  = @work_filters.length

      @education_filters = FilterForm.education_filters @job
      @education_offset  = @language_offset + @language_filters.length
      @software_filters  = FilterForm.software_filters
      @software_offset   = @education_offset + @education_filters.length
    else
      redirect_to job_path(params[:id])
    end
  end

  def create
    @job  = Job.new(job_params)
    params["filter"] ||= @filter_params
    if @job.save
      params["filter"].each do |f_index, f_hash|
        if f_hash["selected"] == "true"
          filter = @job.filters.build(section: f_hash["section"],
                                      q_text: f_hash["q_text"],
                                      select_options: f_hash["select_options"],
                                      a_type: f_hash["a_type"],
                                      a_int: f_hash["a_int"],
                                      a_bool: f_hash["a_bool"],
                                      a_string: f_hash["a_string"])
          filter.save
        end
      end
      redirect_to review_job_path(id: @job.id, token: @job.token)
    else
      @work_filters      = FilterForm.work_filters
      @language_filters  = FilterForm.language_filters
      @language_offset   = @work_filters.length
      @education_filters = FilterForm.education_filters
      @education_offset  = @language_offset + @language_filters.length
      @software_filters  = FilterForm.software_filters
      @software_offset   = @education_offset + @education_filters.length
      render action: 'new'
    end
  end

  def update
    @job = Job.find_by(token: params[:token])
    if @job.update(job_params)
      params["filter"].each do |f_index, f_hash|
        if @job.filters.where(q_text: f_hash["q_text"]).present?
          filter = @job.filters.where(q_text: f_hash["q_text"]).first
          if f_hash["selected"] == "true"
            filter.update(section: f_hash["section"],
                          q_text: f_hash["q_text"],
                          select_options: f_hash["select_options"],
                          a_type: f_hash["a_type"],
                          a_int: f_hash["a_int"],
                          a_bool: f_hash["a_bool"],
                          a_string: f_hash["a_string"])
          else
            filter.delete
          end
        elsif f_hash["selected"] == "true"
          filter = @job.filters.build(section: f_hash["section"],
                                    q_text: f_hash["q_text"],
                                    select_options: f_hash["select_options"],
                                    a_type: f_hash["a_type"],
                                    a_int: f_hash["a_int"],
                                    a_bool: f_hash["a_bool"],
                                    a_string: f_hash["a_string"])
          filter.save
        end
      end
      if @job.active?
        redirect_to job_path(@job.id)
      else
        redirect_to review_job_path(id: @job.id, token: @job.token)
      end
    else
      @work_filters      = FilterForm.work_filters
      @language_filters  = FilterForm.language_filters
      @language_offset   = @work_filters.length
      @education_filters = FilterForm.education_filters
      @education_offset  = @language_offset + @language_filters.length
      @software_filters  = FilterForm.software_filters
      @software_offset   = @education_offset + @education_filters.length
      render action: 'edit'
    end
  end

  def review
    @job = Job.find_by token: params[:token]
    @submission = Submission.new
    @submission.filters.build
    @redemption = Redemption.new
    @captcha    = Captcha.create_random
  end

  def redeem
    @job = Job.find_by token: params[:token]
    clean_promo_code = params[:redemption][:promo_code].downcase
    promo = Promo.find_by(code: clean_promo_code)
    @redemption = Redemption.new(job_id: @job.id, promo_code: clean_promo_code)
    if @redemption.save
      @job.update(admin: promo.admin)
      redirect_to new_order_path(id: params[:id], token: params[:token])
    else
      @submission = Submission.new
      @captcha    = Captcha.create_random
      render 'review'
    end
  end

  def show
    jobs = Job.where(active: true)
    @job = jobs.find params[:id]
    @submission = Submission.new
    @submission.filters.build
    @jobs = Job.where(active: true)
    @jobs = Job.find_related(@job)
    @captcha           = Captcha.create_random
    respond_to do |format|
      format.html
      format.json { render json: @job }
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_url
  end

  private

    def job_params
      params.require(:job).permit(
        :apply_info,
        :company,
        :description,
        :email,
        :industry,
        :location,
        :recruiter_name,
        :title,
        :type_of,
        :url,
        :visa
      )
    end

    def has_token
      redirect_to root_path unless params[:token] == @job.token
    end

end
