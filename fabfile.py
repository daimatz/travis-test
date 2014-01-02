from fabric.api import run

@task
def provision():
    run('echo provision')
