# Creates the test tag
tag = Tag.create!(name: 'test-tag')

# Creates the group
group = Group.create!(name: 'test-group')

# Create a test container
Container.create!(tag: tag, group: group)

# Creates the admin user
User.create!(email: "admin@example.com", global_admin: true)

# Creates the regular user
User.create!(email: "user@example.com", group: group)
