class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :author, presence: true
  validates :description, presence: true, length: { maximum: 500 }

  state_machine initial: :new_task do
    event :start_development
      transition [:new_task, :in_qa, :in_code_review] => :in_development
    end

    event :start_qa
      transition in_development: :in_qa
    end

    event :start_code_review
      transition in_qa: :in_code_review
    end

    event :prepare_release
      transition in_code_review: :ready_for_release
    end

    event :release
      transition ready_for_release: :released
    end

    event :archive
      transition [:new_task, :released] => :archived
    end
  end
end
