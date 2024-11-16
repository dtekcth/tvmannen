# All FlaskForm forms

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, SelectField, FileField, BooleanField
from wtforms.fields.html5 import DateField
from wtforms.validators import DataRequired, ValidationError, EqualTo, Length
from data import User

roles = [('admin', "Admin"), ('pr', "PR")]

class LoginForm(FlaskForm):
  username = StringField('Username:', validators=[DataRequired()])
  password = PasswordField('Password:', validators=[DataRequired()])
  submit = SubmitField('Sign In')


class RegistrationForm(FlaskForm):
  username = StringField('Username:',
    validators=[DataRequired(), Length(min=1, max=64)])
  
  password = PasswordField('Password:',
    validators=[DataRequired()])
  
  password2 = PasswordField('Repeat Password:',
    validators=[DataRequired(), EqualTo('password')])
  
  role = SelectField("Role:", 
    validators=[DataRequired()], choices=roles)
  
  submit = SubmitField('Create user')

  def validate_username(self, username):
      user = User.query.filter_by(username=username.data).first()
      if user is not None:
          raise ValidationError('Username already taken')

class PRForm(FlaskForm):
  file = FileField(label="File:")

  link = StringField(label="Link:",
    render_kw={"placeholder": "https://google.com"})

  desc = StringField("Description:",
    validators=[DataRequired(), Length(min=1, max=128)],
    render_kw={"placeholder": "Hackkväll 24/12"})
  
  start_date = DateField("Start date:",
    validators=[DataRequired()])
  
  end_date = DateField("End date:",
    validators=[DataRequired()])
  
  priority = BooleanField("Priority:")
  submit = SubmitField('Upload PR')

class ModifyUserForm(FlaskForm):
  password = PasswordField('Password:', 
    validators=[DataRequired()])

  password2 = PasswordField('Repeat Password:',
    validators=[DataRequired(), EqualTo('password')])
  
  role = SelectField("Role:",
    validators=[DataRequired()], choices=roles)
  
  submit = SubmitField('Save changes')


class ChangePasswordForm(FlaskForm):
  password = PasswordField('Password:', 
    validators=[DataRequired()])

  password2 = PasswordField('Repeat Password:', 
    validators=[DataRequired(), EqualTo('password')])
  
  submit = SubmitField('Save changes')

class ModifyPRForm(FlaskForm):
  start_date = DateField("Start date:",
    validators=[DataRequired()])

  end_date = DateField("End date:", 
    validators=[DataRequired()])

  priority = BooleanField("Priority:")
  submit = SubmitField('Save changes')
