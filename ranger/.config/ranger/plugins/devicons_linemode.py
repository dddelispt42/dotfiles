import os

terminal = terminal = os.getenv('TERM')
if terminal != 'linux':
    import ranger.api
    from devicons import *
    from ranger.core.linemode import LinemodeBase

    @ranger.api.register_linemode
    class DevIconsLinemode(LinemodeBase):
        name = 'devicons'

        uses_metadata = False

        def filetitle(self, file, metadata):
            return devicon(file) + ' ' + file.relative_path

    @ranger.api.register_linemode
    class DevIconsLinemodeFile(LinemodeBase):
        name = 'filename'

        def filetitle(self, file, metadata):
            return devicon(file) + ' ' + file.relative_path
