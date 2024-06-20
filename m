Return-Path: <linux-api+bounces-1773-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D1191143B
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 23:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A41828348D
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB94778C;
	Thu, 20 Jun 2024 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="qOqKFpzH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mObbYhUw"
X-Original-To: linux-api@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE31C680;
	Thu, 20 Jun 2024 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918272; cv=none; b=eki78AsNMhBg8aJFYgZ+vG2AQX4gn/883yk13quTOI51ZaIiQ5r/CIqmoygGpyt6585aBmk7OvpBVRnQvgY36DUbkQ4UKFthR1I9Njuu2V7ebJCo8FZJX1vcWivjstJ/zNIoHiFwBWhGF8ENpK9pBRATX4nRmufTm7CLhOP3s+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918272; c=relaxed/simple;
	bh=T2gwHDdc9Tod8b6ktA6VzB1vpXhcZb4a8lvBsxKXk14=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=WQigrP8/fUi2LG47rT3tvdLfgxNQ8FTqlfiYqZZZf+j21fDQESRoF65H0+fr0mxICzAYVJ4MquB5ndnW+r2XXR9bTtP+6DIM4xV9+zGrUZHshKsZ5tFbayEHocLW1xnQu3HX8CyMEY8tDpFNJFMDmXj47S3CJsFS7cJqDz+72iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=qOqKFpzH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mObbYhUw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id F0AF9138010C;
	Thu, 20 Jun 2024 17:17:48 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Thu, 20 Jun 2024 17:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718918268; x=1719004668; bh=LAJs70sW5j
	F761s2Vy7XDvqb/IgHN1Sn0OrYklHiPlY=; b=qOqKFpzHAIJqkhW691+ydiuNOL
	mTLlrzPAqEiNAC91yj1yiPVrPllfi0JhY0haDbMfVmy8Mi0A10rtf6qLyrSV7xH6
	xBSDTqBM+duo/FWm3N4HvebxdLkm+5GHOhVtZ6dDNKjNK+8I7NxkCfymHmlhGufz
	pxAVmu3RTZ7lYdyxgQQrDp+lcIEC12X19wjmZWzFQXFW6z+NYR1RbZ9/L8d7EZ09
	kvLlN9QNQRgJqjFsloTv045RUUJuWKnsLsM/avuJwbvAQedLYqIE0458L9oraSE4
	qSzQ1L1bme8vK+hl1pXtBC3unlk9naDEuyeLiGFuyIyL1L6/GMEiWdYjGZbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718918268; x=1719004668; bh=LAJs70sW5jF761s2Vy7XDvqb/IgH
	N1Sn0OrYklHiPlY=; b=mObbYhUwL+H03anOcCxQZGsOjvW31oY8Snh4yJAyn9Ph
	pJR90lagSw46cIWZOFLF7iU4EfkoLfMuoPGqG6mmjbPHzK6pOHvi5ITvyb6bfS/m
	w+ACZO8bEyv96e6cA8XsW0cTT8GeVMh0y7wmP+GxWFUShLVu1JBKa6552yw18mbC
	AchsnSyRszr0islGwAdLLjYfTDYsmiy9YQ4z3HFIlxB5ONslmfdxlMXNjdX13F8t
	ENJTTJ1g3BbbXiiW5BUR9d+KszO+pV3oVu6GPhmUL4H+WxXueyQ3zeE2NlS58FE/
	uPeS4dkpnG3XeCBVJIajtysVUB4t8FXdAjwcIB67LQ==
X-ME-Sender: <xms:fJx0ZkNPgjdETLhwgRxjoq5scfOnBF-JNtn6p7S1qCsCrjZTKAnZfg>
    <xme:fJx0Zq8NbCmt4CidPcRQx0U2skC2VZWIGm6lmt-6A8gJ5j4HWoOsAOGo3W5_uBg-G
    G5npgS836ECy_Rikzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepleffveevfffhueetteetveetleetuddugfejvdeljeetteelhfeiiedugfev
    leefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:fJx0ZrRlAQ7S91LTLbQTFDVpkC-lGKXRHZapG0GUgNrKzzuDaBrexg>
    <xmx:fJx0Zstxy1aJGpS5Bn8t-aUjcpS3FWL5jR1XX1LpsVxi2n7Rglm5IQ>
    <xmx:fJx0ZseZQ-p9K5C6XweCDq81MCBdUDJJ6x_bPeP7Li3xlDPeE3BurQ>
    <xmx:fJx0Zg3gS1F1Sdxd9u4UqsbLzXD47mF7I-yGLYxqpmV6T3or026CDw>
    <xmx:fJx0ZhEpZS_eVEfJDgLNfu1SNN40h2dLNzYwhS5_v0J1YnFh94sYZjLQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1BADD2340080; Thu, 20 Jun 2024 17:17:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <19cb366a-e6d8-4608-98c9-0fad389363ee@app.fastmail.com>
In-Reply-To: <20240620082223.20178-3-dev@doubly.so>
References: <20240620082223.20178-1-dev@doubly.so>
 <20240620082223.20178-3-dev@doubly.so>
Date: Fri, 21 Jun 2024 09:17:27 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Devin Bayer" <dev@doubly.so>, corentin.chary@gmail.com
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: support newer fan_boost_mode dev_id
Content-Type: text/plain

On Thu, 20 Jun 2024, at 8:22 PM, Devin Bayer wrote:
> Support changing the fan mode (silent, performance, standard). I reused
> the existing fan_boost_mode sysfs entry.
> 
> Signed-off-by: Devin Bayer <dev@doubly.so>
> ---
> drivers/platform/x86/asus-wmi.c            | 87 ++++++++++++++++++++--
> include/linux/platform_data/x86/asus-wmi.h |  1 +
> 2 files changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 5585f15e7920..e27b8f86d57b 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -73,7 +73,6 @@ module_param(fnlock_default, bool, 0444);
> #define NOTIFY_LID_FLIP_ROG 0xbd
>  
> #define ASUS_WMI_FNLOCK_BIOS_DISABLED BIT(0)
> -#define ASUS_WMI_DEVID_CAMERA_LED 0x00060079

Be careful not to introduce extraneous changes.

>  
> #define ASUS_MID_FAN_DESC "mid_fan"
> #define ASUS_GPU_FAN_DESC "gpu_fan"
> @@ -94,6 +93,10 @@ module_param(fnlock_default, bool, 0444);
> #define ASUS_FAN_BOOST_MODE_SILENT_MASK 0x02
> #define ASUS_FAN_BOOST_MODES_MASK 0x03
>  
> +#define ASUS_FAN_BOOST_MODE2_NORMAL 0
> +#define ASUS_FAN_BOOST_MODE2_SILENT 1
> +#define ASUS_FAN_BOOST_MODE2_OVERBOOST 2
> +
> #define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT 0
> #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST 1
> #define ASUS_THROTTLE_THERMAL_POLICY_SILENT 2
> @@ -268,6 +271,7 @@ struct asus_wmi {
> int agfn_pwm;
>  
> bool fan_boost_mode_available;
> + u32 fan_boost_mode_dev_id;
> u8 fan_boost_mode_mask;
> u8 fan_boost_mode;
>  
> @@ -3019,14 +3023,14 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
>  
> /* Fan mode *******************************************************************/
>  
> -static int fan_boost_mode_check_present(struct asus_wmi *asus)
> +static int fan_boost_mode1_check_present(struct asus_wmi *asus)
> {
> u32 result;
> int err;
>  
> - asus->fan_boost_mode_available = false;
> + asus->fan_boost_mode_dev_id = ASUS_WMI_DEVID_FAN_BOOST_MODE;
>  
> - err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE,
> + err = asus_wmi_get_devstate(asus, asus->fan_boost_mode_dev_id,
>     &result);
> if (err) {
> if (err == -ENODEV)
> @@ -3044,16 +3048,87 @@ static int fan_boost_mode_check_present(struct asus_wmi *asus)
> return 0;
> }
>  
> +static int fan_boost_mode2_check_present(struct asus_wmi *asus)
> +{
> + u32 result;
> + int err;
> +
> + asus->fan_boost_mode_mask = ASUS_FAN_BOOST_MODES_MASK;
> + asus->fan_boost_mode_dev_id = ASUS_WMI_DEVID_FAN_BOOST_MODE2;
> +
> + err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE2,
> +     &result);
> + if (err) {
> + if (err == -ENODEV)
> + return 0;
> + else
> + return err;
> + }
> +
> + if (! (result & ASUS_WMI_DSTS_PRESENCE_BIT))
> + return 0;
> +
> + asus->fan_boost_mode_available = true;
> +
> + if (result & ASUS_FAN_BOOST_MODE2_SILENT) {
> + asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_SILENT;
> + } else if(result & ASUS_FAN_BOOST_MODE2_OVERBOOST) {
> + asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_OVERBOOST;
> + } else {
> + asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_NORMAL;
> + }
> +
> + return 0;
> +}
> +
> +static int fan_boost_mode_check_present(struct asus_wmi *asus)
> +{
> + int err;
> +
> + asus->fan_boost_mode_available = false;
> +
> + err = fan_boost_mode1_check_present(asus);
> + if (err)
> + return err;
> +
> + if (!asus->fan_boost_mode_available) {
> + err = fan_boost_mode2_check_present(asus);
> + }
> +
> + return err;
> +}
> +
> static int fan_boost_mode_write(struct asus_wmi *asus)
> {
> u32 retval;
> u8 value;
> + u8 hw_value;
> int err;
>  
> value = asus->fan_boost_mode;
>  
> - pr_info("Set fan boost mode: %u\n", value);
> - err = asus_wmi_set_devstate(ASUS_WMI_DEVID_FAN_BOOST_MODE, value,
> + /* transform userspace values into hardware values */
> + if(asus->fan_boost_mode_dev_id == ASUS_WMI_DEVID_FAN_BOOST_MODE2) {
> + switch(value) {
> + case ASUS_FAN_BOOST_MODE_SILENT:
> + hw_value = ASUS_FAN_BOOST_MODE2_SILENT;
> + break;
> + case ASUS_FAN_BOOST_MODE_OVERBOOST:
> + hw_value = ASUS_FAN_BOOST_MODE2_OVERBOOST;
> + break;
> + case ASUS_FAN_BOOST_MODE_NORMAL:
> + hw_value = ASUS_FAN_BOOST_MODE2_NORMAL;
> + break;
> + default:
> + return -EINVAL;
> +
> + }
> + } else {
> + hw_value = value;
> + }
> +
> + pr_info("Set fan boost mode: user=%u hw=%u\n", value, hw_value);
> + err = asus_wmi_set_devstate(asus->fan_boost_mode_dev_id, hw_value,
>     &retval);
>  
> sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index b3c35e33f1e7..62982f67d632 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -65,6 +65,7 @@
> /* Writing a brightness re-enables the screen if disabled */
> #define ASUS_WMI_DEVID_SCREENPAD_LIGHT 0x00050032
> #define ASUS_WMI_DEVID_FAN_BOOST_MODE 0x00110018
> +#define ASUS_WMI_DEVID_FAN_BOOST_MODE2 0x00110019
> #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
>  
> /* Misc */
> -- 
> 2.45.2
> 
> 


Thank you for the work on this. But I must point out that the same 0x00110019 method has already been submitted as a patch to work with the existing "throttle_thermal" functionality, which itself is also tied to platoform_profile class support.

See https://lore.kernel.org/platform-driver-x86/20240609144849.2532-1-mohamed.ghanmi@supcom.tn/T/#mcd18e74676084e21d5c15af84bc08d8c6b375fb9

If you could submit only the first patch instead please?

