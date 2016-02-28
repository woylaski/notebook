from unittest import TestCase

from graphitepager.graphite_data_record import (
    GraphiteDataRecord,
    NoDataError
)


SAMPLE_FINE = 'stat.one,1348346250,1348346310,10|1.0,2.0,3.0,4.0'
SAMPLE_NONE = 'stat.one,1348346250,1348346310,10|1.0,None'
SAMPLE_ALL_NONES = 'stat.one,1348346250,1348346310,10|None,None'
SAMPLE_COMMA = ','.join([
    'scale(redis.number_of_lists,1.0)',
    '1348346250',
    '1348346310',
    '10|1.0,2.0,3.0,4.0'
])


class _BaseTest(TestCase):

    def setUp(self):
        self.record = GraphiteDataRecord(self.data)

    def test_metric_name(self):
        self.assertEqual(self.record.target, 'stat.one')

    def test_start_time(self):
        self.assertEqual(self.record.start_time, 1348346250)

    def test_end_time(self):
        self.assertEqual(self.record.end_time, 1348346310)

    def test_step(self):
        self.assertEqual(self.record.step, 10)


class TestGraphiteDataRecord(_BaseTest):

    data = SAMPLE_FINE

    def test_average_is_correct(self):
        self.assertEqual(self.record.get_average(), 2.5)

    def test_latest_value_is_correct(self):
        self.assertEqual(self.record.get_last_value(), 4.0)


class TestGraphiteDataRecordWithMissingData(_BaseTest):

    data = SAMPLE_NONE

    def test_average_is_correct(self):
        self.assertEqual(self.record.get_average(), 1.0)

    def test_latest_value_is_correct(self):
        self.assertEqual(self.record.get_last_value(), 1.0)


class TestGraphiteDataRecordWithNonesAsData(_BaseTest):

    data = SAMPLE_ALL_NONES

    def test_avg_raises_no_data_error(self):
        self.assertRaises(NoDataError, self.record.get_average)

    def test_last_value_is_data_error(self):
        self.assertRaises(NoDataError, self.record.get_last_value)


class TestGraphitDataRecordWithComma(_BaseTest):

    data = SAMPLE_COMMA

    def test_metric_name(self):
        self.assertEqual(
            self.record.target,
            'scale(redis.number_of_lists,1.0)')
