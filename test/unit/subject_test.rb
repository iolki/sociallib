require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  test "subject name cannot be less than 2 chars" do
    # 2 character name
    subject = Subject.new
    subject.name = 'AB'
    assert subject.save

    # 1 character name
    subject = Subject.new
    subject.name = 'A'
    assert !subject.save

    # zero-length name
    subject = Subject.new
    subject.name = ''
    assert !subject.save
  end
  
end
