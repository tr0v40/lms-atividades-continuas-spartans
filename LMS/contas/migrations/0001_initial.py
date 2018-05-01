# Generated by Django 2.0.4 on 2018-05-01 17:22

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Aluno',
            fields=[
                ('idaluno', models.AutoField(db_column='idAluno', primary_key=True, serialize=False)),
                ('logon', models.CharField(blank=True, max_length=20, null=True, unique=True)),
                ('senha', models.CharField(max_length=20)),
                ('nome', models.CharField(max_length=30)),
                ('email', models.CharField(max_length=40, unique=True)),
                ('celular', models.CharField(blank=True, max_length=9, null=True, unique=True)),
                ('foto', models.CharField(blank=True, max_length=255, null=True)),
                ('dtexpiracao', models.DateField(blank=True, db_column='dtExpiracao', null=True)),
                ('ra', models.CharField(blank=True, max_length=20, null=True)),
            ],
            options={
                'db_table': 'aluno',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Coordenador',
            fields=[
                ('idcoordenador', models.AutoField(db_column='idCoordenador', primary_key=True, serialize=False)),
                ('logon', models.CharField(blank=True, max_length=20, null=True, unique=True)),
                ('senha', models.CharField(max_length=20)),
                ('nome', models.CharField(max_length=30)),
                ('email', models.CharField(max_length=40, unique=True)),
                ('celular', models.CharField(blank=True, max_length=9, null=True, unique=True)),
                ('dtexpiracao', models.DateField(blank=True, db_column='dtExpiracao', null=True)),
            ],
            options={
                'db_table': 'coordenador',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Mensagem',
            fields=[
                ('idmensagem', models.AutoField(db_column='idMensagem', primary_key=True, serialize=False)),
                ('assunto', models.CharField(blank=True, max_length=1000, null=True)),
                ('referencia', models.CharField(blank=True, max_length=1000, null=True)),
                ('conteudo', models.CharField(blank=True, max_length=1000, null=True)),
                ('status', models.CharField(blank=True, max_length=50, null=True)),
                ('dtenvio', models.DateField(blank=True, db_column='dtEnvio', null=True)),
                ('dtresposta', models.DateField(db_column='dtResposta')),
                ('resposta', models.CharField(blank=True, max_length=1000, null=True)),
            ],
            options={
                'db_table': 'mensagem',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Professor',
            fields=[
                ('idprofessor', models.AutoField(db_column='idProfessor', primary_key=True, serialize=False)),
                ('logon', models.CharField(blank=True, max_length=20, null=True, unique=True)),
                ('senha', models.CharField(max_length=20)),
                ('nome', models.CharField(max_length=30)),
                ('email', models.CharField(max_length=40, unique=True)),
                ('celular', models.CharField(blank=True, max_length=9, null=True, unique=True)),
                ('dtexpiracao', models.DateField(blank=True, db_column='dtExpiracao', null=True)),
                ('apelido', models.CharField(blank=True, max_length=20, null=True)),
            ],
            options={
                'db_table': 'professor',
                'managed': False,
            },
        ),
    ]