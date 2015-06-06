require 'mkmf'

def get_excludes
  exclude  = %w(.git .gitignore README.md RakeFile mkmf.log)

  if (File.exists?('.gitignore'))
    File.open('.gitignore', 'r').each_line do |line|
      exclude.push(line) unless exclude.include? line
    end
  end

  exclude
end

exclude = get_excludes
def root_dir
  File.dirname(__FILE__)
end

desc 'Install dotfiles'
task :install do

  current_dir = File.dirname(__FILE__)
  Dir.foreach(current_dir) do |item|
    next if item  == '.' or item == '..' or exclude.include? item or item[0] == '.'
    src  = current_dir + "/#{item}"
    dest = File.expand_path('~') + "/.#{item}"
    File.symlink(src, dest) && puts("Symlinking #{dest} -> #{src}") unless File.symlink?(dest) || File.exists?(dest)
  end

  puts "Installation complete!"

end

namespace :composer do
  def composer_exists?
    File.exists?(composer_path)
  end

  # Get the composer path
  def composer_path
    "#{root_dir}/bin/composer"
  end
  desc 'Install composer binary'
  task :install do
    # Check if composer already available
    if composer_exists?
      puts "Composer is already installed at #{root_dir}/bin/composer"
      next
    end

    if !find_executable('php')
      puts "PHP Executable not found!"
      next
    end

    curl = find_executable('curl')

    if curl
      puts "Installing composer now..."
      puts `(cd #{root_dir}/bin && #{curl} -sS https://getcomposer.org/installer | php -- --filename=composer)`

      if File.exists?("#{root_dir}/bin/composer")
        puts "composer installed successfully."
      else
        puts "composer could not be installed properly with curl."
      end
    else
      puts "`curl` not available on this system.",
           "Using PHP directly to download and install..."
      puts `(cd #{root_dir}/bin && php -r "readfile('https://getcomposer.org/installer');" | php)`
      puts "Renaming composer.phar to composer"
      puts `mv #{root_dir}/bin/composer.phar #{root_dir}/bin/composer`
    end
  end

  desc 'Update composer to the latest version'
  task :update do
    if !composer_exists?
      puts "Composer is not installed yet. Run `rake composer:install`."
    end
    puts "Updating composer..."
    puts `#{composer_path} self-update 2>&1`
  end

end

task :default => [:install, "composer:install", "composer:update"]
