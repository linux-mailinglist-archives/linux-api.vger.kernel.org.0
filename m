Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A82071F59C
	for <lists+linux-api@lfdr.de>; Fri,  2 Jun 2023 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjFAWI4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Jun 2023 18:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFAWIz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Jun 2023 18:08:55 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9820D18D
        for <linux-api@vger.kernel.org>; Thu,  1 Jun 2023 15:08:53 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QXKz76KqCzMqC7D;
        Fri,  2 Jun 2023 00:08:51 +0200 (CEST)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QXKz65NTgzMpq1n;
        Fri,  2 Jun 2023 00:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685657331;
        bh=ip+z0ApypRtrufoBxPHRhT4Ix3lgSbydIARO/cQ6Nhs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zWHTDTn1/CV1D+VFPr9nO4rHQ17xrzpm8nwwnxM67EsRm/4gQJfS/TlL4zx/4tSni
         BJtbKK93ifIm0TKmdqBdwKkJfCNaDpsLtiFWWIm6kCabF/HXo5y0F15SsbYnpf2WGk
         t1uULghNuRC4JAZ1gz1GWKXkqxqrMt9LhRMJ+36A=
Message-ID: <5b1b102b-3413-3669-5f3f-3a6987033a2d@digikod.net>
Date:   Fri, 2 Jun 2023 00:08:50 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Xu <jeffxu@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org>
 <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
 <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
 <1225a567-4ff5-462e-0db6-1a88a748d787@digikod.net>
 <b4825033-471c-ba32-530f-b0235356d55b@digikod.net>
 <aa2e3c9c-eac4-237d-02d0-4574f602563d@schaufler-ca.com>
 <CABi2SkWxZwLDfo=LjLA+cXGvpNfv26ZmD5dDm+AjgD5XgNfTmw@mail.gmail.com>
 <e1db62f4-32c5-d784-ba4e-5acc242bc00c@schaufler-ca.com>
 <e7c8a996-d98c-efac-3b12-dd6d66e421c3@digikod.net>
 <CABi2SkUFe7zOFi3Vr-A6bTGytOdeZkvsPfxxLq9+b0vHfa-bkA@mail.gmail.com>
 <e83ef047-42f3-260d-1ac1-07c576cce9f8@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <e83ef047-42f3-260d-1ac1-07c576cce9f8@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 01/06/2023 23:34, Casey Schaufler wrote:
> On 6/1/2023 1:48 PM, Jeff Xu wrote:
>> Hi Paul,
>>
>> On Wed, May 31, 2023 at 6:26 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>>>>
>>>>> If I understand correctly:
>>>>> 1> A new lsm syscall - lsm_get_pid_attr():  Landlock will return the
>>>>> process's landlock sandbox status: true/false.
>>>> There would have to be a new LSM_ATTR_ENFORCMENT to query.

I guess there is a misunderstanding. What is the link between global 
system enforcement and the status of a sandboxed/restricted/enforced(?) 
process?

The attribute would then be something like LSM_ATTR_RESTRICTED to get a 
process restriction status, which might be the same for all processes 
with system-wide policies (e.g., SELinux) but not for Landlock.


>>>> Each LSM could then report what, if any, value it choose to.
>>>> I can't say whether SELinux would take advantage of this.
>>>> I don't see that Smack would report this attribute.
>>> I think such returned status for LSM_ATTR_ENFORCMENT query would make
>>> sense, but the syscall could also return -EPERM and other error codes.
>>>
>>>
>>>>> Is this a right fit for SELinux to also return the process's enforcing
>>>>> mode ? such as enforcing/permissive.
>>> Paul could answer that, but I think it would be simpler to have two
>>> different queries, something like LSM_ATTR_ENFORCMENT and
>>> LSM_ATTR_PERMISSIVE queries.
>>>
>> Hi Paul, what do you think ? Could SELinux have something like this.
> 
> Not Paul, but answering anyway - No, those are system wide attributes, not
> process (task) attributes. You want some other syscall, say lsm_get_system_attr()
> for those.

