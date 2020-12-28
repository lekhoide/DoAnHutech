import static com.kms.katalon.core.checkpoint.CheckpointFactory.findCheckpoint
import static com.kms.katalon.core.testcase.TestCaseFactory.findTestCase
import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import static com.kms.katalon.core.testobject.ObjectRepository.findTestObject
import static com.kms.katalon.core.testobject.ObjectRepository.findWindowsObject
import com.kms.katalon.core.checkpoint.Checkpoint as Checkpoint
import com.kms.katalon.core.cucumber.keyword.CucumberBuiltinKeywords as CucumberKW
import com.kms.katalon.core.mobile.keyword.MobileBuiltInKeywords as Mobile
import com.kms.katalon.core.model.FailureHandling as FailureHandling
import com.kms.katalon.core.testcase.TestCase as TestCase
import com.kms.katalon.core.testdata.TestData as TestData
import com.kms.katalon.core.testobject.TestObject as TestObject
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
import com.kms.katalon.core.webui.keyword.WebUiBuiltInKeywords as WebUI
import com.kms.katalon.core.windows.keyword.WindowsBuiltinKeywords as Windows
import internal.GlobalVariable as GlobalVariable

WebUI.openBrowser('https://opensource-demo.orangehrmlive.com')

WebUI.setText(findTestObject('Page_OrangeHRM/input_LOGIN Panel_txtUsername'), '')

WebUI.setText(findTestObject('Page_OrangeHRM/input_Username_txtPassword'), '')

WebUI.click(findTestObject('Page_OrangeHRM/input_Password_Submit'))

WebUI.verifyElementVisible(findTestObject('Page_OrangeHRM/span_Username cannot be empty'))

'Đăng nhập - Với tên đăng nhập - Admin'
WebUI.setText(findTestObject('Page_OrangeHRM/input_LOGIN Panel_txtUsername'), 'Admin')

'Với mật khẩu - admin123'
WebUI.setText(findTestObject('Page_OrangeHRM/input_Username_txtPassword'), 'admin123')

'Kiểm tra Element này có trên giao diện'
WebUI.verifyElementVisible(findTestObject('Page_OrangeHRM/a_Forgot your password'))

'Bấm vào nút để đăng nhập'
WebUI.click(findTestObject('Page_OrangeHRM/input_Password_Submit'))

'Cần load thông tin nên để chạy nhanh hơn phải delay'
WebUI.delay(2)

'Khi đăng nhập thành công thì kiểm tra xem đã đến giao diện admin chưa bằng cách kiểm tra một Element có xuất hiện khi đăng nhập thành công'
WebUI.verifyElementText(findTestObject('Page_OrangeHRM/a_Welcome Admin'), 'Welcome lekhoide')

'Đóng trình duyệt kết thúc testcase'
WebUI.closeBrowser()

