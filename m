Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5681717B3C
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2019 16:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEHOCQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 May 2019 10:02:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33052 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfEHOCQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 May 2019 10:02:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so10565444pfk.0;
        Wed, 08 May 2019 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JstdpYITyjwcA23Z1JuASJN0vfCHeJRg3zXp8i17J/k=;
        b=SK8FGzvyc67NeQUlorL4u6lEPRzNTrYybLOP7zGAmT0wYoBr7QdB+x6E3paYT5aRxw
         4VJTS507Kca/lxtCqz1bRz4/ErK/QevuVqsMH6y2Gzvqa3j7hLFC34/n9tzGaFza76qV
         w0SBLPkMw94NEAMLtm7ssNJuNDeGGpz41fykGKggcr1m6b7SvoVwDezspzatmbnm04yw
         tInvnc1EuUJOFCJLxWwnJ9vcLpa441gjJ0q9OXK4ial4xU55+dtVPwP0SPwkC4HjX8bC
         SVw+S9xCTetpwToGY2G/3mHYnf1sQC6yaBg06ey8VyFdpqxVwa03AzTwLhCm4g8gRkU6
         jmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JstdpYITyjwcA23Z1JuASJN0vfCHeJRg3zXp8i17J/k=;
        b=YPkYqbJWBd5RdXOMQpWz0BiCihcg5M5N3QWSDMcYGzIiZzPHMAGroBJBMvaE3E5QMH
         R2vBzc39HAokMz252tRjnXnnzozg3Qiti/4y10KaeFsW+Iru9+p8jyHjLtnPr9u0jY4N
         LDlgT5c0o6NFn0LMlbS1q0yCOXPiZKq7vu2Mc8WEfiTh5m7g3I5pgqmalhig9kS3XYeU
         POnGXtL8un8XLEP4Z1h7b7aKg01YOx93pxuiMZM4iVzZ2j+RvC8e6dQQHBtzQdrze5wv
         pVC/UWXspRrsDo64Gzqdj3E73vRtj9IQLyK2kgg0Jid6i654MNkiOhby2cfA3QcbNT7i
         4T1w==
X-Gm-Message-State: APjAAAUb3ymh7h84L+UcDlO4qLb95VC9ITB+9zLH2CH+1poh2OmZXQ5w
        PQ1KjVVTi+SfIL8ElzB5wZ5ZxqeWDVcDmoY+Kgg=
X-Google-Smtp-Source: APXvYqz0NJqd0cbl5KxdtGgp34XHRCJUo2pmPXWAykTlDHrDFgy4vfTZ8+SsQTIPA/GV2+iO0AGcFcKaxa59T4wdT3I=
X-Received: by 2002:a62:ee04:: with SMTP id e4mr21937232pfi.232.1557324134526;
 Wed, 08 May 2019 07:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com> <c953b43b-6186-77e9-54b1-b1cd1d7d1eb6@gmail.com>
In-Reply-To: <c953b43b-6186-77e9-54b1-b1cd1d7d1eb6@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 17:02:03 +0300
Message-ID: <CAHp75Vf9uPG7_K0P26nHYCH0WB6LFX3wk8aJBpLWQ-r46kDw9w@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] platform/x86: asus-wmi: Control RGB keyboard backlight
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 19, 2019 at 1:14 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The WMI exposes two methods for controlling RGB keyboard backlight, which
> allows controlling:
> * RGB components in range 00 - ff,
> * Switch between 4 effects,
> * Switch between 3 effect speed modes,
> * Separately enable the backlight on boot, in the awake state (after driver
>   load), in sleep mode, and probably in something called shutdown mode (no
>   observable effects of enabling it are known so far).
>
> The configuration should be written to several sysfs parameter buffers
> which are then written via WMI by writing either 1 or 2 to the "kbbl_set"
> parameter. When reading the buffers the last written value is returned.
>
> If the 2 is written to "kbbl_set", the parameters will be reset on reboot
> (temporary mode), 1 is permanent mode, parameters are retained.
>
> The calls use new 3-dword input buffer method call.
>
> The functionality is only enabled if corresponding DSTS methods return
> exact valid values.
>
> The following script demonstrates usage:
>
> echo Red [00 - ff]
> echo 33 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_red
> echo Green [00 - ff]
> echo ff > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_green
> echo Blue [00 - ff]
> echo 0 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_blue
> echo Mode: 0 - static color, 1 - breathing, 2 - color cycle, 3 - strobing
> echo 0 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_mode
> echo Speed for modes 1 and 2: 0 - slow, 1 - medium, 2 - fast
> echo 0 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_speed
> echo Enable: 02 - on boot, before module load, 08 - awake, 20 - sleep,
> echo 2a or ff to set all
> echo 2a > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_flags
> echo Save: 1 - permanently, 2 - temporarily, reset after reboot
> echo 1 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_set
>

Shouldn't be the LED subsystem driver for this?

> Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  61 ++++
>  drivers/platform/x86/asus-wmi.c               | 331 ++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |   2 +
>  3 files changed, 394 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 019e1e29370e..1cc54d5e3e10 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -36,3 +36,64 @@ KernelVersion:       3.5
>  Contact:       "AceLan Kao" <acelan.kao@canonical.com>
>  Description:
>                 Resume on lid open. 1 means on, 0 means off.
> +
> +What:          /sys/devices/platform/<platform>/kbbl/kbbl_red
> +Date:          Apr 2019
> +KernelVersion: 5.1
> +Contact:       "Yurii Pavlovskyi" <yurii.pavlovskyi@gmail.com>
> +Description:
> +               RGB keyboard backlight red component: 00 .. ff.
> +
> +What:          /sys/devices/platform/<platform>/kbbl/kbbl_green
> +Date:          Apr 2019
> +KernelVersion: 5.1
> +Contact:       "Yurii Pavlovskyi" <yurii.pavlovskyi@gmail.com>
> +Description:
> +               RGB keyboard backlight green component: 00 .. ff.
> +
> +What:          /sys/devices/platform/<platform>/kbbl/kbbl_blue
> +Date:          Apr 2019
> +KernelVersion: 5.1
> +Contact:       "Yurii Pavlovskyi" <yurii.pavlovskyi@gmail.com>
> +Description:
> +               RGB keyboard backlight blue component: 00 .. ff.
> +
> +What:          /sys/devices/platform/<platform>/kbbl/kbbl_mode
> +Date:          Apr 2019
> +KernelVersion: 5.1
> +Contact:       "Yurii Pavlovskyi" <yurii.pavlovskyi@gmail.com>
> +Description:
> +               RGB keyboard backlight mode:
> +                       * 0 - static color,
> +                       * 1 - breathing,
> +                       * 2 - color cycle,
> +                       * 3 - strobing.
> +
> +What:          /sys/devices/platform/<platform>/kbbl/kbbl_speed
> +Date:          Apr 2019
> +KernelVersion: 5.1
> +Contact:       "Yurii Pavlovskyi" <yurii.pavlovskyi@gmail.com>
> +Description:
> +               RGB keyboard backlight speed for modes 1 and 2:
> +                       * 0 - slow,
> +                       * 1 - medium,
> +                       * 2 - fast.
> +
> +What:          /sys/devices/platform/<platform>/kbbl/kbbl_flags
> +Date:          Apr 2019
> +KernelVersion: 5.1
> +Contact:       "Yurii Pavlovskyi" <yurii.pavlovskyi@gmail.com>
> +Description:
> +               RGB keyboard backlight enable flags (2a to enable everything), OR of:
> +                       * 02 - on boot (until module load),
> +                       * 08 - awake,
> +                       * 20 - sleep.
> +
> +What:          /sys/devices/platform/<platform>/kbbl/kbbl_set
> +Date:          Apr 2019
> +KernelVersion: 5.1
> +Contact:       "Yurii Pavlovskyi" <yurii.pavlovskyi@gmail.com>
> +Description:
> +               Write changed RGB keyboard backlight parameters:
> +                       * 1 - permanently,
> +                       * 2 - temporarily.
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 1b8272374660..0a32079336d8 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -148,6 +148,21 @@ struct asus_rfkill {
>         u32 dev_id;
>  };
>
> +struct asus_kbbl_rgb {
> +       u8 kbbl_red;
> +       u8 kbbl_green;
> +       u8 kbbl_blue;
> +       u8 kbbl_mode;
> +       u8 kbbl_speed;
> +
> +       u8 kbbl_set_red;
> +       u8 kbbl_set_green;
> +       u8 kbbl_set_blue;
> +       u8 kbbl_set_mode;
> +       u8 kbbl_set_speed;
> +       u8 kbbl_set_flags;
> +};
> +
>  struct asus_wmi {
>         int dsts_id;
>         int spec;
> @@ -183,6 +198,9 @@ struct asus_wmi {
>         int asus_hwmon_num_fans;
>         int asus_hwmon_pwm;
>
> +       bool kbbl_rgb_available;
> +       struct asus_kbbl_rgb kbbl_rgb;
> +
>         struct hotplug_slot hotplug_slot;
>         struct mutex hotplug_lock;
>         struct mutex wmi_lock;
> @@ -658,6 +676,312 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>         return rv;
>  }
>
> +/* RGB keyboard backlight *****************************************************/
> +
> +static ssize_t show_u8(u8 value, char *buf)
> +{
> +       return scnprintf(buf, PAGE_SIZE, "%02x\n", value);
> +}
> +
> +static ssize_t store_u8(u8 *value, const char *buf, int count)
> +{
> +       int err;
> +       u8 result;
> +
> +       err = kstrtou8(buf, 16, &result);
> +       if (err < 0) {
> +               pr_warn("Trying to store invalid value\n");
> +               return err;
> +       }
> +
> +       *value = result;
> +
> +       return count;
> +}
> +
> +static ssize_t kbbl_red_show(struct device *dev, struct device_attribute *attr,
> +               char *buf)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return show_u8(asus->kbbl_rgb.kbbl_red, buf);
> +}
> +
> +static ssize_t kbbl_red_store(struct device *dev, struct device_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return store_u8(&asus->kbbl_rgb.kbbl_set_red, buf, count);
> +}
> +
> +static ssize_t kbbl_green_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return show_u8(asus->kbbl_rgb.kbbl_green, buf);
> +}
> +
> +static ssize_t kbbl_green_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t count)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return store_u8(&asus->kbbl_rgb.kbbl_set_green, buf, count);
> +}
> +
> +static ssize_t kbbl_blue_show(struct device *dev, struct device_attribute *attr,
> +               char *buf)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return show_u8(asus->kbbl_rgb.kbbl_blue, buf);
> +}
> +
> +static ssize_t kbbl_blue_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t count)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return store_u8(&asus->kbbl_rgb.kbbl_set_blue, buf, count);
> +}
> +
> +static ssize_t kbbl_mode_show(struct device *dev, struct device_attribute *attr,
> +               char *buf)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return show_u8(asus->kbbl_rgb.kbbl_mode, buf);
> +}
> +
> +static ssize_t kbbl_mode_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t count)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return store_u8(&asus->kbbl_rgb.kbbl_set_mode, buf, count);
> +}
> +
> +static ssize_t kbbl_speed_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return show_u8(asus->kbbl_rgb.kbbl_speed, buf);
> +}
> +
> +static ssize_t kbbl_speed_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t count)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return store_u8(&asus->kbbl_rgb.kbbl_set_speed, buf, count);
> +}
> +
> +static ssize_t kbbl_flags_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return show_u8(asus->kbbl_rgb.kbbl_set_flags, buf);
> +}
> +
> +static ssize_t kbbl_flags_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t count)
> +{
> +       struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +       return store_u8(&asus->kbbl_rgb.kbbl_set_flags, buf, count);
> +}
> +
> +static ssize_t kbbl_set_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       return scnprintf(buf, PAGE_SIZE,
> +                       "Write to configure RGB keyboard backlight\n");
> +}
> +
> +static int kbbl_rgb_write(struct asus_wmi *asus, int persistent)
> +{
> +       int err;
> +       u32 retval;
> +       u8 speed_byte;
> +       u8 mode_byte;
> +       u8 speed;
> +       u8 mode;
> +
> +       speed = asus->kbbl_rgb.kbbl_set_speed;
> +       switch (speed) {
> +       case 0:
> +       default:
> +               speed_byte = 0xe1; // slow
> +               speed = 0;
> +               break;
> +       case 1:
> +               speed_byte = 0xeb; // medium
> +               break;
> +       case 2:
> +               speed_byte = 0xf5; // fast
> +               break;
> +       }
> +
> +       mode = asus->kbbl_rgb.kbbl_set_mode;
> +       switch (mode) {
> +       case 0:
> +       default:
> +               mode_byte = 0x00; // static color
> +               mode = 0;
> +               break;
> +       case 1:
> +               mode_byte = 0x01; // breathing
> +               break;
> +       case 2:
> +               mode_byte = 0x02; // color cycle
> +               break;
> +       case 3:
> +               mode_byte = 0x0a; // strobing
> +               break;
> +       }
> +
> +       err = asus_wmi_evaluate_method_3dw(ASUS_WMI_METHODID_DEVS,
> +               ASUS_WMI_DEVID_KBD_RGB,
> +               (persistent ? 0xb4 : 0xb3) |
> +               (mode_byte << 8) |
> +               (asus->kbbl_rgb.kbbl_set_red << 16) |
> +               (asus->kbbl_rgb.kbbl_set_green << 24),
> +               (asus->kbbl_rgb.kbbl_set_blue) |
> +               (speed_byte << 8), &retval);
> +       if (err) {
> +               pr_warn("RGB keyboard device 1, write error: %d\n", err);
> +               return err;
> +       }
> +
> +       if (retval != 1) {
> +               pr_warn("RGB keyboard device 1, write error (retval): %x\n",
> +                               retval);
> +               return -EIO;
> +       }
> +
> +       err = asus_wmi_evaluate_method_3dw(ASUS_WMI_METHODID_DEVS,
> +               ASUS_WMI_DEVID_KBD_RGB2,
> +               (0xbd) |
> +               (asus->kbbl_rgb.kbbl_set_flags << 16) |
> +               (persistent ? 0x0100 : 0x0000), 0, &retval);
> +       if (err) {
> +               pr_warn("RGB keyboard device 2, write error: %d\n", err);
> +               return err;
> +       }
> +
> +       if (retval != 1) {
> +               pr_warn("RGB keyboard device 2, write error (retval): %x\n",
> +                               retval);
> +               return -EIO;
> +       }
> +
> +       asus->kbbl_rgb.kbbl_red = asus->kbbl_rgb.kbbl_set_red;
> +       asus->kbbl_rgb.kbbl_green = asus->kbbl_rgb.kbbl_set_green;
> +       asus->kbbl_rgb.kbbl_blue = asus->kbbl_rgb.kbbl_set_blue;
> +       asus->kbbl_rgb.kbbl_mode = mode;
> +       asus->kbbl_rgb.kbbl_speed = speed;
> +
> +       return 0;
> +}
> +
> +static ssize_t kbbl_set_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t count)
> +{
> +       u8 value;
> +       struct asus_wmi *asus;
> +       int result;
> +
> +       asus = dev_get_drvdata(dev);
> +       result = store_u8(&value, buf, count);
> +       if (result < 0)
> +               return result;
> +
> +       if (value == 1)
> +               kbbl_rgb_write(asus, 1);
> +       else if (value == 2)
> +               kbbl_rgb_write(asus, 0);
> +
> +       return count;
> +}
> +
> +/* RGB values: 00 .. ff */
> +static DEVICE_ATTR_RW(kbbl_red);
> +static DEVICE_ATTR_RW(kbbl_green);
> +static DEVICE_ATTR_RW(kbbl_blue);
> +
> +/*
> + * Color modes: 0 - static color, 1 - breathing, 2 - color cycle, 3 - strobing
> + */
> +static DEVICE_ATTR_RW(kbbl_mode);
> +
> +/* Speed for modes 1 and 2: 0 - slow, 1 - medium, 2 - fast */
> +static DEVICE_ATTR_RW(kbbl_speed);
> +
> +/*
> + * Enable: 02 - on boot (until module load) | 08 - awake | 20 - sleep
> + * (2a or ff to enable everything)
> + *
> + * Logically 80 would be shutdown, but no visible effects of this option
> + * were observed so far
> + */
> +static DEVICE_ATTR_RW(kbbl_flags);
> +
> +/* Write data: 1 - permanently, 2 - temporarily (reset after reboot) */
> +static DEVICE_ATTR_RW(kbbl_set);
> +
> +static struct attribute *rgbkb_sysfs_attributes[] = {
> +       &dev_attr_kbbl_red.attr,
> +       &dev_attr_kbbl_green.attr,
> +       &dev_attr_kbbl_blue.attr,
> +       &dev_attr_kbbl_mode.attr,
> +       &dev_attr_kbbl_speed.attr,
> +       &dev_attr_kbbl_flags.attr,
> +       &dev_attr_kbbl_set.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group kbbl_attribute_group = {
> +       .name = "kbbl",
> +       .attrs = rgbkb_sysfs_attributes
> +};
> +
> +static int kbbl_rgb_init(struct asus_wmi *asus)
> +{
> +       int err;
> +
> +       err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_RGB);
> +       if (err) {
> +               if (err == -ENODEV)
> +                       return 0;
> +               else
> +                       return err;
> +       }
> +
> +       err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_RGB2);
> +       if (err) {
> +               if (err == -ENODEV)
> +                       return 0;
> +               else
> +                       return err;
> +       }
> +
> +       asus->kbbl_rgb_available = true;
> +       return sysfs_create_group(&asus->platform_device->dev.kobj,
> +                       &kbbl_attribute_group);
> +}
> +
> +static void kbbl_rgb_exit(struct asus_wmi *asus)
> +{
> +       if (asus->kbbl_rgb_available) {
> +               sysfs_remove_group(&asus->platform_device->dev.kobj,
> +                               &kbbl_attribute_group);
> +       }
> +}
> +
>  /* RF *************************************************************************/
>
>  /*
> @@ -2230,6 +2554,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>         if (err)
>                 goto fail_leds;
>
> +       err = kbbl_rgb_init(asus);
> +       if (err)
> +               goto fail_rgbkb;
> +
>         asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_WLAN, &result);
>         if (result & (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT))
>                 asus->driver->wlan_ctrl_by_user = 1;
> @@ -2287,6 +2615,8 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_backlight:
>         asus_wmi_rfkill_exit(asus);
>  fail_rfkill:
> +       kbbl_rgb_exit(asus);
> +fail_rgbkb:
>         asus_wmi_led_exit(asus);
>  fail_leds:
>  fail_hwmon:
> @@ -2307,6 +2637,7 @@ static int asus_wmi_remove(struct platform_device *device)
>         asus_wmi_backlight_exit(asus);
>         asus_wmi_input_exit(asus);
>         asus_wmi_led_exit(asus);
> +       kbbl_rgb_exit(asus);
>         asus_wmi_rfkill_exit(asus);
>         asus_wmi_debugfs_exit(asus);
>         asus_wmi_platform_exit(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index a5fe7e68944b..c8c6e939e196 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -57,6 +57,8 @@
>  #define ASUS_WMI_DEVID_KBD_BACKLIGHT   0x00050021
>  #define ASUS_WMI_DEVID_LIGHT_SENSOR    0x00050022 /* ?? */
>  #define ASUS_WMI_DEVID_LIGHTBAR                0x00050025
> +#define ASUS_WMI_DEVID_KBD_RGB         0x00100056
> +#define ASUS_WMI_DEVID_KBD_RGB2                0x00100057
>
>  /* Misc */
>  #define ASUS_WMI_DEVID_CAMERA          0x00060013
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
