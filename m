Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF26ACDD3
	for <lists+linux-api@lfdr.de>; Mon,  6 Mar 2023 20:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCFTSY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Mar 2023 14:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCFTST (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Mar 2023 14:18:19 -0500
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE22D145
        for <linux-api@vger.kernel.org>; Mon,  6 Mar 2023 11:18:06 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PVpJB4ZXCzMql9P;
        Mon,  6 Mar 2023 20:18:02 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PVpJ934QZzMsbgd;
        Mon,  6 Mar 2023 20:18:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1678130282;
        bh=km+ZIZT9n7UyXmGudAckqTdfhH3KWWGzsiHMBFhtwIs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sZgd39Co0PYHph22i+bM6kxUNd/LqfEtNo4fW7ik0QbjQF8TcFPVqYunUiO4BoKAn
         JyOr1rOtxKK/rHBTuYWjOxndljJhDNiTDhbmWcggqVdSBKvMr+bv0Dgc4I290OIxh7
         ddId8AtfqdaAwYx3HeU8Z80JIYGZ3WD4MqiHfzPg=
Message-ID: <247f3194-2dd2-1414-0a4d-6e41addf5e64@digikod.net>
Date:   Mon, 6 Mar 2023 20:18:00 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 0/1] process attribute support for Landlock
Content-Language: en-US
To:     enlightened@chromium.org
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Adrian Reber <areber@redhat.com>, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230302185257.850681-1-enlightened@chromium.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230302185257.850681-1-enlightened@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Shervin,

Thanks for this initial patch.

On 02/03/2023 19:52, enlightened@chromium.org wrote:
> From: Shervin Oloumi <enlightened@chromium.org>
> 
> Hi Mickaël,
> 
> I'm looking into adding a simple process attribute getter to Landlock so
> we can determine the sand-boxing state of each process based on
> /proc/[PID]/attr/current. As ChromeOS is expanding Landlock support,
> this would help us paint a clear picture of Landlock coverage in the
> fleet. I prepared a patch as a starting point, and would love to get
> your feedback.

It would help to know exactly what are your needs short term, and long 
term. As Günther is wondering, what about nested sandboxing?

I'm thinking about a new /sys/kernel/security/landlock filesystem to be 
able to audit Landlock domains (i.e. sandboxes). As for your use case, 
it would be useful to be able to tie a process to a Landlock domain 
thanks to IDs.

Here are the guiding principles I think would make sense:
1. A sandboxed thread shall not be able to directly know if it is 
sandbox nor get any specific information from it's restrictions. The 
reason for this principle is to avoid applications to simply jump to 
conclusions (and change behavior) if they see that they are sandboxed 
with Landlock, instead of trying to access resources and falling back 
accordingly. A thread should only be able to inspect its 
own/children/nested domains.
2. Access to any Landlock domain information should be checked according 
to PTRACE_MODE_READ_FSCREDS, the Landlock domain hierarchy (cf. 
ptrace.c:domain_scope_le), and the first principle.
3. Any (domain) ID should be unique to the whole system (or maybe to the 
reader's PID namespace, and then in theory relative to the /proc 
content) to make it possible to compare Landlock domains (like 
/proc/[pid]/ns/* symlinks enable), and avoid trivial races.
4. These IDs should be the same during the whole lifetime of the related 
domain.
5. These IDs should not enable to infer information from other Landlock 
domains (e.g. how many are in use, current and parent domains), nor the 
kernel internals (e.g. addresses).
6. These IDs should not be sequential nor easily guessed to avoid 
anti-patterns (cf. file descriptors).
7. These IDs should be CRIU-friendly, to be able to easily restore such 
state. This doesn't help the previous principles and I don't know how/if 
CRIU supports namespace IDs though.

The /proc/[pid]/ns/* symlinks should be a good inspiration for a 
/proc/[pid]/attr/landlock/domain symlink with similar properties. Such 
file could then be used to pin or enforce the same Landlock domain on 
other threads in the future (out of scope for this patch series). Being 
able to open such "domain" file would make it possible to avoid races 
while reading the related ID and looking for the related entry in 
/sys/kernel/security/landlock/ by holding this file open.

It would be nice if the /proc/[pid]/attr/landlock directory would only 
exists if Landlock is enabled.

Similarly, /proc/[pid]/attr/landlock/domain should only exist (or be 
viewable) for a thread if [pid] is part of one of its child domain.

For now, I don't see any file in /proc/[pid]/attr/landlock/ other than 
"domain" that would make sense, but a dedicated directory is useful anyway.

I though about an entire file hierarchy to reflect a Landlock domain 
(e.g., with rule attributes), but that would make the /proc filesystem 
dynamically deep, so this should be dedicated to the 
/sys/kernel/security/landlock filesystem, but tied with /proc in some 
way, in this case with same domain IDs.


> 
> One area I am not very sure of is the case where more than one LSM is in
> use. In such cases each LSM could have its own process attribute
> getters and setters. What I learned is that when this is the case, the
> kernel only calls the hook function for the LSM that is loaded first in
> the CONFIG_LSM option. For example if landlock comes first
> (CONFIG_LSM=landlock,...), then the kernel only calls the hook function
> for Landlock, when the userspace interacts with process attribute files.
> This is not a blocker for us, as we only currently care about reading
> the Landlock related attributes, and my understanding is that this is
> working as intended, but wanted to get your input.

Using the /proc/[pid]/attr/landlock/domain path will remove this issue.

> 
> Shervin Oloumi (1):
>    lsm: adds process attribute getter for Landlock
> 
>   fs/proc/base.c         | 11 +++++++++++
>   security/landlock/fs.c | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> 
> base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
