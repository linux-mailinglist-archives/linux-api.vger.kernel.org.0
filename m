Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40851FA81A
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 07:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgFPFMW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 01:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgFPFMW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 01:12:22 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2045C03E96A
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 22:12:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i25so209635iog.0
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 22:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sF7E9M9M9C8VAOujo4g/NOIFcAYsVHIwoR+spYFBtyE=;
        b=r60eMOPa5JB9902ysCKrNI7ac62L21elL4+EL4uCwjaD4sNq4K2Uj4sAazXNameAaj
         ID7NonJoToO0gD7lKV7rnDuXQWpgG/ojoNJ25M22j+5SoDKF8nW37UZmqNjzebQuuSI9
         a4q1wXzmYQi111XLXBOiZFN9WW7Q13nyp6jzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sF7E9M9M9C8VAOujo4g/NOIFcAYsVHIwoR+spYFBtyE=;
        b=GirLoOc8RMAlASoPV6shLa7ElnoYN/JNk58ULYdYDxc+qwciKHwALmm1Un5lqZ7bEA
         RCkTISUswmzKZC3tjYulsIbefv0oy54xpZUY4QHb3aDGCrV6V3Kpa+dDXeoUkU7Cyg/K
         DSuOhb4wpHtmuho59DmQ7UzIuwqsZHE1jVzENd491/kTdhFMNthu/sCdWTNn7XiV6hu8
         gW7JkfrgSbTLJW3t5r9WtjzQvpudjvJvD12dYIC44rXg6CTmr0lQaaB4I95mYhrm/Med
         /2w1QjBJ9vmBs6RezpJdDGf4VFLBsGgOl5YxvlX2r+HNltB+M8L7tXpRhaFW8i1MYnvc
         1PuA==
X-Gm-Message-State: AOAM530IqygSpIcJbxmb57LgF9bwjDg0WVE6N9fHavgsndOMOK+Z2bte
        RLVohFTQsYUDaKUVSI9ctbfX7w==
X-Google-Smtp-Source: ABdhPJyVhQLX2fk4FkYMix9csXU1HQWEE674dB4w2Xqfii5o7Hwo1KMua7Zm/FBZcNGEURfmX7PTdg==
X-Received: by 2002:a6b:5c01:: with SMTP id z1mr915362ioh.177.1592284340936;
        Mon, 15 Jun 2020 22:12:20 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id l26sm9347068ild.59.2020.06.15.22.12.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 22:12:20 -0700 (PDT)
Date:   Tue, 16 Jun 2020 05:12:19 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] seccomp: Add extensibility mechanism to read
 notifications
Message-ID: <20200616051218.GA16032@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200613072609.5919-1-sargun@sargun.me>
 <CAG48ez2ZyYkHhbuwLYehR5fx2_d9yoVg4tBmyqvVqpy-oZ-0cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2ZyYkHhbuwLYehR5fx2_d9yoVg4tBmyqvVqpy-oZ-0cA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 15, 2020 at 11:36:22AM +0200, Jann Horn wrote:
> On Sat, Jun 13, 2020 at 9:26 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > This introduces an extensibility mechanism to receive seccomp
> > notifications. It uses read(2), as opposed to using an ioctl. The listener
> > must be first configured to write the notification via the
> > SECCOMP_IOCTL_NOTIF_CONFIG ioctl with the fields that the user is
> > interested in.
> >
> > This is different than the old SECCOMP_IOCTL_NOTIF_RECV method as it allows
> > for more flexibility. It allows the user to opt into certain fields, and
> > not others. This is nice for users who want to opt into some fields like
> > thread group leader. In the future, this mechanism can be used to expose
> > file descriptors to users,
> 
> Please don't touch the caller's file descriptor table from read/write
> handlers, only from ioctl handlers. A process should always be able to
> read from files supplied by an untrusted user without having to worry
> about new entries mysteriously popping up in its fd table.
> 
Acknowledged.

Is something like:
ioctl(listener, SECCOMP_GET_MEMORY, notification_id);

reasonable in your opinion?

> > such as a representation of the process's
> > memory. It also has good forwards and backwards compatibility guarantees.
> > Users with programs compiled against newer headers will work fine on older
> > kernels as long as they don't opt into any sizes, or optional fields that
> > are only available on newer kernels.
> >
> > The ioctl method relies on an extensible struct[1]. This extensible struct
> > is slightly misleading[2] as the ioctl number changes when we extend it.
> > This breaks backwards compatibility with older kernels even if we're not
> > asking for any fields that we do not need. In order to deal with this, the
> > ioctl number would need to be dynamic, or the user would need to pass the
> > size they're expecting, and we would need to implemented "extended syscall"
> > semantics in ioctl. This potentially causes issue to future work of
> > kernel-assisted copying for ioctl user buffers.
> 
> I don't see the issue. Can't you replace "switch (cmd)" with "switch
> (cmd & ~IOCSIZE_MASK)" and then check the size separately?
It depends:
1. If we rely purely on definitions in ioctl.h, and the user they've pulled
   in a newer header file, on an older kernel, it will fail. This is because
   the size is bigger, and we don't actually know if they're interested in
   those new values
2. We can define new seccomp IOCTL versions, and expose these to the user.
   This has some niceness to it, in that there's a simple backwards compatibiity
   story. This is a little unorthodox though.
3. We do something like embed the version / size that someone is interested
   in in the struct, and the ioctl reads it in order to determine which version
   of the fields to populate. This is effectively what the read approach does
   with more steps.

There's no reason we can't do #3. Just a complexity tradeoff.
