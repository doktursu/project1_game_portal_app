class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :game_stats
  has_and_belongs_to_many :ttt_games
  has_and_belongs_to_many :mttt_games

  validates :username, presence: true,
                     uniqueness: true,
                         length: { minimum: 3 },
                         format: { with: /\A[a-zA-Z0-9]+\Z/ }

  scope :players, -> { where(role: 'player') }
  scope :of_role, -> (role) { where(role: role) }
  scope :all_except, -> (user) { where.not(id: user) }
  scope :rubot, -> { find_by(username: 'RUBOT', role: 'ai') }
  scope :player1, -> { find_by(username: 'Player1', role: 'default_player') }
  scope :player2, -> { find_by(username: 'Player2', role: 'default_player') }

  after_initialize :set_default_role

  def set_default_role
    self.role ||= 'player'
  end

  ROLES = %w(player default_player ai)

  ROLES.each do |role|
    define_method("#{role}?") do
      self.role == role
    end
  end

end
