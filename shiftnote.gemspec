Gem::Specification.new do |s|
  s.name = 'shiftnote'
  s.version = '0.2.0'
  s.summary = 'ShiftNote, an employee shift management system, but for Ruby.'
  s.description = 'ShiftNote, an employee shift management system, but for Ruby'
  s.authors = ['Chew']
  s.email = 'chew@chew.pw'
  s.files = Dir['lib/**/*.rb']
  s.homepage = 'https://github.com/Chew/ShiftNoteRB'
  s.license = 'MIT'
  s.add_runtime_dependency 'json', '>= 2.0.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.10.3'
  s.add_runtime_dependency 'rest-client', '~> 2.1.0.rc1'
  s.required_ruby_version = '>= 2.2.4'

  s.post_install_message = "Hello! Thanks for using this ShiftNote gem. 0.2.0 introduced some major changes.\nIf this is your first version you can just ignore this message.\n\n * ShiftNote#employee has been replaced with ShiftNote#user.\n * \"ViewModel\" has been removed from all class names.\n\nCheck the documentation server (https://rubydocs.chew.pro/docs/shiftnote) and the GitHub Release (https://github.com/Chew/ShiftNoteRB/releases/tag/0.2.0) to see the full changes!\nEnjoy :)"

  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/Chew/ShiftNoteRB/issues',
    'changelog_uri' => 'https://github.com/Chew/ShiftNoteRB/releases',
    'documentation_uri' => 'https://rubydocs.chew.pro/docs/shiftnote',
    'homepage_uri' => 'http://github.com/Chew/ShiftNoteRB',
    'source_code_uri' => 'http://github.com/Chew/ShiftNoteRB',
    'wiki_uri' => 'http://github.com/Chew/ShiftNoteRB/wiki'
  }
end
