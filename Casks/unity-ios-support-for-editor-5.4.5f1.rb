cask 'unity-ios-support-for-editor-5.4.5f1' do
  version '5.4.5f1,68943b6c8c42'
  sha256 '4cf1483ac0080e2a57a07c790a8d5741b0ed126495be1bacea39f7a2f63456ae'

  url "http://netstorage.unity3d.com/unity/#{version.after_comma}/MacEditorTargetInstaller/UnitySetup-iOS-Support-for-Editor-#{version.before_comma}.pkg"
  name 'Unity iOS Build Support'
  homepage 'https://unity3d.com/unity/'

  depends_on cask: 'unity-5.4.5f1'

  pkg "UnitySetup-iOS-Support-for-Editor-#{version.before_comma}.pkg"

  preflight do
    if File.exist? '/Applications/Unity'
      FileUtils.move '/Applications/Unity', '/Applications/Unity.temp'
    end

    if File.exist? "/Applications/Unity-#{@cask.version.before_comma}"
      FileUtils.move "/Applications/Unity-#{@cask.version.before_comma}", '/Applications/Unity'
    end
  end

  postflight do
    if File.exist? '/Applications/Unity'
      FileUtils.move '/Applications/Unity', "/Applications/Unity-#{@cask.version.before_comma}"
    end

    if File.exist? '/Applications/Unity.temp'
      FileUtils.move '/Applications/Unity.temp', '/Applications/Unity'
    end
  end

  uninstall_preflight do
    if File.exist? '/Applications/Unity'
      FileUtils.move '/Applications/Unity', '/Applications/Unity.temp'
    end

    if File.exist? "/Applications/Unity-#{@cask.version.before_comma}"
      FileUtils.move "/Applications/Unity-#{@cask.version.before_comma}", '/Applications/Unity'
    end
  end

  uninstall_postflight do
    if File.exist? '/Applications/Unity'
      FileUtils.move '/Applications/Unity', "/Applications/Unity-#{@cask.version.before_comma}"
    end

    if File.exist? '/Applications/Unity.temp'
      FileUtils.move '/Applications/Unity.temp', '/Applications/Unity'
    end
  end

  uninstall pkgutil: 'com.unity3d.iOSSupport'
end
