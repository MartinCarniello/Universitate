RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    redirect_to main_app.root_path unless current_user.is_admin?
  end
  #config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.included_models = ["Subject", "User", "Role","Rating","Level"]

  config.model 'Rating' do
    list do
      exclude_fields :created_at, :updated_at
    end
  end
  config.model 'Subject' do
    list do
      exclude_fields :created_at, :updated_at
    end
  end
  config.model 'User' do
    list do
      exclude_fields :created_at, :updated_at
    end
  end
  config.model 'Role' do
    list do
      exclude_fields :created_at, :updated_at
    end
  end
  config.model 'Level' do
    list do
      exclude_fields :created_at, :updated_at
    end
  end
  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    bulk_delete
    show
    edit
    delete


    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
