#
# Cookbook:: metasploitable
# Recipe:: docker
#

# Trusty's apt cannot complete a TLS handshake with download.docker.com any more
# (gnutls 2.12), so the packer template pre-installs the docker-ce deb and the
# cookbook must not try to add the repository.
docker_service 'default' do
  install_method 'package'
  setup_docker_repo false
  version '18.06.1'
  action [:create, :start]
  group 'docker'
end

group 'docker' do
  action [:create, :modify]
  append true
  members node[:metasploitable][:docker_users]
end
