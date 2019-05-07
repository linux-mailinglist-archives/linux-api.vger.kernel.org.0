Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9616A0C
	for <lists+linux-api@lfdr.de>; Tue,  7 May 2019 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEGSVc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 May 2019 14:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfEGSVc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 May 2019 14:21:32 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC4F206BF;
        Tue,  7 May 2019 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557253290;
        bh=3XtpG9P5izxwe9Du+SZ8SvXF9BdeXgvfzh8wb8wQ2wk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wd0ZlS8UnJcdZ6MbbWO5ZfXi0+AXQyr6WQHZJZkSMiJyGToXFex/J87/NwkEPcyv8
         PcZDOYANftKFnIknN+ZgZYQ21BdQWAss6PMe9b6DXiJKdMqI6YbnCQbytcNrQtqavT
         ladiHXybCkaJA6jQTCvWeQZadDQnWDENCjWcrKdM=
Received: by mail-ed1-f48.google.com with SMTP id w37so19621738edw.4;
        Tue, 07 May 2019 11:21:30 -0700 (PDT)
X-Gm-Message-State: APjAAAUS3jKyKdmgkMquqIkHBcDU2hb/c0v5ql6EUd274sDgKHZ/W01f
        fr0hkyroxmAGZ1Grf3U/+R3bj9wgPD6MJgQSWVo=
X-Google-Smtp-Source: APXvYqwAtDO6EP8rBOc7d8Uzm5Zr73vR4IgHID0vtn4DS/2DGZs6mL45gPCwzY37daRWM2/jMgilxA2dLzA9mGh99HA=
X-Received: by 2002:a50:9266:: with SMTP id j35mr35373811eda.60.1557253288611;
 Tue, 07 May 2019 11:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com> <1556528151-17221-16-git-send-email-hao.wu@intel.com>
In-Reply-To: <1556528151-17221-16-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 7 May 2019 13:20:52 -0500
X-Gmail-Original-Message-ID: <CANk1AXR+wRoQB40ZFTAPPp4mmkzZY+03bTwdB24fL0mYNck2Ug@mail.gmail.com>
Message-ID: <CANk1AXR+wRoQB40ZFTAPPp4mmkzZY+03bTwdB24fL0mYNck2Ug@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] fpga: dfl: fme: add thermal management support
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 4:13 AM Wu Hao <hao.wu@intel.com> wrote:

+ The hwmon people

>
> This patch adds support to thermal management private feature for DFL
> FPGA Management Engine (FME). This private feature driver registers
> a hwmon for thermal/temperature monitoring (hwmon temp1_input).
> If hardware automatic throttling is supported by this hardware, then
> driver also exposes sysfs interfaces under hwmon for thresholds
> (temp1_alarm/ crit/ emergency), threshold status (temp1_alarm_status/
> temp1_crit_status) and throttling policy (temp1_alarm_policy).
>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: create a dfl_fme_thermal hwmon to expose thermal information.
>     move all sysfs interfaces under hwmon
>         tempareture       --> hwmon temp1_input
>         threshold1        --> hwmon temp1_alarm
>         threshold2        --> hwmon temp1_crit
>         trip_threshold    --> hwmon temp1_emergency
>         threshold1_status --> hwmon temp1_alarm_status
>         threshold2_status --> hwmon temp1_crit_status
>         threshold1_policy --> hwmon temp1_alarm_policy
> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-fme |  64 +++++++
>  drivers/fpga/Kconfig                             |   2 +-
>  drivers/fpga/dfl-fme-main.c                      | 212 +++++++++++++++++++++++
>  3 files changed, 277 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index d1aa375..dfbd315 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -44,3 +44,67 @@ Description: Read-only. It returns socket_id to indicate which socket
>                 this FPGA belongs to, only valid for integrated solution.
>                 User only needs this information, in case standard numa node
>                 can't provide correct information.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/name
> +Date:          April 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-Only. Read this file to get the name of hwmon device, it
> +               supports values:
> +                   'dfl_fme_thermal' - thermal hwmon device name
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_input
> +Date:          April 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-Only. It returns FPGA device temperature in millidegrees
> +               Celsius.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_alarm
> +Date:          April 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-Only. It returns hardware threshold1 temperature in
> +               millidegrees Celsius. If temperature rises at or above this
> +               threshold, hardware starts 50% or 90% throttling (see
> +               'temp1_alarm_policy').
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_crit
> +Date:          April 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-Only. It returns hardware threshold2 temperature in
> +               millidegrees Celsius. If temperature rises at or above this
> +               threshold, hardware starts 100% throttling.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_emergency
> +Date:          April 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-Only. It returns hardware trip threshold temperature in
> +               millidegrees Celsius. If temperature rises at or above this
> +               threshold, a fatal event will be triggered to board management
> +               controller (BMC) to shutdown FPGA.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_alarm_status
> +Date:          April 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. It returns 1 if temperature is currently at or above
> +               hardware threshold1 (see 'temp1_alarm'), otherwise 0.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_crit_status
> +Date:          April 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. It returns 1 if temperature is currently at or above
> +               hardware threshold2 (see 'temp1_crit'), otherwise 0.
> +
> +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_alarm_policy
> +Date:          April 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-Only. Read this file to get the policy of hardware threshold1
> +               (see 'temp1_alarm'). It only supports two values (policies):
> +                   0 - AP2 state (90% throttling)
> +                   1 - AP1 state (50% throttling)
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index c20445b..a6d7588 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -154,7 +154,7 @@ config FPGA_DFL
>
>  config FPGA_DFL_FME
>         tristate "FPGA DFL FME Driver"
> -       depends on FPGA_DFL
> +       depends on FPGA_DFL && HWMON
>         help
>           The FPGA Management Engine (FME) is a feature device implemented
>           under Device Feature List (DFL) framework. Select this option to
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 8339ee8..b9a68b8 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -14,6 +14,8 @@
>   *   Henry Mitchel <henry.mitchel@intel.com>
>   */
>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
> @@ -217,6 +219,212 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>         .ioctl = fme_hdr_ioctl,
>  };
>
> +#define FME_THERM_THRESHOLD    0x8
> +#define TEMP_THRESHOLD1                GENMASK_ULL(6, 0)
> +#define TEMP_THRESHOLD1_EN     BIT_ULL(7)
> +#define TEMP_THRESHOLD2                GENMASK_ULL(14, 8)
> +#define TEMP_THRESHOLD2_EN     BIT_ULL(15)
> +#define TRIP_THRESHOLD         GENMASK_ULL(30, 24)
> +#define TEMP_THRESHOLD1_STATUS BIT_ULL(32)             /* threshold1 reached */
> +#define TEMP_THRESHOLD2_STATUS BIT_ULL(33)             /* threshold2 reached */
> +/* threshold1 policy: 0 - AP2 (90% throttle) / 1 - AP1 (50% throttle) */
> +#define TEMP_THRESHOLD1_POLICY BIT_ULL(44)
> +
> +#define FME_THERM_RDSENSOR_FMT1        0x10
> +#define FPGA_TEMPERATURE       GENMASK_ULL(6, 0)
> +
> +#define FME_THERM_CAP          0x20
> +#define THERM_NO_THROTTLE      BIT_ULL(0)
> +
> +#define MD_PRE_DEG
> +
> +static bool fme_thermal_throttle_support(void __iomem *base)
> +{
> +       u64 v = readq(base + FME_THERM_CAP);
> +
> +       return FIELD_GET(THERM_NO_THROTTLE, v) ? false : true;
> +}
> +
> +static umode_t thermal_hwmon_attrs_visible(const void *drvdata,
> +                                          enum hwmon_sensor_types type,
> +                                          u32 attr, int channel)
> +{
> +       const struct dfl_feature *feature = drvdata;
> +
> +       /* temperature is always supported, and check hardware cap for others */
> +       if (attr == hwmon_temp_input)
> +               return 0444;
> +
> +       return fme_thermal_throttle_support(feature->ioaddr) ? 0444 : 0;
> +}
> +
> +static int thermal_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +                             u32 attr, int channel, long *val)
> +{
> +       struct dfl_feature *feature = dev_get_drvdata(dev);
> +       u64 v;
> +
> +       switch (attr) {
> +       case hwmon_temp_input:
> +               v = readq(feature->ioaddr + FME_THERM_RDSENSOR_FMT1);
> +               *val = (long)(FIELD_GET(FPGA_TEMPERATURE, v) * 1000);
> +               break;
> +       case hwmon_temp_alarm:
> +               v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +               *val = (long)(FIELD_GET(TEMP_THRESHOLD1, v) * 1000);
> +               break;
> +       case hwmon_temp_crit:
> +               v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +               *val = (long)(FIELD_GET(TEMP_THRESHOLD2, v) * 1000);
> +               break;
> +       case hwmon_temp_emergency:
> +               v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +               *val = (long)(FIELD_GET(TRIP_THRESHOLD, v) * 1000);
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct hwmon_ops thermal_hwmon_ops = {
> +       .is_visible = thermal_hwmon_attrs_visible,
> +       .read = thermal_hwmon_read,
> +};
> +
> +static const u32 thermal_hwmon_temp_config[] = {
> +       HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_CRIT | HWMON_T_EMERGENCY,
> +       0
> +};
> +
> +static const struct hwmon_channel_info hwmon_temp_info = {
> +       .type = hwmon_temp,
> +       .config = thermal_hwmon_temp_config,
> +};
> +
> +static const struct hwmon_channel_info *thermal_hwmon_info[] = {
> +       &hwmon_temp_info,
> +       NULL
> +};
> +
> +static const struct hwmon_chip_info thermal_hwmon_chip_info = {
> +       .ops = &thermal_hwmon_ops,
> +       .info = thermal_hwmon_info,
> +};
> +
> +static ssize_t temp1_alarm_status_show(struct device *dev,
> +                                      struct device_attribute *attr, char *buf)
> +{
> +       struct dfl_feature *feature = dev_get_drvdata(dev);
> +       u64 v;
> +
> +       v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> +                        (unsigned int)FIELD_GET(TEMP_THRESHOLD1_STATUS, v));
> +}
> +
> +static ssize_t temp1_crit_status_show(struct device *dev,
> +                                     struct device_attribute *attr, char *buf)
> +{
> +       struct dfl_feature *feature = dev_get_drvdata(dev);
> +       u64 v;
> +
> +       v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> +                        (unsigned int)FIELD_GET(TEMP_THRESHOLD2_STATUS, v));
> +}
> +
> +static ssize_t temp1_alarm_policy_show(struct device *dev,
> +                                      struct device_attribute *attr, char *buf)
> +{
> +       struct dfl_feature *feature = dev_get_drvdata(dev);
> +       u64 v;
> +
> +       v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> +                        (unsigned int)FIELD_GET(TEMP_THRESHOLD1_POLICY, v));
> +}
> +
> +static DEVICE_ATTR_RO(temp1_alarm_status);
> +static DEVICE_ATTR_RO(temp1_crit_status);
> +static DEVICE_ATTR_RO(temp1_alarm_policy);
> +
> +static struct attribute *thermal_extra_attrs[] = {
> +       &dev_attr_temp1_alarm_status.attr,
> +       &dev_attr_temp1_crit_status.attr,
> +       &dev_attr_temp1_alarm_policy.attr,
> +       NULL,
> +};
> +
> +static umode_t thermal_extra_attrs_visible(struct kobject *kobj,
> +                                          struct attribute *attr, int index)
> +{
> +       struct device *dev = kobj_to_dev(kobj);
> +       struct dfl_feature *feature = dev_get_drvdata(dev);
> +
> +       return fme_thermal_throttle_support(feature->ioaddr) ? attr->mode : 0;
> +}
> +
> +static const struct attribute_group thermal_extra_group = {
> +       .attrs          = thermal_extra_attrs,
> +       .is_visible     = thermal_extra_attrs_visible,
> +};
> +__ATTRIBUTE_GROUPS(thermal_extra);
> +
> +static int fme_thermal_mgmt_init(struct platform_device *pdev,
> +                                struct dfl_feature *feature)
> +{
> +       struct device *hwmon;
> +
> +       dev_dbg(&pdev->dev, "FME Thermal Management Init.\n");
> +
> +       /*
> +        * create hwmon to allow userspace monitoring temperature and other
> +        * threshold information.
> +        *
> +        * temp1_alarm     -> hardware threshold 1 -> 50% or 90% throttling
> +        * temp1_crit      -> hardware threshold 2 -> 100% throttling
> +        * temp1_emergency -> hardware trip_threshold to shutdown FPGA
> +        *
> +        * create device specific sysfs interfaces, e.g. read temp1_alarm_policy
> +        * to understand the actual hardware throttling action (50% vs 90%).
> +        *
> +        * If hardware doesn't support automatic throttling per thresholds,
> +        * then all above sysfs interfaces are not visible except temp1_input
> +        * for temperature.
> +        */
> +       hwmon = devm_hwmon_device_register_with_info(&pdev->dev,
> +                                                    "dfl_fme_thermal", feature,
> +                                                    &thermal_hwmon_chip_info,
> +                                                    thermal_extra_groups);
> +       if (IS_ERR(hwmon)) {
> +               dev_err(&pdev->dev, "Fail to register thermal hwmon\n");
> +               return PTR_ERR(hwmon);
> +       }
> +
> +       return 0;
> +}
> +
> +static void fme_thermal_mgmt_uinit(struct platform_device *pdev,
> +                                  struct dfl_feature *feature)
> +{
> +       dev_dbg(&pdev->dev, "FME Thermal Management UInit.\n");
> +}
> +
> +static const struct dfl_feature_id fme_thermal_mgmt_id_table[] = {
> +       {.id = FME_FEATURE_ID_THERMAL_MGMT,},
> +       {0,}
> +};
> +
> +static const struct dfl_feature_ops fme_thermal_mgmt_ops = {
> +       .init = fme_thermal_mgmt_init,
> +       .uinit = fme_thermal_mgmt_uinit,
> +};
> +
>  static struct dfl_feature_driver fme_feature_drvs[] = {
>         {
>                 .id_table = fme_hdr_id_table,
> @@ -227,6 +435,10 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>                 .ops = &fme_pr_mgmt_ops,
>         },
>         {
> +               .id_table = fme_thermal_mgmt_id_table,
> +               .ops = &fme_thermal_mgmt_ops,
> +       },
> +       {
>                 .ops = NULL,
>         },
>  };
> --
> 1.8.3.1
>
