require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    task = Task.new(title: 'Task Title', description: 'Task description', user: user)
    expect(task).to be_valid
  end

  it "is not valid without a title" do
    task = Task.new(title: nil, description: 'Task description', user: user)
    expect(task).to_not be_valid
  end

  it "is not valid without a user" do
    task = Task.new(title: 'Task Title', description: 'Task description', user: nil)
    expect(task).to_not be_valid
  end

  it "is not valid without a description" do
    task = Task.new(title: 'Task Title', description: nil, user: user)
    expect(task).to_not be_valid
  end

  it "returns the correct string for the task title" do
    task = Task.create(title: 'Task Title', description: 'Task description', user: user)
    expect(task.title).to eq('Task Title')
  end
end
