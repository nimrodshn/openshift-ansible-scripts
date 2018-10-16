from jinja2 import Template
import sys
import yaml

# get template file name from user
template_name = sys.argv[1]
# get variables file name from user
variable_name = sys.argv[2]

# load template from file system
with open(template_name) as file_:
    t = Template(file_.read())

# load variables yaml file.
variables = yaml.load(open(variable_name))

# process template
print(t.render(variables))
