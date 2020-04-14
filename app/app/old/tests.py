from django.test import TestCase
from app.calc import add, subtract


class CalcTests(TestCase):
    # In order to be tested, functions must start with "test_"
    def test_add_numbers(self):
        """Test that two numbers are added together"""
        # Setup stage
        # Assertion stage: test the output
        self.assertEqual(add(3, 8), 11)

    def test_subtract_numbers(self):
        """Test that values are subracted and returned"""
        self.assertEqual(subtract(5, 11), 6)
