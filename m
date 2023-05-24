Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A892170FAB3
	for <lists+linux-api@lfdr.de>; Wed, 24 May 2023 17:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjEXPrW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 May 2023 11:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjEXPrV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 May 2023 11:47:21 -0400
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 08:46:53 PDT
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F658E5A
        for <linux-api@vger.kernel.org>; Wed, 24 May 2023 08:46:53 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QRFhY4n1BzMsC2r;
        Wed, 24 May 2023 17:38:37 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QRFhX1FqvzMq3kf;
        Wed, 24 May 2023 17:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1684942717;
        bh=VYmLTVCgSyQz1NM3vCHIOgTdrgkuGs7TqgxzYcQ9yjQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1Lg2CbFIjwpKdZ1UKDgZpes0Y0RI+CogJ+Q3sYI5TKNJZrqfvf23HqPZn4v++KmHl
         7XMFNJ0/vQhbxnx2yulPuANep+XsR4KfWy12Fw8Lu2Z3X2t8cTnvgNMmIKzhrF9ipK
         LjX/12R3yhLGrHgYSjVWsrXCMnGVgWDwL44r2VwM=
Message-ID: <1225a567-4ff5-462e-0db6-1a88a748d787@digikod.net>
Date:   Wed, 24 May 2023 17:38:35 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Jeff Xu <jeffxu@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 23/05/2023 23:12, Paul Moore wrote:
> On Tue, May 23, 2023 at 2:13 AM Jeff Xu <jeffxu@chromium.org> wrote:
>> On Mon, May 22, 2023 at 12:56 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Thu, May 18, 2023 at 5:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
>>>>> Adds a new getprocattr hook function to the Landlock LSM, which tracks
>>>>> the landlocked state of the process. This is invoked when user-space
>>>>> reads /proc/[pid]/attr/domain
>>>>
>>>> Please don't add a Landlock specific entry directly in the attr/
>>>> directory. Add it only to attr/landlock.
>>>>
>>>> Also be aware that the LSM maintainer (Paul Moore) wants to move
>>>> away from the /proc/.../attr interfaces in favor of a new system call,
>>>> which is in review.
>>>
>>> What Casey said above.
>>>
>>> There is still some uncertainty around timing, and if we're perfectly
>>> honest, acceptance of the new syscalls at the Linus level, but yes, I
>>> would very much like to see the LSM infrastructure move away from
>>> procfs and towards a syscall API.  Part of the reasoning is that the
>>> current procfs API is ill-suited to handle the multiple, stacked LSMs
>>> and the other part being the complexity of procfs in a namespaced
>>> system.  If the syscall API is ultimately rejected, we will need to
>>> revisit the idea of a procfs API, but even then I think we'll need to
>>> make some changes to the current approach.
>>>
>>> As I believe we are in the latter stages of review for the syscall
>>> API, perhaps you could take a look and ensure that the current
>>> proposed API works for what you are envisioning with Landlock?

I agree, and since the LSM syscalls are almost ready that should not 
change much the timing. In fact, extending these syscalls might be 
easier than tweaking the current procfs/attr API for Landlock specific 
requirements (e.g. scoped visibility). We should ensure that these 
syscalls would be a good fit to return file descriptors, but in the 
short term we only need to know if a process is landlocked or not, so a 
raw return value (0 or -errno) will be enough.

Mentioning in the LSM syscalls patch series that they may deal with (and 
return) file descriptors could help API reviewers though.


>>>
>> Which review/patch to look for the proposed API ?
> 
> See Casey's reply if you haven't already.  You can also find the LSM
> list archived on lore.kernel.org; that is probably the best way to
> track LSM development if you don't want to subscribe to the list.
> 
> * https://lore.kernel.org/linux-security-module
> 
>> I guess ChromeOS will need to backport to 5.10 when the proposal is accepted.
> 
> Maybe?  Distro specific backports aren't generally on-topic for the
> upstream Linux mailing lists, especially large commercial distros with
> plenty of developers to take care of things like that.
> 

Backporting the LSM syscall patch series will create conflicts but they 
should be manageable and the series should be quite standalone. You'll 
need to understand the changes to get a clean backport, so reviewing the 
current proposal is a good opportunity to be ready and to catch 
potential future issues.
