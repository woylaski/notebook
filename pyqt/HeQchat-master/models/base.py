import PyQt5.QtCore

import models.helpers


@models.helpers.pyqtProperties(objectType=(str,))
class Object(PyQt5.QtCore.QObject):
	def __init__(self, parent):
		super(Object, self).__init__(parent)

	def data(self, role):
		propertyName = models.helpers.pyqtProperties._properties.get(role)
		if propertyName is None:
			return None

		return getattr(self, propertyName, None)

	def objectType(self):
		return type(self).__name__

	dataChanged = PyQt5.QtCore.pyqtSignal(int)


@models.helpers.pyqtProperties(count=(int,))
class List(PyQt5.QtCore.QAbstractListModel):
	def __init__(self, parent, **kwargs):
		super(List, self).__init__(parent)

		self._elements = []

		self._sortFunction = kwargs.get('sortFunction')

		self._lookupFunctions = {}
		self._lookupDicts = {}

	def registerLookupFunction(self, name, lookupFunction):
		self._lookupFunctions[name] = lookupFunction
		self._lookupDicts[name] = {lookupFunction(element): index for index, element in enumerate(self._elements)}

	def get(self, index):
		return self._elements[index]

	def indexOf(self, element):
		if len(self._lookupFunctions) > 0:
			return self.lookup(next(iter(self._lookupFunctions.keys())), element)[1]

		try:
			return self._elements.index(element)
		except ValueError:
			return -1

	def lookup(self, name, key):
		index = self._lookupDicts[name].get(key, -1)
		if index != -1:
			return self._elements[index], index
		else:
			return None, index

	def append(self, element):
		if self._sortFunction is not None:
			newElementSortOrder = self._sortFunction(element)
			i = 0
			for existingElement in self._elements:
				if self._sortFunction(existingElement) > newElementSortOrder:
					self.insert(i, element)
					return
				i += 1

		self.insert(self.count, element)

	def insert(self, index, element):
		self.beginInsertRows(PyQt5.QtCore.QModelIndex(), index, index)

		self._elements.insert(index, element)
		element.dataChanged.connect(self._onDataChanged)

		for lookupName, lookupFunction in self._lookupFunctions.items():
			lookupKey = lookupFunction(element)
			self._lookupDicts[lookupName][lookupKey] = index

		self.endInsertRows()

		self.countChanged.emit(self.count)

		return True

	def removeAt(self, index):
		self.beginRemoveRows(PyQt5.QtCore.QModelIndex(), index, index)

		element = self._elements.pop(index)
		element.dataChanged.disconnect(self._onDataChanged)

		for lookupName, lookupDict in self._lookupDicts.items():
			self._lookupDicts[lookupName] = {key: (value if value < index else value - 1) for key, value in lookupDict.items()}

		self.endRemoveRows()

		self.countChanged.emit(self.count)

	def remove(self, element):
		self.removeAt(self._elements.index(element))

	def count(self):
		return len(self._elements)

	def __iter__(self):
		return iter(self._elements)

	def _onDataChanged(self, role):
		element = self.sender()

		index = self.index(self._elements.index(element))
		self.dataChanged.emit(index, index, [role])

	def rowCount(self, parent=PyQt5.QtCore.QModelIndex()):
		return self.count

	def data(self, index, role=PyQt5.QtCore.Qt.DisplayRole):
		if not index.isValid():
			return None

		if index.row() < 0 or index.row() >= self.rowCount():
			return None

		return self._elements[index.row()].data(role)

	def roleNames(self):
		return models.helpers.pyqtProperties._properties
