# Instalar WP CLI
remote_file '/tmp/wp' do
  #source 'https://es.wordpress.org/latest-es_ES.tar.gz'
  #source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli-nightly.phar'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Mover WP CLI a /bin
execute 'Move WP CLI' do
  command 'mv /tmp/wp /bin/wp'
  not_if { ::File.exist?('/bin/wp') }
end

# Hacer WP CLI ejecutable
file '/bin/wp' do
  mode '0755'
end

# Asignación de variables
wordpress_path = '/opt/wordpress/'
wordpress_url = '192.168.56.2'
wordpress_title = "HERRAMIENTRAS DE AUTOMATIZACIÓN DE DESPLIEGUES - Versión de Fanny Vargas"
admin_user = 'admin'
admin_password = 'Epnewman123'
admin_email = 'admin_belang3@yopmail.com'



execute 'Finish Wordpress installation' do
  command "sudo -u vagrant -i -- wp core install --path=#{wordpress_path} --url=#{wordpress_url} --title=\"#{wordpress_title}\" --admin_user=#{admin_user} --admin_password=\"#{admin_password}\" --admin_email=#{admin_email} --locale=es_ES"
  not_if 'wp core is-installed', environment: { 'PATH' => '/bin:/usr/bin:/usr/local/bin' }
end



# Instalar Wordpress y configurar - ORIGINAL
#execute 'Finish Wordpress installation' do
#  command 'sudo -u vagrant -i -- wp core install --path=/opt/wordpress/ --url=localhost --title="EPNEWMAN - Herramientas de automatización de despliegues" --admin_user=admin --admin_password="Epnewman123" --admin_email=admin@epnewman.edu.pe'
#  not_if 'wp core is-installed', environment: { 'PATH' => '/bin:/usr/bin:/usr/local/bin' }
#end

###
