namespace :copy do
  desc 'Check copy prerequisites'
  task :check do
    # noop
  end

  desc 'Build and deploy archive'
  task :create_release do
    archive_name = fetch(:archive_name, 'archive.tar.gz')
    exclude_args = fetch(:exclude_dir, []).map { |dir| "--exclude='#{dir}'" }
    build_dir    = fetch(:build_dir, 'dist')

    # Build the tarball locally
    run_locally do
      # Only include files in the build directory
      execute :tar, *exclude_args, '-cvzf', archive_name, "-C #{build_dir}", '.'
    end

    # Deploy the tarball
    on release_roles :all do
      target_dir = fetch(:target_dir, 'public')

      # Make sure the release directory exists
      public_release_path = File.expand_path(target_dir, release_path)
      execute :mkdir, '-p', public_release_path

      # Create a temporary file on the server
      tmp_file = capture('mktemp')

      # Upload the archive, extract it and finally remove the tmp_file
      upload!(archive_name, tmp_file)
      execute :tar, 'xzf', tmp_file, '-C', public_release_path,
              raise_on_non_zero_exit: false
      execute :rm, tmp_file
    end
  end

  desc 'Determine the deployed revision'
  task :set_current_revision do
    on release_roles :all do
      set :current_revision, Time.now
    end
  end

  desc 'Delete the local archive'
  task :clean do
    archive_name = fetch(:archive_name, 'archive.tar.gz')

    File.delete archive_name if File.exist? archive_name
  end

  after 'deploy:finished', 'copy:clean'
end
