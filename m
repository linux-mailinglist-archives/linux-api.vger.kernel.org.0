Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54754423D9D
	for <lists+linux-api@lfdr.de>; Wed,  6 Oct 2021 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhJFMWl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Oct 2021 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbhJFMWk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Oct 2021 08:22:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB2C061755
        for <linux-api@vger.kernel.org>; Wed,  6 Oct 2021 05:20:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t2so8241524wrb.8
        for <linux-api@vger.kernel.org>; Wed, 06 Oct 2021 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tu1xtgEkYty/PIegA82o+6LZkpUw1A+ZXk3x5u90I1k=;
        b=LLkpZ7uo3KRMksQIVfJneZVtINq6roEAmndjT3u0BQPu7Us1sKOyan0xM2SlLAtEjC
         L5ErMwdYyZVMhapuiMM8H5LbgBFOBmwRaFmpHJ1aK9m14jokvwJq6DnqOWZqyxeTTZK6
         TFnljEXO6dqIfhwJBuigISBVpBFHzxWtlZVDQiOissGFMl0ANQ5HoYk+0HVbg1ChS1XV
         t9kfc0kcS19gZ6yTu4Qnqpk5LLfZ5dPzeOk0XDq5LT5XGPpWaYuIZWiIWq4vbVp637ng
         AAkZ6/aPvGhgNHbhyCVu+KuI5UQUUc4jlkWGsK9Usgv2zB7lA2crfzWFtXLYl5mD1LTp
         ipEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tu1xtgEkYty/PIegA82o+6LZkpUw1A+ZXk3x5u90I1k=;
        b=jkqhw49M1jFH+TKKabYpmx1OHKe/fEstJnNQYDD6VRWRw6dUGsf7enGlKtEvEUGQ5d
         gJekR964qGzbkwowi6W++D0vCFM9HTJfxZ0abxx1laIHWsuXIKTlpOTgDoKHj2PrqC+L
         nBk8CWjCpdIR0fLGxDA8VQg6QZw0uGJCrvUVXX9q/B7celhGbFtfMLSj8tCidugx7MSw
         BKZfZYK9O/l01lda8c5m8WpfzWbK7yiVajkcjXRn25sq3PURx98ERkrhpRwrRr3/S1ZM
         IZRbqwV9e4IFAgt9peG8S3Ia2CViu2Tgx2oDT5hr9svulz0N9EYAB5+5sHUD1dKQjygZ
         YZKg==
X-Gm-Message-State: AOAM531kuE4IbvaOibJZaA48jUppw113ePybv/aWC53pVqbEA/+RXI9A
        8darQfkxXf0oJA+9JsNYNhyVXw==
X-Google-Smtp-Source: ABdhPJwJegLLCtMVaJCfMDU2HhL4qWXk5XJO3dVZmr5hru0RW/Kow+iRwJ9XRWN/VAm3r2/YcLPq0w==
X-Received: by 2002:a1c:9d50:: with SMTP id g77mr9356331wme.58.1633522846559;
        Wed, 06 Oct 2021 05:20:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:278:1f59:2992:87fe? ([2a01:e34:ed2f:f020:278:1f59:2992:87fe])
        by smtp.googlemail.com with ESMTPSA id b15sm24606394wru.9.2021.10.06.05.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 05:20:45 -0700 (PDT)
Subject: Re: [PATCH RESEND] thermal/drivers/netlink: Add the temperature when
 crossing a trip point
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>, rkumbako@quicinc.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20211001223323.1836640-1-daniel.lezcano@linaro.org>
 <CAJZ5v0hcHq2WJ6UkdDbHynnQYv4MukCWXob_rH=Sa=aYDrr7Cw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dfbdfdab-8817-3792-9361-b238dc256219@linaro.org>
Date:   Wed, 6 Oct 2021 14:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hcHq2WJ6UkdDbHynnQYv4MukCWXob_rH=Sa=aYDrr7Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 05/10/2021 17:20, Rafael J. Wysocki wrote:
> On Sat, Oct 2, 2021 at 12:33 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The slope of the temperature increase or decrease can be high and when
>> the temperature crosses the trip point, there could be a significant
>> difference between the trip temperature and the measured temperatures.
>>
>> That forces the userspace to read the temperature back right after
>> receiving a trip violation notification.
>>
>> In order to be efficient, give the temperature which resulted in the
>> trip violation.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> This looks fine to me too.
> 
>> ---
>>  drivers/thermal/thermal_core.c    |  6 ++++--
>>  drivers/thermal/thermal_netlink.c | 11 ++++++-----
>>  drivers/thermal/thermal_netlink.h |  8 ++++----
>>  3 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 51374f4e1cca..9e243d9f929e 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -375,10 +375,12 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>>         if (tz->last_temperature != THERMAL_TEMP_INVALID) {
>>                 if (tz->last_temperature < trip_temp &&
>>                     tz->temperature >= trip_temp)
>> -                       thermal_notify_tz_trip_up(tz->id, trip);
>> +                       thermal_notify_tz_trip_up(tz->id, trip,
>> +                                                 tz->temperature);
>>                 if (tz->last_temperature >= trip_temp &&
>>                     tz->temperature < (trip_temp - hyst))
>> -                       thermal_notify_tz_trip_down(tz->id, trip);
>> +                       thermal_notify_tz_trip_down(tz->id, trip,
>> +                                                   tz->temperature);
> 
> While at it, I'm not sure if all of the additional line breaks due to
> the line length limit are really necessary.  The code would be easier
> to follow without them IMV.

Ok let me write another patch to wrap those into a single function and
reduce the indentation.

>>         }
>>
>>         if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
>> index 1234dbe95895..a16dd4d5d710 100644
>> --- a/drivers/thermal/thermal_netlink.c
>> +++ b/drivers/thermal/thermal_netlink.c
>> @@ -121,7 +121,8 @@ static int thermal_genl_event_tz(struct param *p)
>>  static int thermal_genl_event_tz_trip_up(struct param *p)
>>  {
>>         if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
>> -           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id))
>> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
>> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
>>                 return -EMSGSIZE;
>>
>>         return 0;
>> @@ -285,16 +286,16 @@ int thermal_notify_tz_disable(int tz_id)
>>         return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
>>  }
>>
>> -int thermal_notify_tz_trip_down(int tz_id, int trip_id)
>> +int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
>>  {
>> -       struct param p = { .tz_id = tz_id, .trip_id = trip_id };
>> +       struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
>>
>>         return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
>>  }
>>
>> -int thermal_notify_tz_trip_up(int tz_id, int trip_id)
>> +int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
>>  {
>> -       struct param p = { .tz_id = tz_id, .trip_id = trip_id };
>> +       struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
>>
>>         return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
>>  }
>> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
>> index 828d1dddfa98..e554f76291f4 100644
>> --- a/drivers/thermal/thermal_netlink.h
>> +++ b/drivers/thermal/thermal_netlink.h
>> @@ -11,8 +11,8 @@ int thermal_notify_tz_create(int tz_id, const char *name);
>>  int thermal_notify_tz_delete(int tz_id);
>>  int thermal_notify_tz_enable(int tz_id);
>>  int thermal_notify_tz_disable(int tz_id);
>> -int thermal_notify_tz_trip_down(int tz_id, int id);
>> -int thermal_notify_tz_trip_up(int tz_id, int id);
>> +int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
>> +int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
>>  int thermal_notify_tz_trip_delete(int tz_id, int id);
>>  int thermal_notify_tz_trip_add(int tz_id, int id, int type,
>>                                int temp, int hyst);
>> @@ -49,12 +49,12 @@ static inline int thermal_notify_tz_disable(int tz_id)
>>         return 0;
>>  }
>>
>> -static inline int thermal_notify_tz_trip_down(int tz_id, int id)
>> +static inline int thermal_notify_tz_trip_down(int tz_id, int id, int temp)
>>  {
>>         return 0;
>>  }
>>
>> -static inline int thermal_notify_tz_trip_up(int tz_id, int id)
>> +static inline int thermal_notify_tz_trip_up(int tz_id, int id, int temp)
>>  {
>>         return 0;
>>  }
>> --
>> 2.25.1
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
