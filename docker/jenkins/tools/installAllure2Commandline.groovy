import ru.yandex.qatools.allure.jenkins.tools.*
import hudson.tools.InstallSourceProperty
import hudson.tools.ToolProperty
import hudson.tools.ToolPropertyDescriptor
import hudson.util.DescribableList

def isp = new InstallSourceProperty()
def autoInstaller = new AllureCommandlineInstaller("2.6.0")
isp.installers.add(autoInstaller)

def proplist = new DescribableList<ToolProperty<?>, ToolPropertyDescriptor>()
proplist.add(isp)

def installation = new AllureCommandlineInstallation("allure260", "", proplist)


def allureDesc = jenkins.model.Jenkins.instance.getExtensionList(AllureCommandlineInstallation.DescriptorImpl.class)[0]


allureDesc.setInstallations(installation)
allureDesc.save()