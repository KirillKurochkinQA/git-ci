import os
import allure
import pytest
from dotenv import load_dotenv
load_dotenv()

@allure.epic("example")
@allure.feature("feature")
class TestExample:

    @pytest.mark.smoke
    @allure.title("Test Smoke Example")
    def test_example(self):
        with allure.step("Open page"):
            self.driver.get(os.getenv("STAGE"))
            allure.attach(
                self.driver.get_screenshot_as_png(),
                name="screenshot example 1",
                attachment_type=allure.attachment_type.PNG,
            )

    @pytest.mark.regression
    @allure.title("Test Regression Example")
    def test_example_2(self):
        with allure.step("Open page"):
            self.driver.get(os.getenv("STAGE"))
            allure.attach(
                self.driver.get_screenshot_as_png(),
                name="screenshot example 2",
                attachment_type=allure.attachment_type.PNG,
            )