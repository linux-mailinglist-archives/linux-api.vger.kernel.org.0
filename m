Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907D51922E
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 21:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEITE7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 15:04:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46941 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfEITE7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 15:04:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so3852737wrr.13;
        Thu, 09 May 2019 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KNkXkUX+WxA26kQpUG6N8wLW+pdYHuf5EvTZnefgm+Y=;
        b=tAhmBPN5m0jbDt3q3P5gw8WD4xxEv9xNvZ4x84L7cPdXNcV86wQ0yySuzLidI9/NO7
         0tWBZiq8czBtbHCP70SlzjhTSloBa0R1cAhPO6NBmNKuHX6aJQvO0RPeP+z5CDxaWZbG
         DWJkQ96g1JoUWnlAwYa0e1nst8Dq1Lgra+zczKUBV8Pm/LH8IE5fcc8fdDAS5XoX1DkP
         w6OnNKbi1H7FLixj8NekRWUPW9mu+z5o8Tokc4Smf/Uhnf2IfwWojI57s4ewhl3O0sPC
         OR9RSuJXpmKpBNvQLpVT/B8UDODPkztbwc0FL7mes50XKtdsuxDVW6Ezfw9mxSVwN+ey
         Hhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KNkXkUX+WxA26kQpUG6N8wLW+pdYHuf5EvTZnefgm+Y=;
        b=Lv1qKc2/YOA0q8o7+stfrlLsowsoVGsaE81D9QQSzDVqNIdaq70MBi8H3FrqH2qsu5
         jSZooFnTTE6JRPuwQYMj2qaWwT3n4HchhMdCFS+KC4ZS2X8eJ+28BlAEdSZpgG2GGzrN
         ReXOz5GqMqvnfeaMuMfcq9o3ind40eK2k+slurKBOrPiEcodkcF7xXZMHyff3DigpeuK
         Su0o6A/MA0DluD+uSfXsCLaLRswwe3s1rdPYXZ6mf1IvHNtkf6+PG+MEFb3jn60P8c9B
         mhtdm3+NvnX5RPE1QrC4fE9w4u/FJ65f4peuFlVX4dOXpcfLt9i8BUWlJY8ei+VLrEVl
         5stw==
X-Gm-Message-State: APjAAAWQEnfXyA6uk/4PMUFhU5f0OSgCG9Z7P3T8+LsRbbVT1EeisIaJ
        QB4JK1emxD251ginPZW+06POPSTCUnw=
X-Google-Smtp-Source: APXvYqxBetp7L4QZnDlkzIz1Wa5SXvMCrIMj4u5PDYkGpZpqCqxnTRfjPW5SQFkHX+EDucjSHVfhXQ==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr4239485wrs.5.1557428696932;
        Thu, 09 May 2019 12:04:56 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id d4sm8661231wrf.7.2019.05.09.12.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:04:56 -0700 (PDT)
Subject: Re: [PATCH v3 09/11] platform/x86: asus-wmi: Control RGB keyboard
 backlight
To:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <c953b43b-6186-77e9-54b1-b1cd1d7d1eb6@gmail.com>
 <CAHp75Vf9uPG7_K0P26nHYCH0WB6LFX3wk8aJBpLWQ-r46kDw9w@mail.gmail.com>
 <20190508171229.GA22024@amd>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <52e73640-9fbf-437b-537a-7b3dc167052f@gmail.com>
Date:   Thu, 9 May 2019 21:04:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508171229.GA22024@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

First of all, thanks to Andy for all the review comments!

I will implement all the ones that I didn't directly answer on as well and
update this series shortly.

Regarding this patch,

On 08.05.19 19:12, Pavel Machek wrote:
>> Shouldn't be the LED subsystem driver for this?
> 
> Yes, please. We have common interface for LED drivers; this needs to
> use it.

That is indeed a better option and I did in fact considered this first and
even did a test implementation. The discoveries were:
1. The WMI methods are write-only and only written all at once in a
transaction manner (also invoking solely first RGB-interface method has no
effect until some other keyboard backlight method is called).
2. In addition to RGB there are several control values, which switch
effects, speed and enable or disable the backlight under specific
conditions or switch whether it is set temporarily or permanently (not that
these are critical functionalities, but for the sake of completeness).
3. The EC is really slow
# time bash -c "echo 1 > /sys/devices/platform/faustus/kbbl_set"

real	0m0,691s
user	0m0,000s
sys	0m0,691s

(please ignore the sysfs-path there, it's essentially the same code running
as in this patch). It is consistently same for both temporary and permanent
configuration. Writing after every change would take about (6+)x of that.
Not that it's that unbearable though as it is not likely to be done often.

I was not quite happy with that implementation so I opted for writing sort
of sysfs wrapper instead that would allow same sort of transactions as
provided by BIOS. I agree that it's non-standard solution.

If I understood correctly, the typical current RGB led_class devices from
the Linux tree currently provide channels as separate LEDs. There are also
blink / pattern options present, I guess one could misuse them for setting
effects and speed. So one could make 3 devices for RGB + 3 for awake,
sleep, boot modes + 1 for setting effect / speed.

I'd guess the end solution might be also either something like combination
of both approaches (RGB leds + separate sysfs interface) or some extension
of the led_class device interface. Dropping support of the non-essential
features for the sake of uniformity of ABI would also be an option to
consider (exposing just three RGB LEDs with brightness only), not happy one
though.

In any case this looks like it might need some additional research,
discussion, development, and a pair of iterations so I tend to separate
this patch from the series and post it extra after the others are through
to avoid dragging 10+ patches around.

Any suggestions on how to do this properly would be appreciated. That's the
best I could come up with at the moment.

Thanks,
Yurii
