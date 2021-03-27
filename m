Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16034B94A
	for <lists+linux-api@lfdr.de>; Sat, 27 Mar 2021 21:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhC0U0F (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Mar 2021 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhC0UZc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 27 Mar 2021 16:25:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E35C0613B1
        for <linux-api@vger.kernel.org>; Sat, 27 Mar 2021 13:25:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b9so8891454wrt.8
        for <linux-api@vger.kernel.org>; Sat, 27 Mar 2021 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s8gzVxqzuc1k7in7AHl85pKPO4uHenSLvBWD/D32x1s=;
        b=HKBOAWkY+TK1W/RRlNJCrPiYtO35hOT0v4na7AtOn577L3fUIrSTK+slP+bZPtFczB
         rTz2g7ATJVmSVkQKtg35AMBc4/UQEsKHN3O1XDMfvdd3DM+ttF9FCuxjDvArIQ/2Xvma
         Z8tmj+IUnPQZY0pG8d26oazwN43iL9x0SinLCUvGRsQml6+Wl5YV8ZtcYCfrEoWHslQx
         +aJWMtGejacJsQjSoy1b8SwJzaHUh/DC/qyd0bq7x0d5pVkERnheHOi+xwaszSSpUtmQ
         HqfOLVwrZAbJazcTuF/IvjtTSrAlkA/GNaOJqhuqgiZISDENndr0RsRSX3D+mJRC9zIB
         PQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s8gzVxqzuc1k7in7AHl85pKPO4uHenSLvBWD/D32x1s=;
        b=D+CqM1whw2351HFsCpQcrgzaOVX8yJMHMQmeT3EN5LVPj4lPHuQ9gTrDYiRVfFnpWb
         2C/gfdVuemJwOnenFuKOA86KMLn4InWcGJv+JritUq1GwbxEyrkZ2/73OkYfw/vicWRo
         svkPTivjbiITfhTZxsHlwnnNZSslh9WlxJkI1mABCrberuXceJZmV8oaWIC9pk63Snbs
         PP9HFk+iHPWrw+Z5MTm/Dq81oed8yWpeNZrH7y/ryfQy5Jv/OL7MZ7J0W1y0mlO8jmw/
         Idh6zFHClAXfKWzdDR3qT/v40fGIDJoRmVNtfoyLRTvaKBLrZleP6/h8qrjuI3Zr0dDe
         2LFQ==
X-Gm-Message-State: AOAM530AP2976v3BLMglvuU0GMMm7nKXZ/H9v6xxspO8IX6QZp4WYOdr
        jBoqtVys0FkGD66GaLkNlaQXvbW/WOLV9Q==
X-Google-Smtp-Source: ABdhPJzuMpV1UB85AeDicHaBE3aPiyJvZp+lIVriNnz1Ivuxlawm4QYMNucTm4el2a8GiLjULkdAcA==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr21261121wrw.334.1616876730170;
        Sat, 27 Mar 2021 13:25:30 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2d8b:2e0e:777b:e562? ([2a01:e34:ed2f:f020:2d8b:2e0e:777b:e562])
        by smtp.googlemail.com with ESMTPSA id u8sm20285874wrr.42.2021.03.27.13.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 13:25:29 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/netlink: Add the temperature when
 crossing a trip point
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rkumbako@quicinc.com, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>
References: <20210325193633.19592-1-daniel.lezcano@linaro.org>
 <CAJZ5v0g58LMVwRWdJaTWVOx09gt6KRGTa974k3cvHYQyxk0EYg@mail.gmail.com>
 <444a7fc72e6525575b929760fcad186630577afc.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ae16d810-e5ec-ad63-7b29-fd1ddab68907@linaro.org>
Date:   Sat, 27 Mar 2021 21:25:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <444a7fc72e6525575b929760fcad186630577afc.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Hi Srinivas,

On 27/03/2021 18:46, Srinivas Pandruvada wrote:
> On Fri, 2021-03-26 at 17:37 +0100, Rafael J. Wysocki wrote:
>> On Thu, Mar 25, 2021 at 8:38 PM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>> The slope of the temperature increase or decrease can be high and
>>> when
>>> the temperature crosses the trip point, there could be a
>>> significant
>>> difference between the trip temperature and the measured
>>> temperatures.
>>>
>>> That forces the userspace to read the temperature back right after
>>> receiving a trip violation notification.
>>>
>>> In order to be efficient, give the temperature which resulted in
>>> the
>>> trip violation.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Srinivas, what do you think?
> 
> - IMO netlink message should also be treated as we treat other ABIs. So
> add only when this is a must. Although here GENL version is incremented
> , users are not that careful. At least on x86, we know users created
> their own applications.

I don't see where is the problem. The protocol is still compatible with
the previous version, so that does not break the existing AFAICT. That
is done on purpose.

There is a new attribute added, the application using the previous
version will just not be aware of its presence and parse the message
without getting the temperature.

> - Here the concern is temperature is changing so fast then netlink +
> user space processing latency is enough to change further to read
> temperature again. Atleast we assume that and read temperature again.
> So not sure that this is the right approach to add another field for
> the temperature.

I'm not sure to understand your comment. Whatever the mechanism
(interrupt based or polling), the temperature is read in any case by the
call to thermal_zone_device_update() which in turns calls
handle_trip_point and then send the message. So, why not add the
temperature as the userspace is interested on getting the temperature
anyway.

For instance, in polling mode, (usually set to 1000ms), the trip point
crossing is detected with a long delay and during this time the
temperature could be far beyond the trip temperature.

It is not about netlink latency but about avoiding a back and forth when
the trip point is crossed and the temperature wavering around.


>>> ---
>>>  drivers/thermal/thermal_core.c    |  6 ++++--
>>>  drivers/thermal/thermal_netlink.c | 11 ++++++-----
>>>  drivers/thermal/thermal_netlink.h |  8 ++++----
>>>  include/uapi/linux/thermal.h      |  2 +-
>>>  4 files changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c
>>> b/drivers/thermal/thermal_core.c
>>> index 996c038f83a4..948020ef51b1 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -430,10 +430,12 @@ static void handle_thermal_trip(struct
>>> thermal_zone_device *tz, int trip)
>>>         if (tz->last_temperature != THERMAL_TEMP_INVALID) {
>>>                 if (tz->last_temperature < trip_temp &&
>>>                     tz->temperature >= trip_temp)
>>> -                       thermal_notify_tz_trip_up(tz->id, trip);
>>> +                       thermal_notify_tz_trip_up(tz->id, trip,
>>> +                                                 tz->temperature);
>>>                 if (tz->last_temperature >= trip_temp &&
>>>                     tz->temperature < (trip_temp - hyst))
>>> -                       thermal_notify_tz_trip_down(tz->id, trip);
>>> +                       thermal_notify_tz_trip_down(tz->id, trip,
>>> +                                                   tz-
>>>> temperature);
>>>         }
>>>
>>>         if (type == THERMAL_TRIP_CRITICAL || type ==
>>> THERMAL_TRIP_HOT)
>>> diff --git a/drivers/thermal/thermal_netlink.c
>>> b/drivers/thermal/thermal_netlink.c
>>> index 1234dbe95895..a16dd4d5d710 100644
>>> --- a/drivers/thermal/thermal_netlink.c
>>> +++ b/drivers/thermal/thermal_netlink.c
>>> @@ -121,7 +121,8 @@ static int thermal_genl_event_tz(struct param
>>> *p)
>>>  static int thermal_genl_event_tz_trip_up(struct param *p)
>>>  {
>>>         if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id)
>>> ||
>>> -           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p-
>>>> trip_id))
>>> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p-
>>>> trip_id) ||
>>> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p-
>>>> temp))
>>>                 return -EMSGSIZE;
>>>
>>>         return 0;
>>> @@ -285,16 +286,16 @@ int thermal_notify_tz_disable(int tz_id)
>>>         return
>>> thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
>>>  }
>>>
>>> -int thermal_notify_tz_trip_down(int tz_id, int trip_id)
>>> +int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
>>>  {
>>> -       struct param p = { .tz_id = tz_id, .trip_id = trip_id };
>>> +       struct param p = { .tz_id = tz_id, .trip_id = trip_id,
>>> .temp = temp };
>>>
>>>         return
>>> thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
>>>  }
>>>
>>> -int thermal_notify_tz_trip_up(int tz_id, int trip_id)
>>> +int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
>>>  {
>>> -       struct param p = { .tz_id = tz_id, .trip_id = trip_id };
>>> +       struct param p = { .tz_id = tz_id, .trip_id = trip_id,
>>> .temp = temp };
>>>
>>>         return
>>> thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
>>>  }
>>> diff --git a/drivers/thermal/thermal_netlink.h
>>> b/drivers/thermal/thermal_netlink.h
>>> index 828d1dddfa98..e554f76291f4 100644
>>> --- a/drivers/thermal/thermal_netlink.h
>>> +++ b/drivers/thermal/thermal_netlink.h
>>> @@ -11,8 +11,8 @@ int thermal_notify_tz_create(int tz_id, const
>>> char *name);
>>>  int thermal_notify_tz_delete(int tz_id);
>>>  int thermal_notify_tz_enable(int tz_id);
>>>  int thermal_notify_tz_disable(int tz_id);
>>> -int thermal_notify_tz_trip_down(int tz_id, int id);
>>> -int thermal_notify_tz_trip_up(int tz_id, int id);
>>> +int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
>>> +int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
>>>  int thermal_notify_tz_trip_delete(int tz_id, int id);
>>>  int thermal_notify_tz_trip_add(int tz_id, int id, int type,
>>>                                int temp, int hyst);
>>> @@ -49,12 +49,12 @@ static inline int thermal_notify_tz_disable(int
>>> tz_id)
>>>         return 0;
>>>  }
>>>
>>> -static inline int thermal_notify_tz_trip_down(int tz_id, int id)
>>> +static inline int thermal_notify_tz_trip_down(int tz_id, int id,
>>> int temp)
>>>  {
>>>         return 0;
>>>  }
>>>
>>> -static inline int thermal_notify_tz_trip_up(int tz_id, int id)
>>> +static inline int thermal_notify_tz_trip_up(int tz_id, int id, int
>>> temp)
>>>  {
>>>         return 0;
>>>  }
>>> diff --git a/include/uapi/linux/thermal.h
>>> b/include/uapi/linux/thermal.h
>>> index c105054cbb57..bf5d9c8ef16f 100644
>>> --- a/include/uapi/linux/thermal.h
>>> +++ b/include/uapi/linux/thermal.h
>>> @@ -18,7 +18,7 @@ enum thermal_trip_type {
>>>
>>>  /* Adding event notification support elements */
>>>  #define THERMAL_GENL_FAMILY_NAME               "thermal"
>>> -#define THERMAL_GENL_VERSION                   0x01
>>> +#define THERMAL_GENL_VERSION                   0x02
>>>  #define THERMAL_GENL_SAMPLING_GROUP_NAME       "sampling"
>>>  #define THERMAL_GENL_EVENT_GROUP_NAME          "event"
>>>
>>> --
>>> 2.17.1
>>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
