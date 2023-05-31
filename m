Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2468D718191
	for <lists+linux-api@lfdr.de>; Wed, 31 May 2023 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjEaN0L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 May 2023 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjEaN0K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 May 2023 09:26:10 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55A128
        for <linux-api@vger.kernel.org>; Wed, 31 May 2023 06:26:08 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QWVQR0rFpzMtCVh;
        Wed, 31 May 2023 15:26:07 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QWVQP5vKXzMpsR0;
        Wed, 31 May 2023 15:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685539567;
        bh=0Yoj+1GzHyjgLOGaFksBwRCey6eyoCC1JdEUHcwhlNg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JdOBdNQBa/PkcJMPOBeWLHznSQveenAenjcWmheVzP25jYh8h85rStTuT2I2F3zBo
         ffhflnkYe2IaWfy04TP8xBViOFW9Vzb1qLp3dbggrDamv6Yjo4VexDBBdzAy9Drv1L
         k1bQ/tk9EOOLM4D0k09vBOKS4n5iTmDSwIiWGzXo=
Message-ID: <e7c8a996-d98c-efac-3b12-dd6d66e421c3@digikod.net>
Date:   Wed, 31 May 2023 15:26:05 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Xu <jeffxu@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc:     Shervin Oloumi <enlightened@chromium.org>,
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <e1db62f4-32c5-d784-ba4e-5acc242bc00c@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 30/05/2023 21:19, Casey Schaufler wrote:
> On 5/30/2023 11:05 AM, Jeff Xu wrote:
>> On Thu, May 25, 2023 at 9:28 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 5/24/2023 9:02 AM, Mickaël Salaün wrote:
>>>> On 24/05/2023 17:38, Mickaël Salaün wrote:
>>>>> On 23/05/2023 23:12, Paul Moore wrote:
>>>>>> On Tue, May 23, 2023 at 2:13 AM Jeff Xu <jeffxu@chromium.org> wrote:
>>>>>>> On Mon, May 22, 2023 at 12:56 PM Paul Moore <paul@paul-moore.com>
>>>>>>> wrote:
>>>>>>>> On Thu, May 18, 2023 at 5:26 PM Casey Schaufler
>>>>>>>> <casey@schaufler-ca.com> wrote:
>>>>>>>>> On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
>>>>>>>>>> Adds a new getprocattr hook function to the Landlock LSM, which
>>>>>>>>>> tracks
>>>>>>>>>> the landlocked state of the process. This is invoked when
>>>>>>>>>> user-space
>>>>>>>>>> reads /proc/[pid]/attr/domain
>>>>>>>>> Please don't add a Landlock specific entry directly in the attr/
>>>>>>>>> directory. Add it only to attr/landlock.
>>>>>>>>>
>>>>>>>>> Also be aware that the LSM maintainer (Paul Moore) wants to move
>>>>>>>>> away from the /proc/.../attr interfaces in favor of a new system
>>>>>>>>> call,
>>>>>>>>> which is in review.
>>>>>>>> What Casey said above.
>>>>>>>>
>>>>>>>> There is still some uncertainty around timing, and if we're perfectly
>>>>>>>> honest, acceptance of the new syscalls at the Linus level, but yes, I
>>>>>>>> would very much like to see the LSM infrastructure move away from
>>>>>>>> procfs and towards a syscall API.  Part of the reasoning is that the
>>>>>>>> current procfs API is ill-suited to handle the multiple, stacked LSMs
>>>>>>>> and the other part being the complexity of procfs in a namespaced
>>>>>>>> system.  If the syscall API is ultimately rejected, we will need to
>>>>>>>> revisit the idea of a procfs API, but even then I think we'll need to
>>>>>>>> make some changes to the current approach.
>>>>>>>>
>>>>>>>> As I believe we are in the latter stages of review for the syscall
>>>>>>>> API, perhaps you could take a look and ensure that the current
>>>>>>>> proposed API works for what you are envisioning with Landlock?
>>>>> I agree, and since the LSM syscalls are almost ready that should not
>>>>> change much the timing. In fact, extending these syscalls might be
>>>>> easier than tweaking the current procfs/attr API for Landlock specific
>>>>> requirements (e.g. scoped visibility). We should ensure that these
>>>>> syscalls would be a good fit to return file descriptors, but in the
>>>>> short term we only need to know if a process is landlocked or not, so a
>>>>> raw return value (0 or -errno) will be enough.
>>>>>
>>>>> Mentioning in the LSM syscalls patch series that they may deal with (and
>>>>> return) file descriptors could help API reviewers though.
>>>> It should be kept in mind that the current LSM syscalls only deal with
>>>> the calling task, whereas the goal of this Landlock patch series is to
>>>> inspect other tasks. A new LSM syscall would need to be created to
>>>> handle pidfd e.g., named lsm_get_proc_attr() or lsm_get_pid_attr().
>>> I think it would be lsm_get_pid_attr(). Yes, it's the obvious next step.
>>>
>>>> I'm not sure if this should be a generic LSM syscall or a Landlock
>>>> syscall though. I have plan to handle processes other than the caller
>>>> (e.g. to restrict an existing process hierarchy), so thinking about a
>>>> Landlock-specific syscall could make sense.
>>>>
>>>> To summarize, creating a new LSM syscall to deal with pidfd and to get
>>>> LSM process "status/attr" looks OK. However, Landlock-specific
>>>> syscalls to deal with Landlock specificities (e.g. ruleset or domain
>>>> file descriptor) make more sense.
>>>>
>>>> Having one LSM-generic syscall to get minimal Landlock attributes
>>>> (i.e. mainly to know if a process is sandboxed), and another
>>>> Landlock-specific syscall to do more things (e.g. get the domain file
>>>> descriptor, restrict a task) seems reasonable. The second one would
>>>> overlap with the first one though. What do you think?
>>> I find it difficult to think of a file descriptor as an attribute of
>>> a process. To my (somewhat unorthodox) thinking a file descriptor is
>>> a name for an object, not an attribute of the object. You can't access
>>> an object by its attributes, but you can by its name. An attribute is
>>> a description of the object. I'm perfectly happy with lsm_get_pid_attr()
>>> returning an attribute that is a file descriptor if it describes the
>>> process in some way, but not as a substitute for opening /proc/42.

We're talking about two kind of file descriptor. First, pidfd which is a 
file descriptor referring to a task, so yes pretty similar to /proc/42 . 
Second, a Landlock domain file descriptor, referring to a Landlock 
domain which contains a set of processes, similar to cgroups.

A potential landlock_get_domain() syscall would take a pidfd as argument 
and return a Landlock domain file descriptor. I think lsm_get_pid_attr() 
would be better to always return raw data (current attribute values), 
which is simpler and make sure a syscall only return the same types. 
This would be type safe and avoid issues where file descriptors would be 
leaked of misused.


>>>
>>>
>> If I understand correctly:
>> 1> A new lsm syscall - lsm_get_pid_attr():  Landlock will return the
>> process's landlock sandbox status: true/false.
> 
> There would have to be a new LSM_ATTR_ENFORCMENT to query.
> Each LSM could then report what, if any, value it choose to.
> I can't say whether SELinux would take advantage of this.
> I don't see that Smack would report this attribute.

I think such returned status for LSM_ATTR_ENFORCMENT query would make 
sense, but the syscall could also return -EPERM and other error codes.


> 
>>
>> Is this a right fit for SELinux to also return the process's enforcing
>> mode ? such as enforcing/permissive.

Paul could answer that, but I think it would be simpler to have two 
different queries, something like LSM_ATTR_ENFORCMENT and 
LSM_ATTR_PERMISSIVE queries.


>>
>> 2> Landlock will have its own specific syscall to deal with Landlock
>> specificities (e.g. ruleset or domain file descriptor).
> 
> I don't see how a syscall to load arbitrary LSM policy (e.g. landlock ruleset,
> Smack rules) would behave, so each LSM is on it's own regarding that.

I agree, Landlock-specific file descriptors should managed by 
Landlock-specific syscalls.

> I doubt
> that the VFS crowd would be especially keen on an LSM creating file descriptors,
> but stranger things have happened.

This is already the case with Landlock rulesets, so no issue with that. 
File descriptors are more and more used nowadays and it's a good thing.
