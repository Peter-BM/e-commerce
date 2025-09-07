class AbandonedCartsJob < ApplicationJob
  queue_as :default

  def perform(now: Time.current)
    cutoff_abandon = now - 3.hours
    cutoff_delete  = now - 7.days

    marked = Cart.inactive_since(cutoff_abandon)
                 .update_all(status: "abandoned", abandoned_at: now)

    ids_for_delete = Cart.abandoned_since(cutoff_delete).pluck(:id)

    deleted = 0
    if ids_for_delete.any?
      deleted = Cart.where(id: ids_for_delete).delete_all
    end

    Rails.logger.info("AbandonedCartsJob abandonados=#{marked} deletados=#{deleted}")
  end
end
