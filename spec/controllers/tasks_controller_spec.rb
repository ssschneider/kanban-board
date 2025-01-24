require "rails_helper"

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before do
    sign_in user, scope: :user
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new task" do
        expect {
          post :create, params: { task: { title: 'New Task', description: 'Task description', user_id: user.id } }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the task show page" do
        post :create, params: { task: { title: 'New Task', description: 'Task description', user_id: user.id } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new task" do
        expect {
          post :create, params: { task: { title: '', description: 'Task description', user_id: user.id } }
        }.to_not change(Task, :count)
      end

      it "re-renders the new template" do
        post :create, params: { task: { title: '', description: 'Task description', user_id: user.id } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    it "updates the task" do
      patch :update, params: { id: task.id, task: { title: 'Updated Task' } }
      task.reload
      expect(task.title).to eq('Updated Task')
    end

    it "redirects to the root page" do
      patch :update, params: { id: task.id, task: { title: 'Updated Task' } }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the task" do
      task = create(:task, user: user)
      expect {
        delete :destroy, params: { id: task.id }, format: :js
      }.to change(Task, :count).by(-1)
    end
  end
end
