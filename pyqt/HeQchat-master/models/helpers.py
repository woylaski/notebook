import PyQt5.QtCore


def pyqtProperties(**properties):
	def addPyqtProperties(cls):
		attrs = dict(cls.__dict__)

		for propertyName in properties.keys():
			if pyqtProperties._roles.get(propertyName) is None:
				newRole = PyQt5.QtCore.Qt.UserRole + 1 + len(pyqtProperties._roles)
				pyqtProperties._roles[propertyName] = newRole
				pyqtProperties._properties[newRole] = propertyName

		for item in properties.items():
			def scope():
				propertyName, (propertyType, *attributes) = item
				attributes = attributes[0] if len(attributes) > 0 else {}
				writeable = attributes.get('writeable', False)

				def getter(self):
					return getattr(self, '_' + propertyName)

				if attrs.get(propertyName) is not None:
					getter = attrs.get(propertyName)

				propertyChangedSignal = PyQt5.QtCore.pyqtSignal(propertyType)
				attrs[propertyName + 'Changed'] = propertyChangedSignal

				attrs[propertyName] = PyQt5.QtCore.pyqtProperty(propertyType, notify=propertyChangedSignal)(getter)

				if writeable:
					role = pyqtProperties._roles[propertyName]
					def setter(self, value):
						setattr(self, '_' + propertyName, value)

						getattr(self, propertyName + 'Changed').emit(value)
						self.dataChanged.emit(role)

					attrs[propertyName] = attrs[propertyName].setter(setter)

			scope()

		originalInit = attrs['__init__']

		changeableProperties = [propertyName for propertyName, (propertyType, *attributes) in properties.items() if hasattr(propertyType, 'dataChanged') and len(attributes) > 0 and not attributes[0].get('constant', False)]

		def newInit(self, *args, **kwargs):
			originalInit(self, *args, **kwargs)

			for propertyName in changeableProperties:
				role = pyqtProperties._roles[propertyName]
				getattr(self, propertyName).dataChanged.connect(lambda: self.dataChanged.emit(role))

		attrs['__init__'] = newInit

		return type(cls.__name__, cls.__bases__, attrs)

	return addPyqtProperties

pyqtProperties._roles = {}
pyqtProperties._properties = {}


@pyqtProperties(cls=(str,), name=(str,), value=(str,))
class EnumMember(PyQt5.QtCore.QObject):
	def __init__(self, cls, name, value):
		super(EnumMember, self).__init__(None)

		self._cls = cls
		self._name = name
		self._value = value

	def __str__(self):
		return '{0}.{1}'.format(self.cls, self.name)

	def __repr__(self):
		return '<{0}.{1}: {2}>'.format(self.cls, self.name, self.value)

def enum(cls):
	members = {name: EnumMember(cls.__name__, name, value if value is not None else name.upper()) for name, value in cls.__dict__.items() if name[0] != '_'}
	values = {member.value: member for member in members.values()}

	def new(cls, value):
		return values[value]

	attrs = { '__new__': new , '__members__': members }
	for member in members.values():
		attrs[member.name] = member

	return type(cls.__name__, (), attrs)
