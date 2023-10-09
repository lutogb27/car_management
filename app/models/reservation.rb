class Reservation < ApplicationRecord
  belongs_to :user,optional: true 
  belongs_to :room,optional: true

  validates :start_time, presence: { message: "項目を入力してください" }
  validates :end_time, presence: { message: "項目を入力してください" }

  validate :start_end_check
  validate :day_after_today

  def day_after_today
    unless checkin_at == nil
      errors.add(:start_time, 'は、今日を含む過去の日付を入力して下さい') if start_time > Date.today
    end
  end

  def start_end_check
    if start_time == nil
      errors.add(:start_time,"開始時間を入力してください")
    elsif end_time == nil
      errors.add(:end_time,"終了時間を入力してください")
    elsif end_time < start_time
      errors.add(:end_time,"終了日は開始日以降の日付にしてください")
    end
  end
end
