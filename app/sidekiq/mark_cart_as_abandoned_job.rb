class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform(*args)
    # JOB feito na pasta jobs
  end
end
