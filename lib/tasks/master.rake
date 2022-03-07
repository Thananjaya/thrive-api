desc 'Resetting the database'

task master: [
	'db:create',
	'db:migrate'
]