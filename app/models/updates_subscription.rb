class UpdatesSubscription < Subscription
  def description
    "New offers and requests"
  end

  def new_items
    Proposal.where(created_at: self.period).count
  end

  def enough_new_items?
    new_items >= 4
  end

  def ready?
    super && enough_new_items?
  end

  def send_email!
    SubscriptionMailer.updates(self).deliver_now
    update(last_sent: Time.now)
  end
end

# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  active     :boolean
#  frequency  :integer
#  name       :integer
#  created_at :datetime
#  updated_at :datetime
#  secure_key :string
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
