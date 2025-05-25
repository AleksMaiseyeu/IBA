import unittest

from FullName import full_name


class MyTestCase(unittest.TestCase):

    def test_normal(self):
        self.assertEqual(
            full_name('Моисеев',
                           'Александр',
                           'Николаевич'),
            'Моисеев Александр Николаевич'
        )

    def test_big(self):
        self.assertEqual(
            full_name('МОИСЕЕВ',
                           'АЛЕКСАНДР',
                           'НИКОЛАЕВИЧ'),
            'Моисеев Александр Николаевич'
        )

    def test_small(self):
        self.assertEqual(
            full_name('моисеев',
                           'александр',
                           'николаевич'),
            'Моисеев Александр Николаевич'
        )

if __name__ == '__main__':
    unittest.main()
