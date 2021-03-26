Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF45234AE0F
	for <lists+linux-api@lfdr.de>; Fri, 26 Mar 2021 18:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCZR43 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Mar 2021 13:56:29 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44919 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhCZR4E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Mar 2021 13:56:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616781364; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=u/VtdjESDjksBi2yOB2iBmWEjhKxDbDuGwlnPRV1uLA=; b=GHBz2uqSD9Y6E07Q0ejp81ntAR8pZyi5keZZFB2BiCcK04WWgIxtiL195EfblFkZkJHzlvvQ
 AdSAlllk2vHVQSl6Ju8zMduUfBabF36oi9jX+62YuYdXVRi4aMq/QfsUXsoJEXbSMJ71pjrx
 n/eAiQ6C/WLKbak0nYn8Y1wbQs0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxZDM4ZSIsICJsaW51eC1hcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 605e2029c39407c32726aac2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Mar 2021 17:55:53
 GMT
Sender: rkumbako=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69789C433ED; Fri, 26 Mar 2021 17:55:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.64] (unknown [209.131.238.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkumbako)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65822C433CA;
        Fri, 26 Mar 2021 17:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65822C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rkumbako@codeaurora.org
Subject: Re: [PATCH] thermal/drivers/netlink: Add the temperature when
 crossing a trip point
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rkumbako@quicinc.com, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>
References: <20210325193633.19592-1-daniel.lezcano@linaro.org>
From:   Ram Chandrasekar <rkumbako@codeaurora.org>
Message-ID: <626b2fa4-73f7-86b5-8b94-689334316ede@codeaurora.org>
Date:   Fri, 26 Mar 2021 11:55:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325193633.19592-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 3/25/2021 1:36 PM, Daniel Lezcano wrote:
> The slope of the temperature increase or decrease can be high and when
> the temperature crosses the trip point, there could be a significant
> difference between the trip temperature and the measured temperatures.
> 
> That forces the userspace to read the temperature back right after
> receiving a trip violation notification.
> 
> In order to be efficient, give the temperature which resulted in the
> trip violation.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

To add to Daniel's point, this patch will save a lot of back and forth 
between userspace and kernel, when the temperature is hovering around 
the trip temperature.

Certain sensors are capable of supporting temperatures with more 
granular resolution (like deci C). In those cases after a trip occurs, a 
0.1 C reduction in temperature when userspace reads will make it wait 
for some more time before taking an action.

It is not just a delay in action, but more trip notifications before 
userspace reads the temperature above trip to take an action.

I have seen this back and forth in Snapdragon chipsets.

This patch helps userspace to see the same temperature as thermal 
framework and temperature violations can be handled faster and more 
efficiently.

> ---
>   drivers/thermal/thermal_core.c    |  6 ++++--
>   drivers/thermal/thermal_netlink.c | 11 ++++++-----
>   drivers/thermal/thermal_netlink.h |  8 ++++----
>   include/uapi/linux/thermal.h      |  2 +-
>   4 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 996c038f83a4..948020ef51b1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -430,10 +430,12 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>   	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
>   		if (tz->last_temperature < trip_temp &&
>   		    tz->temperature >= trip_temp)
> -			thermal_notify_tz_trip_up(tz->id, trip);
> +			thermal_notify_tz_trip_up(tz->id, trip,
> +						  tz->temperature);
>   		if (tz->last_temperature >= trip_temp &&
>   		    tz->temperature < (trip_temp - hyst))
> -			thermal_notify_tz_trip_down(tz->id, trip);
> +			thermal_notify_tz_trip_down(tz->id, trip,
> +						    tz->temperature);
>   	}
>   
>   	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index 1234dbe95895..a16dd4d5d710 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -121,7 +121,8 @@ static int thermal_genl_event_tz(struct param *p)
>   static int thermal_genl_event_tz_trip_up(struct param *p)
>   {
>   	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> -	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id))
> +	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
> +	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
>   		return -EMSGSIZE;
>   
>   	return 0;
> @@ -285,16 +286,16 @@ int thermal_notify_tz_disable(int tz_id)
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
>   }
>   
> -int thermal_notify_tz_trip_down(int tz_id, int trip_id)
> +int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
>   {
> -	struct param p = { .tz_id = tz_id, .trip_id = trip_id };
> +	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
>   
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
>   }
>   
> -int thermal_notify_tz_trip_up(int tz_id, int trip_id)
> +int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
>   {
> -	struct param p = { .tz_id = tz_id, .trip_id = trip_id };
> +	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
>   
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
>   }
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
> index 828d1dddfa98..e554f76291f4 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -11,8 +11,8 @@ int thermal_notify_tz_create(int tz_id, const char *name);
>   int thermal_notify_tz_delete(int tz_id);
>   int thermal_notify_tz_enable(int tz_id);
>   int thermal_notify_tz_disable(int tz_id);
> -int thermal_notify_tz_trip_down(int tz_id, int id);
> -int thermal_notify_tz_trip_up(int tz_id, int id);
> +int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
> +int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
>   int thermal_notify_tz_trip_delete(int tz_id, int id);
>   int thermal_notify_tz_trip_add(int tz_id, int id, int type,
>   			       int temp, int hyst);
> @@ -49,12 +49,12 @@ static inline int thermal_notify_tz_disable(int tz_id)
>   	return 0;
>   }
>   
> -static inline int thermal_notify_tz_trip_down(int tz_id, int id)
> +static inline int thermal_notify_tz_trip_down(int tz_id, int id, int temp)
>   {
>   	return 0;
>   }
>   
> -static inline int thermal_notify_tz_trip_up(int tz_id, int id)
> +static inline int thermal_notify_tz_trip_up(int tz_id, int id, int temp)
>   {
>   	return 0;
>   }
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index c105054cbb57..bf5d9c8ef16f 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -18,7 +18,7 @@ enum thermal_trip_type {
>   
>   /* Adding event notification support elements */
>   #define THERMAL_GENL_FAMILY_NAME		"thermal"
> -#define THERMAL_GENL_VERSION			0x01
> +#define THERMAL_GENL_VERSION			0x02
>   #define THERMAL_GENL_SAMPLING_GROUP_NAME	"sampling"
>   #define THERMAL_GENL_EVENT_GROUP_NAME		"event"
>   
> 
