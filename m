Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BBA12751E
	for <lists+linux-api@lfdr.de>; Fri, 20 Dec 2019 06:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLTFWC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Dec 2019 00:22:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46461 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLTFWB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Dec 2019 00:22:01 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so7065515edi.13
        for <linux-api@vger.kernel.org>; Thu, 19 Dec 2019 21:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2KTmXeXeXMiud96l6nUg2edTQgCxfxouifxscVRf0g=;
        b=WNGXalv6wGknAwomwUwaovAuPTvIQk7Xl9TqqlQvmj1rGqrkoFkmOPGli//9tqbPOv
         bC0y5Bs/3eANQWEqTALhW5Dku73NB5ieBnYuYxc1jUL3Zr8Uqy/gnWwYBGWtxLUJLsqD
         Tp7EfFzYyAQ8cd9J2+BJ9gPXs0uV9dWqQzzK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2KTmXeXeXMiud96l6nUg2edTQgCxfxouifxscVRf0g=;
        b=HuFE3j2B2hm0JE/pexkZhdMw0aBYiC6gKOuwh306VRx5+mUhkRihH49sTT34BmfO8t
         66BaAAAc7opzAiZSAHwHKraGyKX3L8oqt9mFCh3fza9asTgUJCj06g0xHPaerBg1CqLd
         mAYAcOEY68mAe+FGqrP20AoxDCJLPtBIzEMF63mb4FFNDkhYAF/NrD6dOQ3BSVn6d6E6
         lWsUx1ruEN/V9S4VKMUPE/O0Nn2RhAu92Qd/TL5ZUf+cZrvSI20Dvv6a7/FTu8SyubB/
         n8Um6GO2Kg2cBuzbIVI0/psGU7Ry+n+xSjzWu+c2JUBYMFOh4TNPLTi06SJ9T1jyOpzg
         FHfw==
X-Gm-Message-State: APjAAAU7j3pMvk9fTo7sJfQeCjssl8H15vfD4xvBImx8cEYG2WqAF4rA
        Lmc0NxNeJd9vBMKCqGj8ucES7RmGAMJp8hTVf8mzLw==
X-Google-Smtp-Source: APXvYqzEMj7wR7jQmLsuZlyg4/9OOkLUmtqWJIdzbQ1FdkEnv81xGqzaY4T0ckwcnUBu1qoHgE7EBOXhUrhFb4u6MaM=
X-Received: by 2002:a17:906:4f93:: with SMTP id o19mr13905879eju.52.1576819319133;
 Thu, 19 Dec 2019 21:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal> <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
In-Reply-To: <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 19 Dec 2019 21:21:23 -0800
Message-ID: <CAMp4zn9R3XoV=xLi9y0vn-DotUQGRFA8Cp14aYYvkVYEUuW48w@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 19, 2019 at 5:43 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>
> I don't think this is MODE_READ.  By copying an fd from the task, you
> can easily change its state.
Would PTRACE_MODE_ATTACH_REALCREDS  work? I'm curious what
kind of state change you can cause by borrowing an FD?


>
> IMO it would be really nice if pidfd could act more like a capability
> here and carry a ptrace mode, for example.  But I guess it doesn't
> right now.
>
>
> --Andy
