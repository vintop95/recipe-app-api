from django.test import TestCase, Client
from django.contrib.auth import get_user_model
# generate urls from django admin page
from django.urls import reverse


class AdminSiteTests(TestCase):

    def setUp(self):
        self.client = Client()
        self.admin_user = get_user_model().objects.create_superuser(
            email='admin@test.com',
            password='password123'
        )
        self.client.force_login(self.admin_user)
        self.user = get_user_model().objects.create_user(
            email='test@test.com',
            password='password123',
            name='Test user full name'
        )

    def test_user_listed(self):
        """Test that users are listed on user page"""
        # reverse() usage: reverse('app:url')
        url = reverse('admin:core_user_changelist')
        res = self.client.get(url)

        # assertContains checks that res contains the self item
        # checks also that the res is 200
        self.assertContains(res, self.user.name)
        self.assertContains(res, self.user.email)

    def test_user_change_page(self):
        """Test that the user edit page works"""
        # /admin/core/user/{userId}
        url = reverse('admin:core_user_change', args=[self.user.id])
        res = self.client.get(url)

        self.assertEqual(res.status_code, 200)

    def test_create_user_page(self):
        """Test that the create user page works"""
        url = reverse('admin:core_user_add')
        res = self.client.get(url)

        self.assertEqual(res.status_code, 200)
