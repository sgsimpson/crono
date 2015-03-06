require "spec_helper"
require "generators/crono/install/templates/migrations/create_crono_jobs.rb"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.logger = Logger.new(STDOUT)
CreateActiveAdminComments.up

describe Crono::CronoJob do
  let(:valid_attrs) do
    {
      job_id: "Perform TestJob every 2 days"
    }
  end

  it "should validate presence of job_id" do
    @crono_job = Crono::CronoJob.new()
    expect(@crono_job).not_to be_valid
  end

  it "should save job_id to DB" do
    Crono::CronoJob.create!(valid_attrs)
    @crono_job = Crono::CronoJob.where(job_id: valid_attrs[:job_id]).first
    expect(@crono_job).to be_present
  end
end
