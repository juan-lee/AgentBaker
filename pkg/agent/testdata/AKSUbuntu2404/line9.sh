#!/bin/bash
ERR_SYSTEMCTL_START_FAIL=4 
ERR_CLOUD_INIT_TIMEOUT=5 
ERR_FILE_WATCH_TIMEOUT=6 
ERR_HOLD_WALINUXAGENT=7 
ERR_RELEASE_HOLD_WALINUXAGENT=8 
ERR_APT_INSTALL_TIMEOUT=9 
ERR_DOCKER_INSTALL_TIMEOUT=20 
ERR_DOCKER_DOWNLOAD_TIMEOUT=21 
ERR_DOCKER_KEY_DOWNLOAD_TIMEOUT=22 
ERR_DOCKER_APT_KEY_TIMEOUT=23 
ERR_DOCKER_START_FAIL=24 
ERR_MOBY_APT_LIST_TIMEOUT=25 
ERR_MS_GPG_KEY_DOWNLOAD_TIMEOUT=26 
ERR_MOBY_INSTALL_TIMEOUT=27 
ERR_CONTAINERD_INSTALL_TIMEOUT=28 
ERR_RUNC_INSTALL_TIMEOUT=29 
ERR_K8S_RUNNING_TIMEOUT=30 
ERR_K8S_DOWNLOAD_TIMEOUT=31 
ERR_KUBECTL_NOT_FOUND=32 
ERR_IMG_DOWNLOAD_TIMEOUT=33 
ERR_KUBELET_START_FAIL=34 
ERR_DOCKER_IMG_PULL_TIMEOUT=35 
ERR_CONTAINERD_CTR_IMG_PULL_TIMEOUT=36 
ERR_CONTAINERD_CRICTL_IMG_PULL_TIMEOUT=37 
ERR_CONTAINERD_INSTALL_FILE_NOT_FOUND=38 
ERR_CONTAINERD_VERSION_INVALID=39 
ERR_CNI_DOWNLOAD_TIMEOUT=41 
ERR_MS_PROD_DEB_DOWNLOAD_TIMEOUT=42 
ERR_MS_PROD_DEB_PKG_ADD_FAIL=43 
ERR_ORAS_DOWNLOAD_ERROR=45 
ERR_SYSTEMD_INSTALL_FAIL=48 
ERR_MODPROBE_FAIL=49 
ERR_OUTBOUND_CONN_FAIL=50 
ERR_K8S_API_SERVER_CONN_FAIL=51 
ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL=52 
ERR_K8S_API_SERVER_AZURE_DNS_LOOKUP_FAIL=53 
ERR_KATA_KEY_DOWNLOAD_TIMEOUT=60 
ERR_KATA_APT_KEY_TIMEOUT=61 
ERR_KATA_INSTALL_TIMEOUT=62 
ERR_VHD_FILE_NOT_FOUND=65 
ERR_CONTAINERD_DOWNLOAD_TIMEOUT=70 
ERR_RUNC_DOWNLOAD_TIMEOUT=71 
ERR_CUSTOM_SEARCH_DOMAINS_FAIL=80 
ERR_GPU_DOWNLOAD_TIMEOUT=83 
ERR_GPU_DRIVERS_START_FAIL=84 
ERR_GPU_DRIVERS_INSTALL_TIMEOUT=85 
ERR_GPU_DEVICE_PLUGIN_START_FAIL=86 
ERR_GPU_INFO_ROM_CORRUPTED=87 
ERR_SGX_DRIVERS_INSTALL_TIMEOUT=90 
ERR_SGX_DRIVERS_START_FAIL=91 
ERR_APT_DAILY_TIMEOUT=98 
ERR_APT_UPDATE_TIMEOUT=99 
ERR_CSE_PROVISION_SCRIPT_NOT_READY_TIMEOUT=100 
ERR_APT_DIST_UPGRADE_TIMEOUT=101 
ERR_APT_PURGE_FAIL=102 
ERR_SYSCTL_RELOAD=103 
ERR_CIS_ASSIGN_ROOT_PW=111 
ERR_CIS_ASSIGN_FILE_PERMISSION=112 
ERR_PACKER_COPY_FILE=113 
ERR_CIS_APPLY_PASSWORD_CONFIG=115 
ERR_SYSTEMD_DOCKER_STOP_FAIL=116 
ERR_CRICTL_DOWNLOAD_TIMEOUT=117 
ERR_CRICTL_OPERATION_ERROR=118 
ERR_CTR_OPERATION_ERROR=119 

ERR_AZURE_STACK_GET_ARM_TOKEN=120 
ERR_AZURE_STACK_GET_NETWORK_CONFIGURATION=121 
ERR_AZURE_STACK_GET_SUBNET_PREFIX=122 

ERR_VHD_BUILD_ERROR=125 

ERR_SWAP_CREATE_FAIL=130 
ERR_SWAP_CREATE_INSUFFICIENT_DISK_SPACE=131 

ERR_TELEPORTD_DOWNLOAD_ERR=150 
ERR_TELEPORTD_INSTALL_ERR=151 
ERR_ARTIFACT_STREAMING_DOWNLOAD=152 
ERR_ARTIFACT_STREAMING_INSTALL=153 

ERR_HTTP_PROXY_CA_CONVERT=160 
ERR_UPDATE_CA_CERTS=161 
ERR_DOWNLOAD_SECURE_TLS_BOOTSTRAP_KUBELET_EXEC_PLUGIN_TIMEOUT=169 

ERR_DISBALE_IPTABLES=170 

ERR_KRUSTLET_DOWNLOAD_TIMEOUT=171 
ERR_DISABLE_SSH=172 
ERR_PRIMARY_NIC_IP_NOT_FOUND=173 
ERR_INSERT_IMDS_RESTRICTION_RULE_INTO_MANGLE_TABLE=174 
ERR_INSERT_IMDS_RESTRICTION_RULE_INTO_FILTER_TABLE=175 
ERR_DELETE_IMDS_RESTRICTION_RULE_FROM_MANGLE_TABLE=176 
ERR_DELETE_IMDS_RESTRICTION_RULE_FROM_FILTER_TABLE=177 

ERR_VHD_REBOOT_REQUIRED=200 
ERR_NO_PACKAGES_FOUND=201 
ERR_SNAPSHOT_UPDATE_START_FAIL=202 

ERR_PRIVATE_K8S_PKG_ERR=203 
ERR_K8S_INSTALL_ERR=204 

ERR_SYSTEMCTL_MASK_FAIL=2 

ERR_CREDENTIAL_PROVIDER_DOWNLOAD_TIMEOUT=205 

ERR_CNI_VERSION_INVALID=206 


ERR_ORAS_PULL_K8S_FAIL=207 
ERR_ORAS_PULL_FAIL_RESERVE_1=208 
ERR_ORAS_PULL_CONTAINERD_WASM=209 
ERR_ORAS_PULL_FAIL_RESERVE_2=210 
ERR_ORAS_PULL_NETWORK_TIMEOUT=211 
ERR_ORAS_PULL_UNAUTHORIZED=212 

ERR_LOOKUP_DISABLE_KUBELET_SERVING_CERTIFICATE_ROTATION_TAG=213

ERR_CLEANUP_CONTAINER_IMAGES=214

ERR_DNS_HEALTH_FAIL=215 

if find /etc -type f,l -name "*-release" -print -quit 2>/dev/null | grep -q '.'; then
    OS=$(sort -r /etc/*-release | gawk 'match($0, /^(ID_LIKE=(coreos)|ID=(.*))$/, a) { print toupper(a[2] a[3]); exit }')
    OS_VERSION=$(sort -r /etc/*-release | gawk 'match($0, /^(VERSION_ID=(.*))$/, a) { print toupper(a[2] a[3]); exit }' | tr -d '"')
else
    echo "/etc/*-release not found"
fi

UBUNTU_OS_NAME="UBUNTU"
MARINER_OS_NAME="MARINER"
MARINER_KATA_OS_NAME="MARINERKATA"
AZURELINUX_OS_NAME="AZURELINUX"
KUBECTL=/usr/local/bin/kubectl
DOCKER=/usr/bin/docker
export GPU_DV="${GPU_DRIVER_VERSION:=}"
export GPU_DEST=/usr/local/nvidia
DOCKER_VERSION=1.13.1-1
export NVIDIA_DRIVER_IMAGE_SHA="${GPU_IMAGE_SHA:=}"
export NVIDIA_DRIVER_IMAGE_TAG="${GPU_DV}-${NVIDIA_DRIVER_IMAGE_SHA}"
export NVIDIA_GPU_DRIVER_TYPE="${GPU_DRIVER_TYPE:=}"
export NVIDIA_DRIVER_IMAGE="mcr.microsoft.com/aks/aks-gpu-${NVIDIA_GPU_DRIVER_TYPE}"
export CTR_GPU_INSTALL_CMD="ctr -n k8s.io run --privileged --rm --net-host --with-ns pid:/proc/1/ns/pid --mount type=bind,src=/opt/gpu,dst=/mnt/gpu,options=rbind --mount type=bind,src=/opt/actions,dst=/mnt/actions,options=rbind"
export DOCKER_GPU_INSTALL_CMD="docker run --privileged --net=host --pid=host -v /opt/gpu:/mnt/gpu -v /opt/actions:/mnt/actions --rm"
APT_CACHE_DIR=/var/cache/apt/archives/
PERMANENT_CACHE_DIR=/root/aptcache/
EVENTS_LOGGING_DIR=/var/log/azure/Microsoft.Azure.Extensions.CustomScript/events/
CURL_OUTPUT=/tmp/curl_verbose.out
ORAS_OUTPUT=/tmp/oras_verbose.out
ORAS_REGISTRY_CONFIG_FILE=/etc/oras/config.yaml 

retrycmd_if_failure() {
    retries=$1; wait_sleep=$2; timeout=$3; shift && shift && shift
    for i in $(seq 1 $retries); do
        timeout $timeout "${@}" && break || \
        if [ $i -eq $retries ]; then
            echo Executed \"$@\" $i times;
            return 1
        else
            sleep $wait_sleep
        fi
    done
    echo Executed \"$@\" $i times;
}

retrycmd_if_failure_silent() {
    retries=$1; wait_sleep=$2; timeout=$3; shift && shift && shift
    for i in $(seq 1 $retries); do
        timeout $timeout "${@}" && break || \
        if [ $i -eq $retries ]; then
            return 1
        else
            sleep $wait_sleep
        fi
    done
}

retrycmd_nslookup() {
    wait_sleep=$1; timeout=$2; total_timeout=$3; record=$4
    start_time=$(date +%s)
    while true; do
        nslookup -timeout=$timeout -retry=0 $record && break || \
        current_time=$(date +%s)
        if [ $((current_time - start_time)) -ge $total_timeout ]; then
            echo "Total timeout $total_timeout reached, nslookup -timeout=$timeout -retry=0 $record failed"
            return 1
        fi
        sleep $wait_sleep
    done
    current_time=$(date +%s)
    echo "Executed nslookup -timeout=$timeout -retry=0 $record for $((current_time - start_time)) seconds";
}
retrycmd_if_failure_no_stats() {
    retries=$1; wait_sleep=$2; timeout=$3; shift && shift && shift
    for i in $(seq 1 $retries); do
        timeout $timeout ${@} && break || \
        if [ $i -eq $retries ]; then
            return 1
        else
            sleep $wait_sleep
        fi
    done
}
retrycmd_get_tarball() {
    tar_retries=$1; wait_sleep=$2; tarball=$3; url=$4
    echo "${tar_retries} retries"
    for i in $(seq 1 $tar_retries); do
        tar -tzf $tarball && break || \
        if [ $i -eq $tar_retries ]; then
            return 1
        else
            timeout 60 curl -fsSLv $url -o $tarball > $CURL_OUTPUT 2>&1
            if [[ $? != 0 ]]; then
                cat $CURL_OUTPUT
            fi
            sleep $wait_sleep
        fi
    done
}
retrycmd_get_tarball_from_registry_with_oras() {
    tar_retries=$1; wait_sleep=$2; tarball=$3; url=$4
    tar_folder=$(dirname "$tarball")
    echo "${tar_retries} retries"
    for i in $(seq 1 $tar_retries); do
        tar -tzf $tarball && break || \
        if [ $i -eq $tar_retries ]; then
            return 1
        else
            timeout 60 oras pull $url -o $tar_folder --registry-config ${ORAS_REGISTRY_CONFIG_FILE} > $ORAS_OUTPUT 2>&1
            if [[ $? != 0 ]]; then
                cat $ORAS_OUTPUT
            fi
            sleep $wait_sleep
        fi
    done
}
retrycmd_get_access_token_for_oras() {
    retries=$1; wait_sleep=$2; url=$3
    for i in $(seq 1 $retries); do
        ACCESS_TOKEN_OUTPUT=$(timeout 60 curl -v -s -H "Metadata:true" --noproxy "*" "$url")
        if [ -n "$ACCESS_TOKEN_OUTPUT" ]; then 
            echo "$ACCESS_TOKEN_OUTPUT"
            return 0
        fi
        sleep $wait_sleep
    done
    return $ERR_ORAS_PULL_NETWORK_TIMEOUT
}
retrycmd_get_refresh_token_for_oras() {
    retries=$1; wait_sleep=$2; acr_url=$3; tenant_id=$4; ACCESS_TOKEN=$5
    for i in $(seq 1 $retries); do
        REFRESH_TOKEN_OUTPUT=$(timeout 60 curl -v -s -X POST -H "Content-Type: application/x-www-form-urlencoded" \
            -d "grant_type=access_token&service=$acr_url&tenant=$tenant_id&access_token=$ACCESS_TOKEN" \
            https://$acr_url/oauth2/exchange)
        if [ -n "$REFRESH_TOKEN_OUTPUT" ]; then 
            echo "$REFRESH_TOKEN_OUTPUT"
            return 0
        fi
        sleep $wait_sleep
    done
    return $ERR_ORAS_PULL_NETWORK_TIMEOUT
}
retrycmd_oras_login() {
    retries=$1; wait_sleep=$2; acr_url=$3; REFRESH_TOKEN=$4
    for i in $(seq 1 $retries); do
        ORAS_LOGIN_OUTPUT=$(oras login "$acr_url" --identity-token-stdin --registry-config "${ORAS_REGISTRY_CONFIG_FILE}" <<< "$REFRESH_TOKEN" 2>&1)
        exit_code=$?
        if [[ $exit_code -eq 0 ]]; then
            echo "$ORAS_LOGIN_OUTPUT"
            return 0
        fi
        sleep "$wait_sleep"
    done
    return $exit_code
}
retrycmd_get_binary_from_registry_with_oras() {
    binary_retries=$1; wait_sleep=$2; binary_path=$3; url=$4
    binary_folder=$(dirname "$binary_path")
    echo "${binary_retries} retries"
    
    for i in $(seq 1 $binary_retries); do
        if [ -f "$binary_path" ]; then
            break
        else
            if [ $i -eq $binary_retries ]; then
                return 1
            else
                timeout 60 oras pull $url -o $binary_folder --registry-config ${ORAS_REGISTRY_CONFIG_FILE} > $ORAS_OUTPUT 2>&1
                if [[ $? != 0 ]]; then
                    cat $ORAS_OUTPUT
                fi
                sleep $wait_sleep
            fi
        fi
    done
}
retrycmd_can_oras_ls_acr() {
    retries=$1; wait_sleep=$2; url=$3
    for i in $(seq 1 $retries); do
        output=$(timeout 60 oras repo ls "$url" --registry-config "$ORAS_REGISTRY_CONFIG_FILE" 2>&1)
        if [ $? -eq 0 ]; then
            echo "acr is reachable"
            return 0
        fi
        if [[ "$output" == *"unauthorized: authentication required"* ]]; then
            echo "ACR is not reachable: $output"
            return 1
        fi
    done
    echo "unexpected response from acr: $output"
    return $ERR_ORAS_PULL_NETWORK_TIMEOUT
}
retrycmd_curl_file() {
    curl_retries=$1; wait_sleep=$2; timeout=$3; filepath=$4; url=$5
    echo "${curl_retries} retries"
    for i in $(seq 1 $curl_retries); do
        [[ -f $filepath ]] && break
        if [ $i -eq $curl_retries ]; then
            return 1
        else
            timeout $timeout curl -fsSLv $url -o $filepath > $CURL_OUTPUT 2>&1
            if [[ $? != 0 ]]; then
                cat $CURL_OUTPUT
            fi
            sleep $wait_sleep
        fi
    done
}
wait_for_file() {
    retries=$1; wait_sleep=$2; filepath=$3
    paved=/opt/azure/cloud-init-files.paved
    grep -Fq "${filepath}" $paved && return 0
    for i in $(seq 1 $retries); do
        grep -Fq '#EOF' $filepath && break
        if [ $i -eq $retries ]; then
            return 1
        else
            sleep $wait_sleep
        fi
    done
    sed -i "/#EOF/d" $filepath
    echo $filepath >> $paved
}
systemctl_restart() {
    retries=$1; wait_sleep=$2; timeout=$3 svcname=$4
    for i in $(seq 1 $retries); do
        timeout $timeout systemctl daemon-reload
        timeout $timeout systemctl restart $svcname && break || \
        if [ $i -eq $retries ]; then
            return 1
        else
            systemctl status $svcname --no-pager -l
            journalctl -u $svcname
            sleep $wait_sleep
        fi
    done
}
systemctl_stop() {
    retries=$1; wait_sleep=$2; timeout=$3 svcname=$4
    for i in $(seq 1 $retries); do
        timeout $timeout systemctl daemon-reload
        timeout $timeout systemctl stop $svcname && break || \
        if [ $i -eq $retries ]; then
            return 1
        else
            sleep $wait_sleep
        fi
    done
}
systemctl_disable() {
    retries=$1; wait_sleep=$2; timeout=$3 svcname=$4
    for i in $(seq 1 $retries); do
        timeout $timeout systemctl daemon-reload
        timeout $timeout systemctl disable $svcname && break || \
        if [ $i -eq $retries ]; then
            return 1
        else
            sleep $wait_sleep
        fi
    done
}
sysctl_reload() {
    retries=$1; wait_sleep=$2; timeout=$3
    for i in $(seq 1 $retries); do
        timeout $timeout sysctl --system && break || \
        if [ $i -eq $retries ]; then
            return 1
        else
            sleep $wait_sleep
        fi
    done
}
version_gte() {
  test "$(printf '%s\n' "$@" | sort -rV | head -n 1)" == "$1"
}

systemctlEnableAndStart() {
    systemctl_restart 100 5 30 $1
    RESTART_STATUS=$?
    systemctl status $1 --no-pager -l > /var/log/azure/$1-status.log
    if [ $RESTART_STATUS -ne 0 ]; then
        echo "$1 could not be started"
        return 1
    fi
    if ! retrycmd_if_failure 120 5 25 systemctl enable $1; then
        echo "$1 could not be enabled by systemctl"
        return 1
    fi
}

systemctlDisableAndStop() {
    if systemctl list-units --full --all | grep -q "$1.service"; then
        systemctl_stop 20 5 25 $1 || echo "$1 could not be stopped"
        systemctl_disable 20 5 25 $1 || echo "$1 could not be disabled"
    fi
}

semverCompare() {
    VERSION_A=$(echo $1 | cut -d "+" -f 1)
    VERSION_B=$(echo $2 | cut -d "+" -f 1)
    [[ "${VERSION_A}" == "${VERSION_B}" ]] && return 0
    sorted=$(echo ${VERSION_A} ${VERSION_B} | tr ' ' '\n' | sort -V )
    highestVersion=$(IFS= echo "${sorted}" | cut -d$'\n' -f2)
    [[ "${VERSION_A}" == ${highestVersion} ]] && return 0
    return 1
}
downloadDebPkgToFile() {
    PKG_NAME=$1
    PKG_VERSION=$2
    PKG_DIRECTORY=$3
    mkdir -p $PKG_DIRECTORY
    pushd ${PKG_DIRECTORY}
    retrycmd_if_failure 10 5 600 apt-get download ${PKG_NAME}=${PKG_VERSION}*
    popd
}
apt_get_download() {
  retries=$1; wait_sleep=$2; shift && shift;
  local ret=0
  pushd $APT_CACHE_DIR || return 1
  for i in $(seq 1 $retries); do
    dpkg --configure -a --force-confdef
    wait_for_apt_locks
    apt-get -o Dpkg::Options::=--force-confold download -y "${@}" && break
    if [ $i -eq $retries ]; then ret=1; else sleep $wait_sleep; fi
  done
  popd || return 1
  return $ret
}
getCPUArch() {
    arch=$(uname -m)
    if [[ ${arch,,} == "aarch64" || ${arch,,} == "arm64"  ]]; then
        echo "arm64"
    else
        echo "amd64"
    fi
}
isARM64() {
    if [[ $(getCPUArch) == "arm64" ]]; then
        echo 1
    else
        echo 0
    fi
}

isRegistryUrl() {
    local binary_url=$1
    registry_regex='^.+\/.+\/.+:.+$'
    if [[ ${binary_url} =~ $registry_regex ]]; then 
        return 0 
    fi
    return 1 
}

logs_to_events() {
    local task=$1; shift
    local eventsFileName=$(date +%s%3N)

    local startTime=$(date +"%F %T.%3N")
    ${@}
    ret=$?
    local endTime=$(date +"%F %T.%3N")

    json_string=$( jq -n \
        --arg Timestamp   "${startTime}" \
        --arg OperationId "${endTime}" \
        --arg Version     "1.23" \
        --arg TaskName    "${task}" \
        --arg EventLevel  "Informational" \
        --arg Message     "Completed: $*" \
        --arg EventPid    "0" \
        --arg EventTid    "0" \
        '{Timestamp: $Timestamp, OperationId: $OperationId, Version: $Version, TaskName: $TaskName, EventLevel: $EventLevel, Message: $Message, EventPid: $EventPid, EventTid: $EventTid}'
    )
    echo ${json_string} > ${EVENTS_LOGGING_DIR}${eventsFileName}.json

    if [ "$ret" != "0" ]; then
      return $ret
    fi
}

should_skip_nvidia_drivers() {
    set -x
    body=$(curl -fsSL -H "Metadata: true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01")
    ret=$?
    if [ "$ret" != "0" ]; then
      return $ret
    fi
    should_skip=$(echo "$body" | jq -e '.compute.tagsList | map(select(.name | test("SkipGpuDriverInstall"; "i")))[0].value // "false" | test("true"; "i")')
    echo "$should_skip"
}

should_disable_kubelet_serving_certificate_rotation() {
    set -x
    body=$(curl -fsSL -H "Metadata: true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01")
    ret=$?
    if [ "$ret" != "0" ]; then
      return $ret
    fi
    should_disable=$(echo "$body" | jq -r '.compute.tagsList[] | select(.name == "aks-disable-kubelet-serving-certificate-rotation") | .value')
    echo "${should_disable,,}"
}

should_skip_binary_cleanup() {
    set -x
    body=$(curl -fsSL -H "Metadata: true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01")
    ret=$?
    if [ "$ret" != "0" ]; then
      return $ret
    fi
    should_skip=$(echo "$body" | jq -r '.compute.tagsList[] | select(.name == "SkipBinaryCleanup") | .value')
    echo "${should_skip,,}"
}

isMarinerOrAzureLinux() {
    local os=$1
    if [[ $os == $MARINER_OS_NAME ]] || [[ $os == $MARINER_KATA_OS_NAME ]] || [[ $os == $AZURELINUX_OS_NAME ]]; then
        return 0
    fi
    return 1
}

evalPackageDownloadURL() {
    local url=${1:-}
    if [[ -n "$url" ]]; then
         eval "result=${url}"
         echo $result
         return
    fi
    echo ""
}

installJq() {
  output=$(jq --version)
  if [ -n "$output" ]; then
    echo "$output"
  else
    if isMarinerOrAzureLinux "$OS"; then
      sudo tdnf install -y jq && echo "jq was installed: $(jq --version)"
    else
      apt_get_install 5 1 60 jq && echo "jq was installed: $(jq --version)"
    fi
  fi
}

updateRelease() {
    local package="$1"
    local os="$2"
    local osVersion="$3"
    RELEASE="current"
    local osLowerCase=$(echo "${os}" | tr '[:upper:]' '[:lower:]')
    #For UBUNTU, if $osVersion is 18.04 and "r1804" is also defined in components.json, then $release is set to "r1804"
    #Similarly for 20.04 and 22.04. Otherwise $release is set to .current.
    #For MARINER, the release is always set to "current" now.
    #For AZURELINUX, if $osVersion is 3.0 and "v3.0" is also defined in components.json, then $RELEASE is set to "v3.0"
    if isMarinerOrAzureLinux "${os}"; then
        if [[ $(echo "${package}" | jq ".downloadURIs.${osLowerCase}.\"v${osVersion}\"") != "null" ]]; then
            RELEASE="\"v${osVersion}\""
        fi
        return 0
    fi
    local osVersionWithoutDot=$(echo "${osVersion}" | sed 's/\.//g')
    if [[ $(echo "${package}" | jq ".downloadURIs.ubuntu.r${osVersionWithoutDot}") != "null" ]]; then
        RELEASE="\"r${osVersionWithoutDot}\""
    fi
}

updatePackageVersions() {
    local package="$1"
    local os="$2"
    local osVersion="$3"
    RELEASE="current"
    updateRelease "${package}" "${os}" "${osVersion}"
    local osLowerCase=$(echo "${os}" | tr '[:upper:]' '[:lower:]')
    PACKAGE_VERSIONS=()

    if [[ $(echo "${package}" | jq ".downloadURIs.${osLowerCase}") == "null" ]]; then
        osLowerCase="default"
    fi

    if [[ $(echo "${package}" | jq ".downloadURIs.${osLowerCase}.${RELEASE}.versionsV2") != "null" ]]; then
        local latestVersions=($(echo "${package}" | jq -r ".downloadURIs.${osLowerCase}.${RELEASE}.versionsV2[] | select(.latestVersion != null) | .latestVersion"))
        local previousLatestVersions=($(echo "${package}" | jq -r ".downloadURIs.${osLowerCase}.${RELEASE}.versionsV2[] | select(.previousLatestVersion != null) | .previousLatestVersion"))
        for version in "${latestVersions[@]}"; do
            PACKAGE_VERSIONS+=("${version}")
        done
        for version in "${previousLatestVersions[@]}"; do
            PACKAGE_VERSIONS+=("${version}")
        done
        return 0
    fi

    if [[ $(echo "${package}" | jq ".downloadURIs.${osLowerCase}.${RELEASE}.versions") == "null" ]]; then
        return 0
    fi
    local versions=($(echo "${package}" | jq -r ".downloadURIs.${osLowerCase}.${RELEASE}.versions[]"))
    for version in "${versions[@]}"; do
        PACKAGE_VERSIONS+=("${version}")
    done
    return 0
}

updateMultiArchVersions() {
  local imageToBePulled="$1"

  #jq the MultiArchVersions from the containerImages. If ContainerImages[i].multiArchVersionsV2 is not null, return that, else return ContainerImages[i].multiArchVersions
  if [[ $(echo "${imageToBePulled}" | jq .multiArchVersionsV2) != "null" ]]; then
    local latestVersions=($(echo "${imageToBePulled}" | jq -r ".multiArchVersionsV2[] | select(.latestVersion != null) | .latestVersion"))
    local previousLatestVersions=($(echo "${imageToBePulled}" | jq -r ".multiArchVersionsV2[] | select(.previousLatestVersion != null) | .previousLatestVersion"))
    for version in "${latestVersions[@]}"; do
      MULTI_ARCH_VERSIONS+=("${version}")
    done
    for version in "${previousLatestVersions[@]}"; do
      MULTI_ARCH_VERSIONS+=("${version}")
    done
    return
  fi

  local versions=($(echo "${imageToBePulled}" | jq -r ".multiArchVersions[]"))
  for version in "${versions[@]}"; do
    MULTI_ARCH_VERSIONS+=("${version}")
  done
}

updatePackageDownloadURL() {
    local package=$1
    local os=$2
    local osVersion=$3
    RELEASE="current"
    updateRelease "${package}" "${os}" "${osVersion}"
    local osLowerCase=$(echo "${os}" | tr '[:upper:]' '[:lower:]')
    
    #if .downloadURIs.${osLowerCase} exist, then get the downloadURL from there.
    #otherwise get the downloadURL from .downloadURIs.default 
    if [[ $(echo "${package}" | jq ".downloadURIs.${osLowerCase}") != "null" ]]; then
        downloadURL=$(echo "${package}" | jq ".downloadURIs.${osLowerCase}.${RELEASE}.downloadURL" -r)
        [ "${downloadURL}" = "null" ] && PACKAGE_DOWNLOAD_URL="" || PACKAGE_DOWNLOAD_URL="${downloadURL}"
        return
    fi
    downloadURL=$(echo "${package}" | jq ".downloadURIs.default.${RELEASE}.downloadURL" -r)
    [ "${downloadURL}" = "null" ] && PACKAGE_DOWNLOAD_URL="" || PACKAGE_DOWNLOAD_URL="${downloadURL}"
    return    
}

addKubeletNodeLabel() {
    local LABEL_STRING=$1
    if grep -i "$LABEL_STRING" <<< "$KUBELET_NODE_LABELS" > /dev/null 2>&1; then
        echo "kubelet node label $LABEL_STRING is already present, nothing to add"
        return 0
    fi

    echo "adding label $LABEL_STRING to kubelet node labels..."
    if [ -n "$KUBELET_NODE_LABELS" ]; then
        KUBELET_NODE_LABELS="${KUBELET_NODE_LABELS},${LABEL_STRING}"
    else
        KUBELET_NODE_LABELS=$LABEL_STRING
    fi
}

removeKubeletNodeLabel() {
    local LABEL_STRING=$1
    if grep -e ",${LABEL_STRING}" <<< "$KUBELET_NODE_LABELS" > /dev/null 2>&1; then
        KUBELET_NODE_LABELS="${KUBELET_NODE_LABELS/,${LABEL_STRING}/}"
    elif grep -e "${LABEL_STRING}," <<< "$KUBELET_NODE_LABELS" > /dev/null 2>&1; then
        KUBELET_NODE_LABELS="${KUBELET_NODE_LABELS/${LABEL_STRING},/}"
    elif grep -e "${LABEL_STRING}" <<< "$KUBELET_NODE_LABELS" > /dev/null 2>&1; then
        KUBELET_NODE_LABELS="${KUBELET_NODE_LABELS/${LABEL_STRING}/}"
    fi
}

removeKubeletFlag() {
    local FLAG_STRING=$1
    if grep -e ",${FLAG_STRING}" <<< "$KUBELET_FLAGS" > /dev/null 2>&1; then
        KUBELET_FLAGS="${KUBELET_FLAGS/,${FLAG_STRING}/}"
    elif grep -e "${FLAG_STRING}," <<< "$KUBELET_FLAGS" > /dev/null 2>&1; then
        KUBELET_FLAGS="${KUBELET_FLAGS/${FLAG_STRING},/}"
    elif grep -e "${FLAG_STRING}" <<< "$KUBELET_FLAGS" > /dev/null 2>&1; then
        KUBELET_FLAGS="${KUBELET_FLAGS/${FLAG_STRING}/}"
    fi
}

verify_DNS_health(){
    local domain_name=$1
    if [ -z "$domain_name" ]; then
        echo "DNS domain is empty"
        return $ERR_DNS_HEALTH_FAIL
    fi

    dig_check_no_domain=$(dig +norec +short +tries=5 +timeout=5 .)
    if [ $? -ne 0 ]; then
        echo "Failed to resolve root domain '.'"
        return $ERR_DNS_HEALTH_FAIL
    fi

    dig_check_domain=$(dig +tries=5 +timeout=5 +short $domain_name)
    ret_code=$?
    if [ ret_code -ne 0 ] || [ -z "$dig_check_domain" ]; then
        echo "Failed to resolve domain $domain_name return code: $ret_code"
        return $ERR_DNS_HEALTH_FAIL
    fi
    echo "DNS health check passed"
}

oras_login_with_kubelet_identity() {
    local acr_url=$1
    local client_id=$2
    local tenant_id=$3

    if [ -z "$client_id" ] || [ -z "$tenant_id" ]; then
        echo "client_id or tenant_id are not set. Oras login is not possible, proceeding with anonymous pull"
        return 
    fi

    retrycmd_can_oras_ls_acr 10 5 $acr_url
    ret_code=$? 
    if [[ $ret_code -eq 0 ]]; then
        echo "anonymous pull is allowed for acr '$acr_url', proceeding with anonymous pull"
        return
    elif [[ $ret_code -ne 1 ]]; then
        echo "failed with an error other than unauthorized, exiting.."
        return $ret_code
    fi

    set +x 
    access_url="http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/&client_id=$client_id"
    raw_access_token=$(retrycmd_get_access_token_for_oras 10 5 $access_url)
    ret_code=$? 
    if [ $ret_code -ne 0 ]; then
        echo "failed to retrieve access token: $ret_code"
        return $ret_code
    fi
    if [[ "$raw_access_token" == *"error"* ]]; then
        echo "failed to retrieve access token"
        return $ERR_ORAS_PULL_UNAUTHORIZED
    fi
    ACCESS_TOKEN=$(echo "$raw_access_token" | jq -r .access_token)
    if [ -z "$ACCESS_TOKEN" ] || [ "$ACCESS_TOKEN" == "null" ]; then
        echo "failed to parse access token"
        return $ERR_ORAS_PULL_UNAUTHORIZED
    fi

    raw_refresh_token=$(retrycmd_get_refresh_token_for_oras 10 5 $acr_url $tenant_id $ACCESS_TOKEN)
    ret_code=$? 
    if [ $ret_code -ne 0 ]; then
        echo "failed to retrieve refresh token: $ret_code"
        return $ret_code
    fi
    if [[ "$raw_refresh_token" == *"error"* ]]; then
        echo "failed to retrieve refresh token"
        return $ERR_ORAS_PULL_UNAUTHORIZED
    fi
    REFRESH_TOKEN=$(echo "$raw_refresh_token" | jq -r .refresh_token)
    if [ -z "$REFRESH_TOKEN" ] || [ "$REFRESH_TOKEN" == "null" ]; then
        echo "failed to parse refresh token"
        return $ERR_ORAS_PULL_UNAUTHORIZED
    fi

    retrycmd_oras_login 3 5 $acr_url "$REFRESH_TOKEN"
    if [ $? -ne 0 ]; then
        echo "failed to login to acr '$acr_url' with identity token"
        return $ERR_ORAS_PULL_UNAUTHORIZED
    fi
    unset ACCESS_TOKEN REFRESH_TOKEN  
    set -x

    retrycmd_can_oras_ls_acr 10 5 $acr_url$test_image
    if [[ $? -ne 0 ]]; then
        echo "failed to login to acr '$acr_url', pull is still unauthorized"
        return $ERR_ORAS_PULL_UNAUTHORIZED
    fi

    echo "successfully logged in to acr '$acr_url' with identity token"
}

#HELPERSEOF
