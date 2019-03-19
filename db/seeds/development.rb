# Creates the test tag
tag = AccessTag.create!(name: 'test-tag')

# Creates the group
group = Group.create!(name: 'test-group')

# Create a test container
Container.create!(access_tag: tag, group: group)

# Creates the admin user
User.create!(email: "admin@example.com", global_admin: true)

# Creates the regular user
User.create!(email: "user@example.com", group: group)
