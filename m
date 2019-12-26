Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6612AD11
	for <lists+linux-api@lfdr.de>; Thu, 26 Dec 2019 15:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLZOeN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 26 Dec 2019 09:34:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40160 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZOeN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Dec 2019 09:34:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so12937921pgt.7
        for <linux-api@vger.kernel.org>; Thu, 26 Dec 2019 06:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=tH9yVEH69roRLXZbFqwNHzCYz2hyQgh/keaKpLa4NYw=;
        b=EYex8xcKQYZMJxeRAHoD5vIjJVke39u1qvV0/IEcFpTm+gM2jjd0iMQhJpzOajRBmD
         NTmUUlfIuydXuOVZmWsz9zS5erkmQhjcNYW6u+2WYdfhRAU2sSTDBTp+vaZ4dsPT9ddk
         JCUVwE235vZQ4o8vyW8DVrVa76EkuiYzrF0fPWEHnUt3+UbWJNfN0rtQuD712/KN0D1k
         Q1KiNtNXP4FG8P/XxlpzPCR1nTWNaphoT+KRbYdhQKIkzz6yWtGVAuP0euXK+LR8TpkS
         gDX0I/8jikFFTsoeizpYrk7rFFb81S43mQmHbICgnPyCRHTPg15Su8amf/aOv3XETmWV
         LaPA==
X-Gm-Message-State: APjAAAUt7RhcgnlCqxY2fq8fOteChoxtu4/frTlHXOJ2YuqHvNfdGUYl
        ZV9i3XO8t+ccg2AkfIhIsZ13M8BTlUFqhg==
X-Google-Smtp-Source: APXvYqy2DOFvQDYyy57f2OzZyRH9kGQ8+OGGXcXdwwdb3R8vCD6k8z3TI+QuoL3NTLvmO3iXBzrX9Q==
X-Received: by 2002:a63:e042:: with SMTP id n2mr50353885pgj.308.1577370852755;
        Thu, 26 Dec 2019 06:34:12 -0800 (PST)
Received: from [192.168.43.52] ([172.58.30.175])
        by smtp.gmail.com with ESMTPSA id b2sm11031962pjq.3.2019.12.26.06.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 06:34:11 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:34:02 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal> <20191226115245.usf7z5dkui7ndp4w@wittgenstein> <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
To:     Aleksa Sarai <cyphar@cyphar.com>
CC:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        keescook@chromium.org
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <57C06925-0CC6-4251-AD57-8FF1BC28F049@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On December 26, 2019 3:32:29 PM GMT+01:00, Aleksa Sarai <cyphar@cyphar.com> wrote:
>On 2019-12-26, Christian Brauner <christian.brauner@ubuntu.com> wrote:
>> On Wed, Dec 25, 2019 at 09:45:33PM +0000, Sargun Dhillon wrote:
>> > This patch is a small change in enforcement of the uapi for
>> > SECCOMP_IOCTL_NOTIF_RECV ioctl. Specificaly, the datastructure
>which is
>> > passed (seccomp_notif), has a flags member. Previously that could
>be
>> > set to a nonsense value, and we would ignore it. This ensures that
>> > no flags are set.
>> > 
>> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
>> > Cc: Kees Cook <keescook@chromium.org>
>> 
>> I'm fine with this since we soon want to make use of the flag
>argument
>> when we add a flag to get a pidfd from the seccomp notifier on
>receive.
>> The major users I could identify already pass in seccomp_notif with
>all
>> fields set to 0. If we really break users we can always revert; this
>> seems very unlikely to me though.
>> 
>> One more question below, otherwise:
>> 
>> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
>> 
>> > ---
>> >  kernel/seccomp.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> > 
>> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> > index 12d2227e5786..455925557490 100644
>> > --- a/kernel/seccomp.c
>> > +++ b/kernel/seccomp.c
>> > @@ -1026,6 +1026,13 @@ static long seccomp_notify_recv(struct
>seccomp_filter *filter,
>> >  	struct seccomp_notif unotif;
>> >  	ssize_t ret;
>> >  
>> > +	if (copy_from_user(&unotif, buf, sizeof(unotif)))
>> > +		return -EFAULT;
>> > +
>> > +	/* flags is reserved right now, make sure it's unset */
>> > +	if (unotif.flags)
>> > +		return -EINVAL;
>> > +
>> 
>> Might it make sense to use
>> 
>> 	err = copy_struct_from_user(&unotif, sizeof(unotif), buf,
>sizeof(unotif));
>> 	if (err)
>> 		return err;
>> 
>> This way we check that the whole struct is 0 and report an error as
>soon
>> as one of the members is non-zero. That's more drastic but it'd
>ensure
>> that other fields can be used in the future for whatever purposes.
>> It would also let us get rid of the memset() below. 
>
>Given that this isn't an extensible struct, it would be simpler to just
>do
>check_zeroed_user() -- copy_struct_from_user() is overkill. That would
>also remove the need for any copy_from_user()s and the memset can be
>dropped by just doing
>
>  struct seccomp_notif unotif = {};
>
>> >  	memset(&unotif, 0, sizeof(unotif));
>> >  
>> >  	ret = down_interruptible(&filter->notif->request);
>> > -- 
>> > 2.20.1
>> > 

It is an extensible struct. That's why we have notifier size checking built in.
