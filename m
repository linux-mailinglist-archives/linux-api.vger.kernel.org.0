Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC012B5A3
	for <lists+linux-api@lfdr.de>; Fri, 27 Dec 2019 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfL0Pcx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Fri, 27 Dec 2019 10:32:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39636 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0Pcw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Dec 2019 10:32:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so8485336wmj.4
        for <linux-api@vger.kernel.org>; Fri, 27 Dec 2019 07:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=R0BntrF2rVDTNMrbJtPfDSQnwueZm5LWHMc62sB8sLg=;
        b=bYLfACrIWhhvnNf2GwFwzXohvmnv1GqzHM6I6av4waYkym7zU7QVfxT6YFonRFP664
         Yo886vXRzxpHWYNDet22zcUE/tzKLjAV4Ep+K7pAH3wBl1Aw2dLvXonOSfuM2XKoaBMq
         Zl1ExANDrD3WrpCw96nCUst6blgyqHuYi+yiQzFVYoQWdoEyDntWF61BXjJk2VVwepnC
         iIeplZg/Ce4mHvE1jR1LHdrW9rAuCUulGZcG0t3dErgqfhb6bin9fhHmTVQ8i+Xagyvm
         LlPuU3B1ZQtyk6Zp9o2DFkBU1b0qvUfCQUv2Gyewf/NXH38q3U7ROKeHCX97YYKXjVrW
         jcMg==
X-Gm-Message-State: APjAAAXiE/YAbGK3Mp+mAoSJfZl8C32m0OegL54TdzeZ8GIHNkZONRzc
        yUZo2utImOyGlT3cX7u09BWxMw==
X-Google-Smtp-Source: APXvYqyEFdZLIODyisLhnnf1QEZpRY5N7PqJYnzvr7x+AUm9SfDpYU9xcZj6k6fQoc0Ij6FwAU7d7w==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr19833961wmi.146.1577460769823;
        Fri, 27 Dec 2019 07:32:49 -0800 (PST)
Received: from [192.168.178.28] (p5B2A6DAC.dip0.t-ipconnect.de. [91.42.109.172])
        by smtp.gmail.com with ESMTPSA id m21sm11336551wmi.27.2019.12.27.07.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 07:32:49 -0800 (PST)
Date:   Fri, 27 Dec 2019 16:32:46 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191227151501.osy2m6o6p6odzk74@yavin.dot.cyphar.com>
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal> <20191226115245.usf7z5dkui7ndp4w@wittgenstein> <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com> <57C06925-0CC6-4251-AD57-8FF1BC28F049@ubuntu.com> <20191227022446.37e64ag4uaqms2w4@yavin.dot.cyphar.com> <20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com> <20191227114725.xsacnaoaaxdv6yg3@wittgenstein> <CAMp4zn8iMsRvDoDtrotfnEm2_UUULH9VRiR6q9u8CS4qham2Eg@mail.gmail.com> <20191227151501.osy2m6o6p6odzk74@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
To:     Aleksa Sarai <cyphar@cyphar.com>, Sargun Dhillon <sargun@sargun.me>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <321F2BE8-6F16-4804-9F20-B03E5800B940@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On December 27, 2019 4:15:01 PM GMT+01:00, Aleksa Sarai <cyphar@cyphar.com> wrote:
>On 2019-12-27, Sargun Dhillon <sargun@sargun.me> wrote:
>> On Fri, Dec 27, 2019 at 6:47 AM Christian Brauner
>> <christian.brauner@ubuntu.com> wrote:
>> >
>> > On Fri, Dec 27, 2019 at 01:31:31PM +1100, Aleksa Sarai wrote:
>> > > On 2019-12-27, Aleksa Sarai <cyphar@cyphar.com> wrote:
>> > >
>> > > Scratch that -- as Tycho just mentioned, there is un-named
>padding in
>> > > the struct so check_zeroed_user() is the wrong thing to do. But
>this
>> >
>> > Hm, I don't think so.
>> > I understood Tycho's point as _if_ there ever is padding then this
>would
>> > not be zeroed.
>> > Right now, there is no padding since the struct is correctly
>padded:
>> >
>> > struct seccomp_data {
>> >         int nr;
>> >         __u32 arch;
>> >         __u64 instruction_pointer;
>> >         __u64 args[6];
>> > };
>> >
>> > struct seccomp_notif {
>> >         __u64 id;
>> >         __u32 pid;
>> >         __u32 flags;
>> >         struct seccomp_data data;
>> > };
>> >
>> > which would be - using pahole:
>> >
>> > struct seccomp_data {
>> >         int                        nr;                   /*     0  
>  4 */
>> >         __u32                      arch;                 /*     4  
>  4 */
>> >         __u64                      instruction_pointer;  /*     8  
>  8 */
>> >         __u64                      args[6];              /*    16  
> 48 */
>> >
>> >         /* size: 64, cachelines: 1, members: 4 */
>> > };
>> > struct seccomp_notif {
>> >         __u64                      id;                   /*     0  
>  8 */
>> >         __u32                      pid;                  /*     8  
>  4 */
>> >         __u32                      flags;                /*    12  
>  4 */
>> >         struct seccomp_data data;                        /*    16  
> 64 */
>> >
>> >         /* size: 80, cachelines: 2, members: 4 */
>> >         /* last cacheline: 16 bytes */
>> > };
>> >
>> > The only worry would be a 2byte int type but there's no
>architecture
>> > we support which does this right now afaict.
>> >
>> > > also will make extensions harder to deal with because
>(presumably) they
>> > > will also have un-named padding, making copy_struct_from_user()
>the
>> >
>> > This all will be a non-issue if we just use __u64 for extensions.
>> >
>> > My point about using copy_struct_from_user() was that we should
>verify
>> > that _all_ fields are uninitialized and not just the flags argument
>> > since we might introduce a flags argument that requires another
>already
>> > existing member in seccomp_notif to be set to a value. We should do
>this
>> > change now so we don't have to risk breaking someone in the future.
>> >
>> > I'm trying to get at least Mozilla/Firefox off of their crazy
>> > SECCOMP_RET_TRAP way of implementing their broker onto the user
>notifier
>> > and they will likely need some extensions. That includes the pidfd
>stuff
>> > for seccomp that Sargun will likely be doing and the new
>pidfd_getfd()
>> > syscall. So it's not unlikely that we might need other already
>existing
>> > fields in that struct to be set to some value.
>> >
>> > I don't particulary care how we do it:
>> > - We can do a simple copy_from_user() and check each field
>individually.
>> 
>> Just doing a simple copy_from_user, and for now, calling memchr_inv
>> on the whole thing. We can drop the memset, and just leave a note to
>> indicate that if unpadded fields are introduced in the future, this
>structure
>> must be manually zeroed out. Although, this might be laying a trap
>for
>> ourselves.
>> 
>> This leaves us in a good position for introducing a flag field in the
>future.
>> All we have to do is change the memchr_inv from checking on an
>> entire struct basis to checking on a per-field basis.
>
>There is no need to do memchr_inv() on copy_from_user() to check for
>zero-ness. That's the entire point of check_zeroed_user() -- to not
>need
>to do it that way.

Right, we added that too a while ago.
Let's use it.

Christian
