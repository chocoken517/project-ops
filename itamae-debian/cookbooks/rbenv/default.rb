include_recipe 'rbenv::system'

bashrc_add_text = %w( export\ RBENV_ROOT=/usr/local/rbenv
                      export\ PATH="${RBENV_ROOT}/bin:${PATH}"
                      eval\ "$(rbenv\ init\ -)")

bashrc_path = '/etc/bash.bashrc'

bashrc_add_text.each do |text|
  file "bash.bashrc add '#{text}'" do
    action :edit
    path bashrc_path
    block { |content| content << "\n#{text}" }
    not_if "grep '#{text}' #{bashrc_path}"
  end
end
