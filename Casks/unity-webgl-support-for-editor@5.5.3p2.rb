cask 'unity-webgl-support-for-editor@5.5.3p2' do
  version '5.5.3p2,f15b2772e4d0'
  sha256 '5f6eeb246516cb6995916df1825624d4bee0a00a5b8e2bb57cd6a3898933d275'

  url "http://beta.unity3d.com/download/f15b2772e4d0/MacEditorTargetInstaller/UnitySetup-WebGL-Support-for-Editor-5.5.3p2.pkg"
  name 'Unity WebGL Build Support'
  homepage 'https://unity3d.com/unity/'

  depends_on cask: 'unity@5.5.3p2'

  pkg "UnitySetup-WebGL-Support-for-Editor-#{version.before_comma}.pkg"

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

  uninstall pkgutil: 'com.unity3d.WebGLSupport'
end
