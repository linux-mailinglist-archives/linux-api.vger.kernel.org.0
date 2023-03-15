Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9954D6BACCC
	for <lists+linux-api@lfdr.de>; Wed, 15 Mar 2023 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjCOJ6G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Mar 2023 05:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjCOJ5p (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Mar 2023 05:57:45 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ADB83896
        for <linux-api@vger.kernel.org>; Wed, 15 Mar 2023 02:56:09 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Pc5Pd5bLRzMqPGT;
        Wed, 15 Mar 2023 10:56:05 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Pc5Pc4QWtzMshZV;
        Wed, 15 Mar 2023 10:56:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1678874165;
        bh=E3Wrf/GKUfCx4B2zr2Kvo7G+ww/TUs8cNCp78tKxA8M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VkhTRqbK4CytL0zHrVD2wl5qOULfB24AGFgjzXoV3dWM+RRv5Uj8lZmnLDzG0JjuW
         RYpGYjBqgF8QfTGqTg8bn5InH3mJsMxVlwMfIzTN9m+IDavqdPvwn8WSOi6Ft/ANFD
         V9dYjeIePsdIby+owk5XCLvR6eNX9+AendAvFdv0=
Message-ID: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
Date:   Wed, 15 Mar 2023 10:56:03 +0100
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAMb9sTir8Gde=DwZ9LnW2Hq7YmSZ13u_aX8AyR=JEQWGBhCvAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 08/03/2023 23:25, Shervin Oloumi wrote:
> Thanks all for the feedback. This is in reply to Mickaël, but should
> answer Günther's questions as well.
> 
>> It would help to know exactly what are your needs short term, and long
>> term. As Günther is wondering, what about nested sandboxing?
> 
> Our plan is to use the "landlocked" process attribute defined in the
> patch to determine the sandbox state of the system processes and send
> information to our metrics server regarding Landlock coverage. For
> example, the percentage of processes on the system that are sandboxed
> using Landlock.
> 
> Given that we use Landlock in a very specific and controlled way, we
> are not concerned about the inheritance behavior and nested policies,
> at least for the use case of metrics. When daemons are launched in
> ChromiumOS, they have a pre-defined sandboxing configuration that
> dictates whether Landlock should be applied or not. So this attribute
> would help us verify that the processes running on devices in the wild
> indeed have the general sandboxing state that we expect and the
> reality matches our expectation.
> 
> Long-term, it would be useful to learn more information about domains
> and policies through the process attribute interface, but we do not
> currently have a need for that, apart from maybe doing troubleshooting
> when defining Landlock rules for system daemons.

OK, it makes sense.


> 
>> I'm thinking about a new /sys/kernel/security/landlock filesystem to be
>> able to audit Landlock domains (i.e. sandboxes). As for your use case,
>> it would be useful to be able to tie a process to a Landlock domain
>> thanks to IDs.
> 
> I think this goes beyond the scope for our current needs, but
> certainly a nice feature that we could potentially use in the future.
> So given this, I was wondering what would be the minimum changes we
> can make now (if any) that would serve our purpose AND would be
> compatible with your long-term vision, without getting too deep into
> the implementation of broader concepts. We are flexible on the
> approach for querying the landlocked property (for example whether it
> is based on the presence of a /proc/.../attr/domain or actually
> reading an attribute).

Yes, the approach I suggested, check the /proc/.../attr/landlock/domain 
presence would enable you to check the landlocked state of a process. It 
should not change much from your initial patch. In fact it will be 
quicker to check because there is no need for the open/read/close 
syscalls, but only faccessat2.


>> Here are the guiding principles I think would make sense:
>> 1. A sandboxed thread shall not be able to directly know if it is
>> sandbox nor get any specific information from it's restrictions. The
>> reason for this principle is to avoid applications to simply jump to
>> conclusions (and change behavior) if they see that they are sandboxed
>> with Landlock, instead of trying to access resources and falling back
>> accordingly. A thread should only be able to inspect its
>> own/children/nested domains.
>> 2. Access to any Landlock domain information should be checked according
>> to PTRACE_MODE_READ_FSCREDS, the Landlock domain hierarchy (cf.
>> ptrace.c:domain_scope_le), and the first principle.
> 
> One thing worth noting is that we use a system daemon to read process
> attributes. We have the ptrace_scope set to 1 and the daemon reading
> the attributes does have cap_sys_ptrace, however it is not related to
> the other processes on the system. Do you see this as a problem given
> principle#1?

That should work fine because your deamon is more privileged than the 
checked processes.


>> 3. Any (domain) ID should be unique to the whole system (or maybe to the
>> reader's PID namespace, and then in theory relative to the /proc
>> content) to make it possible to compare Landlock domains (like
>> /proc/[pid]/ns/* symlinks enable), and avoid trivial races.
>> 4. These IDs should be the same during the whole lifetime of the related
>> domain.
>> 5. These IDs should not enable to infer information from other Landlock
>> domains (e.g. how many are in use, current and parent domains), nor the
>> kernel internals (e.g. addresses).
>> 6. These IDs should not be sequential nor easily guessed to avoid
>> anti-patterns (cf. file descriptors).
>> 7. These IDs should be CRIU-friendly, to be able to easily restore such
>> state. This doesn't help the previous principles and I don't know how/if
>> CRIU supports namespace IDs though.
> 
> Since these points are regarding the properties of the domain IDs,
> they should not interfere with anything we would implement for
> determining the process sandbox status in any initial patch, but are
> good to know.
> 
>> It would be nice if the /proc/[pid]/attr/landlock directory would only
>> exists if Landlock is enabled.
> 
> This is the current default behavior I believe.
> 
>> Similarly, /proc/[pid]/attr/landlock/domain should only exist (or be
>> viewable) for a thread if [pid] is part of one of its child domain.
> 
> I am not sure if this is a blocker for our model of a single daemon
> querying the attribute for all processes. Are you suggesting that the
> file would not exist from the view of the other processes if they are
> not the parent process?

Not the parent process, but a parent domain, *or in no domain at all*, 
which is your case.

> 
>> For now, I don't see any file in /proc/[pid]/attr/landlock/ other than
>> "domain" that would make sense, but a dedicated directory is useful anyway.
> 
> Determining the sandbox status of processes based on the existence of
> /proc/[pid]/landlock/domain would serve our simple use case, pending
> the open questions/potential blockers above and a clarification on
> minimum requirements for an initial version.

It should be fine for all these use cases, and only requires a small set 
of changes for now.
