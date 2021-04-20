Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E48364F60
	for <lists+linux-api@lfdr.de>; Tue, 20 Apr 2021 02:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhDTASG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Apr 2021 20:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhDTASE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Apr 2021 20:18:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED248C06174A
        for <linux-api@vger.kernel.org>; Mon, 19 Apr 2021 17:17:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g1-20020a17090adac1b0290150d07f9402so800136pjx.5
        for <linux-api@vger.kernel.org>; Mon, 19 Apr 2021 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w6W75hNlc1Enid3wBzZyoco/VBX0+jV5NyNBjHz84lo=;
        b=DydYa+3WvntODuL5uMNocBfIJLH6b3z1x6G+86by46uTDqddGSJnmZ9LjF6dhTL7Ci
         joNddvBFMX7haywbf0tUXWAKr78vAoaO6FkDVWyr424fC3JqtRdvnB6umsX7uK2QULPz
         ZeKk949oCH3wzaUTD9ogsMnaMHwD64H0hgEzxcIpLKRe5vi9G/1LoSWuR5sPOiVcvG4d
         ueF9DeViqNpaDeWsPVGgfN8s1rlhJwD1FJXVZ6omYAJtzpwykahBJdLKp1yVSYtGnSLX
         0C4qxEYj+RJQHfwHNGsH59inI7r2ilZ2jvXM2lSVimVXtahXYwBwMZjYReLrlgIsezrw
         h/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w6W75hNlc1Enid3wBzZyoco/VBX0+jV5NyNBjHz84lo=;
        b=M4IQJ+VZ2iCcobueunTLfRujC1iVsmlc5PKtu/8SOLX9vFIGDvC8lo+FKFAjas4FJ+
         dXgsn9pJmQ2M0d8odbAKyXBGVBBspEVWGDixD4pqdnAu3plm1Vva7NxNj7NvQuskktmO
         zPFRx4cqimlxjogK88QLLt5CzNw+DazVicLg6WFm3SAZGZIgSesHbPUGrzmnwc3H7hEv
         p57zsRLd0PTuRrmeAhx2CqSxjbdlHKuhlL3nbjMUQ/z6LntNr7fT8VxitdZ4/yxq0wAr
         8c8EeQRPFHSaL8e77FDyoRtOgwilRctlfDvEq4Uld9EERh/jlozFmDveVaNgs0jEg/5J
         G19A==
X-Gm-Message-State: AOAM530LG1Inb3V91eBQIbSFVbwTtStvo65fYpuqgNsx+aaLAuj1O4Lx
        4EJ7u2umfh4FQEkCGDw14iNw0g==
X-Google-Smtp-Source: ABdhPJxjU9gZuja4G1yBIYY5Dn47rBI8C/fqYeR/wGkDbDp3AXI2x+uyTpEXyHQp39/QnZGEpJZTaw==
X-Received: by 2002:a17:90a:7897:: with SMTP id x23mr1811334pjk.133.1618877853303;
        Mon, 19 Apr 2021 17:17:33 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3810:ca7:eb2a:d336])
        by smtp.gmail.com with ESMTPSA id n23sm14143418pgl.49.2021.04.19.17.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:17:32 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:17:21 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] pidfd_create(): remove static qualifier and declare
 pidfd_create() in linux/pid.h
Message-ID: <YH4dkfk7MVJZVxlt@google.com>
References: <cover.1618527437.git.repnop@google.com>
 <14a09477f0b2d62a424b44e0a1f12f32ae3409bb.1618527437.git.repnop@google.com>
 <20210419125033.udjmsq3npmss26pv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419125033.udjmsq3npmss26pv@wittgenstein>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 19, 2021 at 02:50:33PM +0200, Christian Brauner wrote:
> On Fri, Apr 16, 2021 at 09:22:09AM +1000, Matthew Bobrowski wrote:
> > With the idea to have fanotify(7) return pidfds within a `struct
> > fanotify_event_metadata`, pidfd_create()'s scope is to increased so
> > that it can be called from other subsystems within the Linux
> > kernel. The current `static` qualifier from its definition is to be
> > removed and a new function declaration for pidfd_create() is to be
> > added to the linux/pid.h header file.
> > 
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > ---
> >  include/linux/pid.h | 1 +
> >  kernel/pid.c        | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > index fa10acb8d6a4..af308e15f174 100644
> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -78,6 +78,7 @@ struct file;
> >  
> >  extern struct pid *pidfd_pid(const struct file *file);
> >  struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
> > +int pidfd_create(struct pid *pid, unsigned int flags);
> >  
> >  static inline struct pid *get_pid(struct pid *pid)
> >  {
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index ebdf9c60cd0b..91c4b6891c15 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -553,7 +553,7 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> >   * Return: On success, a cloexec pidfd is returned.
> >   *         On error, a negative errno number will be returned.
> >   */
> > -static int pidfd_create(struct pid *pid, unsigned int flags)
> 
> > +int pidfd_create(struct pid *pid, unsigned int flags)
> 
> Can you please add a comment to the kernel doc mentioning that this
> helper is _not_ intended to be exported to modules? I don't want drivers
> to get the idea that it's ok to start returning pidfds from everywhere
> just yet.

Sure, this makes sense to me. 
 
> And I think we should add sm like
> 
> 	if (flags & ~(O_NONBLOCK | O_CLOEXEC | O_RDWR))
> 		return -EINVAL;
> 
> in pidfd_open() so future callers don't accidently create pidfds with
> random flags we don't support.

In the context of exporting pidfd_create() to the rest of the kernel,
presumably we should be adding this flag check to pidfd_create() and
not pidfd_open(), right? I gather that's what you actually meant.

/M
