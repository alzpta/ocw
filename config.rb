activate :automatic_image_sizes
activate :directory_indexes

# Default directories
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

# Sprockets supports Bower, so we can add Bower components path directly:
sprockets.append_path File.join root, 'vendor', 'bower_components'
sprockets.append_path File.join root, 'vendor', 'css'
sprockets.append_path File.join root, 'vendor', 'js'

# Ignore non-root coffee and sass files
ignore 'js/src/*'
ignore 'css/src/*'

# internationalization
activate :i18n

# Development-specific configuration
configure :development do
  # Reload on assets change
  # activate :livereload
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Use relative URLs
  activate :relative_assets
end

# Dynamic pages
data.courses.catalog.each do |course|
  course.topics.each do |topic|
    slug = "#{topic.name} #{topic.id}".slugify
    proxy "/courses/#{slug}.html", 'course.html', locals: {course: course, topic: topic}, ignore: true
  end
end

# data.courses.catalog.map(&:department).uniq.each do |department|
#   slug = department.slugify
#   proxy "/departments/#{slug}.html", 'department.html', locals: {department: department, slug: slug}, ignore: true
# end

# Pagination for courses
activate :pagination do
  pageable_set :topics do
    data.courses.catalog.map do |c| 
      c.topics.map do |t|
        OpenStruct.new({
          id: t.id,
          name: t.name,
          author: c.author,
          image: c.image,
          url: "/courses/" + "#{t.name} #{t.id}".slugify
        })
      end
    end.flatten
  end
end