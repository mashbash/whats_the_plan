class User < ActiveRecord::Base
  has_many :plans, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :name, :presence => true
  validates :email, :presence => true
  # validates_length_of :password, :within => Devise.password_length, :allow_blank => true
  # validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?


  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  scope :upcoming_plans, -> { joins(:plans).where("end_date > ?", Time.now) }
  scope :past_plans,     -> { joins(:plans).where("end_date < ?", Time.now) }

  def upcoming_plans
    plans.where("end_date > ?", Time.now )
  end
  
  def past_plans
    plans.where("end_date < ?", Time.now ) 
  end   

end
