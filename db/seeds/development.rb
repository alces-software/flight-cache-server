# Creates the test tag
tag = ToolTag.create!(name: 'test-tag')

# Create a test container
Container.create!(tool_tag: tag)

# Creates the admin user
User.create!(email: "admin@example.com", global_admin: true)

# Creates the regular user
User.create!(email: "user@example.com", global_admin: true)
