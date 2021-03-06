class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  
  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid?
    receiver.valid?
  end

  def execute_transaction
    #binding.pry
    if self.valid? && sender.balance >= amount && self.status == "pending"
      sender.balance -= amount
      receiver.deposit(amount)
      self.status = "complete"
    else
      rejected
    end
  end

  def reverse_transfer
    if self.status == "complete" && self.valid? && receiver.balance >= amount
        sender.balance += amount
        receiver.balance -= amount
        self.status = "reversed"
    else
        rejected
    end
  end

  private

  def rejected
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
  
end
