from unittest import TestCase


from graphitepager.alerts import Alert
from graphitepager.level import Level
from graphitepager.graphite_data_record import NoDataError

ALERT_INC = {
    'target': 'TARGET',
    'warning': 1,
    'critical': 2,
    'name': 'NAME',
}
ALERT_DEC = {
    'target': 'TARGET',
    'warning': 2,
    'critical': 1,
    'name': 'NAME',
}
ALERT_FROM = {
    'target': 'TARGET',
    'warning': 1,
    'critical': 2,
    'name': 'NAME',
    'from': '-5min',
}
ALERT_WITHOUT_FROM = ALERT_INC
ALERT_WITH_EXCLUDE = {
    'target': 'TARGET',
    'warning': 1,
    'critical': 2,
    'name': 'NAME',
    'exclude': ['exclude_1']
}


class _BaseTestCase(TestCase):

    def assert_check_value_returns_item_for_value(self, value, check_return):
        class Record(object):
            target = 'name'

            def get_last_value(self):
                return value
        level, value = self.alert.check_record(Record())
        self.assertEqual(level, check_return)


class TestDocUrl(TestCase):

    def test_url_with_no_base_url_is_none(self):
        alert = Alert(ALERT_INC)
        self.assertEqual(alert.documentation_url(), None)

    def test_url_with_base_includes_name(self):
        base = 'http://example.com'
        alert = Alert(ALERT_INC, doc_url=base)
        url = '{0}/{1}'.format(base, ALERT_INC['name'])
        self.assertEqual(alert.documentation_url(), url)

    def test_url_with_base_and_target(self):
        base = 'http://example.com'
        alert = Alert(ALERT_INC, doc_url=base)
        url = '{0}/{1}#{2}'.format(
            base,
            ALERT_INC['name'],
            ALERT_INC['target'])
        self.assertEqual(alert.documentation_url(ALERT_INC['target']), url)


class TestAlertIncreasing(_BaseTestCase):

    def setUp(self):
        self.alert = Alert(ALERT_INC)

    def test_name_matches(self):
        self.assertEqual(self.alert.get('name'), ALERT_INC['name'])

    def test_target_matches(self):
        self.assertEqual(self.alert.get('target'), ALERT_INC['target'])

    def test_warning_matches(self):
        self.assertEqual(self.alert.get('warning'), ALERT_INC['warning'])

    def test_critical_matches(self):
        self.assertEqual(self.alert.get('critical'), ALERT_INC['critical'])

    def test_should_return_none_for_low_value(self):
        self.assert_check_value_returns_item_for_value(0, Level.NOMINAL)

    def test_should_return_warning_for_warning_value(self):
        self.assert_check_value_returns_item_for_value(
            self.alert.get('warning'), Level.WARNING)

    def test_should_return_warning_for_mid_value(self):
        self.assert_check_value_returns_item_for_value(1.5, Level.WARNING)

    def test_should_return_critical_for_critical_value(self):
        self.assert_check_value_returns_item_for_value(2, Level.CRITICAL)

    def test_should_return_critical_for_high_value(self):
        self.assert_check_value_returns_item_for_value(3, Level.CRITICAL)


class TestAlertDescreasing(_BaseTestCase):

    def setUp(self):
        self.alert = Alert(ALERT_DEC)

    def test_name_matches(self):
        self.assertEqual(self.alert.get('name'), ALERT_DEC['name'])

    def test_target_matches(self):
        self.assertEqual(self.alert.get('target'), ALERT_DEC['target'])

    def test_warning_matches(self):
        self.assertEqual(self.alert.get('warning'), ALERT_DEC['warning'])

    def test_critical_matches(self):
        self.assertEqual(self.alert.get('critical'), ALERT_DEC['critical'])

    def test_should_return_critical_for_low_value(self):
        self.assert_check_value_returns_item_for_value(0, Level.CRITICAL)

    def test_should_return_critical_for_critical_value(self):
        self.assert_check_value_returns_item_for_value(
            self.alert.get('critical'), Level.CRITICAL)

    def test_should_return_warning_for_mid_value(self):
        self.assert_check_value_returns_item_for_value(1.5, Level.WARNING)

    def test_should_return_warning_for_warning_value(self):
        self.assert_check_value_returns_item_for_value(
            self.alert.get('warning'), Level.WARNING)

    def test_should_return_none_for_high_value(self):
        self.assert_check_value_returns_item_for_value(3, Level.NOMINAL)


class TestAlertHasNoData(_BaseTestCase):

    def setUp(self):
        self.alert = Alert(ALERT_DEC)

    def test_should_return_no_data_for_no_data(self):
        class Record(object):
            target = 'name'

            def get_last_value(self):
                raise NoDataError()

        level, value = self.alert.check_record(Record())
        self.assertEqual(level, 'NO DATA')


class TestAlertisExcluded(_BaseTestCase):

    def setUp(self):
        self.alert = Alert(ALERT_WITH_EXCLUDE)

    def test_should_return_no_data_for_no_data(self):
        class Record(object):
            target = 'exclude_1'

            def get_last_value(self):
                raise NoDataError()

        level, value = self.alert.check_record(Record())
        self.assertEqual(level, Level.NOMINAL)
        self.assertEqual(value, 'Excluded')


class TestValueForLevel(_BaseTestCase):

    def setUp(self):
        self.alert = Alert(ALERT_INC)

    def test_nominal_returns_warning_value(self):
        self.assertEqual(
            self.alert.value_for_level(Level.NOMINAL),
            self.alert.get('warning'))

    def test_warning_returns_warning_value(self):
        self.assertEqual(
            self.alert.value_for_level(Level.WARNING),
            self.alert.get('warning'))

    def test_critical_returns_critical_value(self):
        self.assertEqual(
            self.alert.value_for_level(Level.CRITICAL),
            self.alert.get('critical'))

    def test_unknown_level_returns_none(self):
        self.assertEqual(self.alert.value_for_level('unkown level'), None)


class TestAlertWithoutFrom(_BaseTestCase):

    def setUp(self):
        self.alert = Alert(ALERT_WITHOUT_FROM)

    def test_should_have_default_from_time_of_1_min(self):
        self.assertEqual(self.alert.get('from'), '-1min')


class TestAlertWithFrom(_BaseTestCase):

    def setUp(self):
        self.alert = Alert(ALERT_FROM)

    def test_should_have_default_from_time_of_1_min(self):
        self.assertEqual(self.alert.get('from'), ALERT_FROM['from'])
