Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510470FB95
	for <lists+linux-api@lfdr.de>; Wed, 24 May 2023 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjEXQWH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 May 2023 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjEXQWG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 May 2023 12:22:06 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE9710B
        for <linux-api@vger.kernel.org>; Wed, 24 May 2023 09:22:02 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QRGfc4HRVzMqRfs;
        Wed, 24 May 2023 18:22:00 +0200 (CEST)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QRGfb3G7mzMqGJ8;
        Wed, 24 May 2023 18:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1684945320;
        bh=0todAZoASqvLTG1Z3RQHUEUSsoR0QV884jEWljXepEw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZH/1HSwGhIzV5jem7RtDssVU7/cgMy+r1qffFyMRVqtX4WYTAFgjRf+WJKHJUYl9r
         PDQuU9kDIxjFFgYokV8PiBNBaEnirvCdKHk1M01wYV11cjiZwXVwtQ0bCTFqgVarmz
         7cZEoqy/JhEuAKdux0x9MDZwdRW7EL5qpG6RFH6Y=
Message-ID: <bceca6ba-dafd-8d27-8e80-936c66e57b1a@digikod.net>
Date:   Wed, 24 May 2023 18:21:58 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 0/1] process attribute support for Landlock
Content-Language: en-US
To:     Shervin Oloumi <enlightened@chromium.org>
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Adrian Reber <areber@redhat.com>, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230302185257.850681-1-enlightened@chromium.org>
 <247f3194-2dd2-1414-0a4d-6e41addf5e64@digikod.net>
 <CAMb9sTir8Gde=DwZ9LnW2Hq7YmSZ13u_aX8AyR=JEQWGBhCvAQ@mail.gmail.com>
 <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <CAMb9sThs2QXid0LZ3gwtfJoJUM3mpK0=nobOGpicde7jnuAJ5Q@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAMb9sThs2QXid0LZ3gwtfJoJUM3mpK0=nobOGpicde7jnuAJ5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 18/05/2023 22:44, Shervin Oloumi wrote:

[...]

> 
> As for the patch, I will just provide what I have so far, which I
> think is more in line with the approach you suggested, so that it can
> perhaps at some point be useful, once the above limitation is
> resolved.
> 
>> Yes, the approach I suggested, check the /proc/.../attr/landlock/domain
>> presence would enable you to check the landlocked state of a process. It
>> should not change much from your initial patch. In fact it will be
>> quicker to check because there is no need for the open/read/close
>> syscalls, but only faccessat2.
> 
> I played around with this idea but ran into a problem; I'm not sure if
> it is possible to implement a behavior where the existence/viewability
> of the `/proc/.../attr/landlock/domain` is conditional. The `domain`
> file is predefined with set permissions in `fs/proc/base.c` (as done
> in the patch) and it is always present if landlock is enabled.
> Additionally, the `landlock_getprocattr` hook function only gets
> called when the file `/proc/.../attr/landlock/domain` is opened and
> read, so I'm not sure how the file visibility can be manipulated.

It would work the same as proc/self/fd, but may require some API changes 
to be in line with the LSM API. Relying on the LSM syscalls would not 
require to change this API.


> 
> The closest way I can think of to imitate the suggested behavior is to
> return `EACCES` in the hook function if the checking process domain is
> not related to the target process domain and return "none" (indicating
> there is no Lanldock domain associated with this process) if the
> domain check passes and the target process is not landlocked. In cases
> where the access check passes (or when the checking process is not
> landlocked) and the target process is landlocked reading the file
> could just return nothing (maybe in the future this will return the
> domain ID...TBD).

I really want the concept I proposed to be used: a sandbox process 
should not be able to get any data from processes in the same sandbox 
(except through side effects such as nesting limit) nor for processes 
not in a nested sandbox. In fact, this should just use 
ptrace_may_access() (as already done for sensitive procfs files), and 
checking the current domain as you did.
