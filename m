Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B696BE400
	for <lists+linux-api@lfdr.de>; Fri, 17 Mar 2023 09:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCQIlF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Mar 2023 04:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCQIkn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Mar 2023 04:40:43 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB73E2536
        for <linux-api@vger.kernel.org>; Fri, 17 Mar 2023 01:39:12 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PdHbk65rVzMrFtq;
        Fri, 17 Mar 2023 09:38:58 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PdHbj33c2zMtj7j;
        Fri, 17 Mar 2023 09:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1679042338;
        bh=gEFNZNyzzNkTkIX589egniVJsyrpQ5YQ4cGwXbnxpWY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1Oels4oMX2i5m7AOJZF2oxA13VrQAAudlEM4O1x+IPAENN3TziYHdDfUe4aHeA30G
         Lks3p/P8c5VY80B+kyKT3irBl5Df9H42YXN7xJ7UiI6SdL06YunPOBRxJTs8ZcrBfI
         6hU5aJ1esyjOyohrE2MgTPwgX8MghtCFOKTluwiU=
Message-ID: <b0ed38a5-09fe-c84a-b64a-cbb4ec7ab076@digikod.net>
Date:   Fri, 17 Mar 2023 09:38:56 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 0/1] process attribute support for Landlock
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     Shervin Oloumi <enlightened@chromium.org>,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, Adrian Reber <areber@redhat.com>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230302185257.850681-1-enlightened@chromium.org>
 <247f3194-2dd2-1414-0a4d-6e41addf5e64@digikod.net>
 <CAMb9sTir8Gde=DwZ9LnW2Hq7YmSZ13u_aX8AyR=JEQWGBhCvAQ@mail.gmail.com>
 <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230316.17835bf118d5@gnoack.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230316.17835bf118d5@gnoack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 16/03/2023 07:19, Günther Noack wrote:
> Hi!
> 
> On Wed, Mar 15, 2023 at 10:56:03AM +0100, Mickaël Salaün wrote:
>> On 08/03/2023 23:25, Shervin Oloumi wrote:
>>> Thanks all for the feedback. This is in reply to Mickaël, but should
>>> answer Günther's questions as well.
>>>
>>>> It would help to know exactly what are your needs short term, and long
>>>> term. As Günther is wondering, what about nested sandboxing?
>>>
>>> Our plan is to use the "landlocked" process attribute defined in the
>>> patch to determine the sandbox state of the system processes and send
>>> information to our metrics server regarding Landlock coverage. For
>>> example, the percentage of processes on the system that are sandboxed
>>> using Landlock.
>>>
>>> Given that we use Landlock in a very specific and controlled way, we
>>> are not concerned about the inheritance behavior and nested policies,
>>> at least for the use case of metrics. When daemons are launched in
>>> ChromiumOS, they have a pre-defined sandboxing configuration that
>>> dictates whether Landlock should be applied or not. So this attribute
>>> would help us verify that the processes running on devices in the wild
>>> indeed have the general sandboxing state that we expect and the
>>> reality matches our expectation.
>>>
>>> Long-term, it would be useful to learn more information about domains
>>> and policies through the process attribute interface, but we do not
>>> currently have a need for that, apart from maybe doing troubleshooting
>>> when defining Landlock rules for system daemons.
>>
>> OK, it makes sense.
> 
> Fair enough.  I missed the fact that this was about the OS rather than
> the browser.
> 
> Still, out of curiosity: Hypothetically, if you were to expose the
> number of stacked Landlock policies instead of the boolean in that
> place -- would there be any drawbacks to that which I'm overlooking?
> 
> It seems to me, superficially, that the implementation should be
> similarly simple, it would be useful in more cases where Landlock
> users do not have control over the full OS, and I can't currently see
> any cases where having a number instead of a boolean would complicate
> the usage from userspace?  Am I missing something?

I'd like to hear from Shervin, but here is my reasoning.

I'd like to avoid as much as possible the procfs interface (for security 
and usability reasons specific to Landlock), but to only extend it to 
the minimal requirement needed to tie a process to a Landlock domain. 
Exposing any domain information (e.g. nested domain depth) should then 
be managed by a new interface (i.e. /sys/kernel/security/landlock), and 
we should avoid duplicating this information in the procfs interface. 
Making an attr/landlock/domain file gives the information that a 
(nested) domain exists for this PID, which is anyway a required minimal 
interface.


> 
> (But in any case, the boolean is also fine I think.)
> 
> 
>>>> Here are the guiding principles I think would make sense:
>>>> 1. A sandboxed thread shall not be able to directly know if it is
>>>> sandbox nor get any specific information from it's restrictions. The
>>>> reason for this principle is to avoid applications to simply jump to
>>>> conclusions (and change behavior) if they see that they are sandboxed
>>>> with Landlock, instead of trying to access resources and falling back
>>>> accordingly. A thread should only be able to inspect its
>>>> own/children/nested domains.

For a more up-to-date idea, see 
https://lore.kernel.org/all/ee878a04-51f4-a8aa-7d4c-13e519b7409d@digikod.net/
The fdinfo trick would not be required though, I found a better design 
to tie an opened domain to its properties. Anyway, this is future work 
and would be compatible with the /proc/[pid]/attr/landlock/domain file.

> 
> (Small remark:
> 
> Doing anything differently depending on whether and how you are
> landlocked is definitely an antipattern which we should not encourage.
> But I'm not sure whether we can hide the fact very easily.
> 
> It's already possible for a thread to detect whether it is landlocked,
> by using this hack: Create a new thread and then in that thread count
> how many additional sandboxes you can stack on top.
> 
> If you have knowledge about what Landlock configuration you are
> looking for, it will be even easier to detect.
> 
> I hope noone takes the above example as inspiration.)

Indeed, there are multiple ways to detect that a thread is landlocked, 
but we should not make any effort to make it easy to check unless there 
is at least a valid use case. I'd like to only add/show new interfaces 
were/when they are needed, in this case, "a thread should only be able 
to inspect/see its nested domains". For now, the only valid usage I can 
think of to detect sandboxing is for debug and metrics, not for a 
legitimate sandboxed application. Furthermore, what I'd like to have for 
Landlock is the ability to use this "domain" file to get access to 
domain properties (e.g. handled accesses, rules), and giving the sandbox 
configuration to the sandboxed process looks like a bad idea.
