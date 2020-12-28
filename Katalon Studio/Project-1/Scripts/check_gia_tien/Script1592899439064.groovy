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
import org.openqa.selenium.Keys as Keys
import com.kms.katalon.core.annotation.Keyword as Keyword
import java.sql.ResultSet as ResultSet
import org.openqa.selenium.By
import org.openqa.selenium.WebDriver
import org.openqa.selenium.chrome.ChromeDriver
import java.sql.Connection
import java.sql.DriverManager
import java.sql.Statement
import java.sql.ResultSet
import java.sql.SQLException
import static com.kms.katalon.core.testobject.ObjectRepository.findTestObject
import com.kms.katalon.core.webui.keyword.WebUiBuiltInKeywords as WebUI
import org.openqa.selenium.WebDriver as WebDriver

WebUI.openBrowser('')

WebUI.navigateToUrl('http://localhost/PHP/DeTaiMonHocPHP/list_games_admin.php')

WebUI.click(findTestObject('Object Repository/Page_1337 Games Martketplace/a_To Game'))

WebUI.setText(findTestObject('Object Repository/Page_1337 Games Martketplace/input_Tn Game_txtTenGame'), 'Kiểm thử cơ sở dữ liệu')

WebUI.setText(findTestObject('Object Repository/Page_1337 Games Martketplace/input_Gi Game_txtGiaGame'), '-100000')

WebUI.selectOptionByValue(findTestObject('Object Repository/Page_1337 Games Martketplace/select_Mi bn chn danh mc GameGame trn Steam_db5953'), 
    '2', true)

WebUI.click(findTestObject('Object Repository/Page_1337 Games Martketplace/button_Thm Game'))

'Cần load thông tin nên để chạy nhanh hơn phải delay'
WebUI.delay(2)

WebUI.verifyElementText(findTestObject('Page_1337 Games Martketplace/h4_Mi bn nhp li Gi Game'), 'Mời bạn nhập lại Giá Game')

WebUI.delay(5)

CustomKeywords.'database.ConnectDB.connectDB'('localhost', '3306', '1337', 'root', '')

String query = 'INSERT INTO `game`(`TenGame`,`GiaGame`,`DanhMucID`) VALUES ("Kiểm thử cơ sở dữ liệu bảng KS",100000,1)'

ResultSet result = CustomKeywords.'database.ConnectDB.executeQuery'(query)

//sử dụng ResultSet để lấy kết quả trả về
result.first()

if(result.next()){
	int countProducts = result.getInt(1)
}


WebDriver driver = DriverFactory.getWebDriver()

//so sánh kết quả giữa Database và trên màn hình
if (countProducts == driver.findElements(By.xpath('//*[@class=\'card-body text-center\']')).size()) {
    println('Passed!')
} else {
    println('Failed!')
}

//CustomKeywords.'database.ConnectDB.executeQuery'('INSERT INTO `game`(`TenGame`,`GiaGame`,`DanhMucID`) VALUES ("Kiểm thử cơ sở dữ liệu bảng KS",-100000,1)')
WebUI.closeBrowser()

