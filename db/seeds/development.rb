# Creates the test tag
tag = ToolTag.create!(name: 'test-tag')

# Create a test container
Container.create!(tool_tag: tag)
