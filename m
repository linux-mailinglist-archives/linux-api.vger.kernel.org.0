Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2820B35
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfEPP30 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 11:29:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37805 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfEPP3V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 11:29:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so5849699edw.4
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZqfBKUXmncS+f99++ptXSxdqupLw9zmhEoHFhOKQ3+w=;
        b=TH4z/rM7ErguN84LC3AmRg3JM/hVu0pzNCfG54H90jzb63FEyWpgQxI/RMgxJKMw0P
         YMcyNk31xsPD9o3Q8SwKVFbPkeg8kucRDIsE3yDY3iiXnyBwTwnYxeZvDW5/V+wBXU6a
         4Whkmp9tF7azl07xuKt/fN1RfMwR7c1B7epJGJ4YizDr1inzgV4yUswyquIaazuD7NSA
         +Y7PT7f4mQIjQrv4yQyYO9MGe0DD0FnBStZnFHo1gVuPfCi9qKCZU5pU6DsIxSnGA9Ik
         9SEOtQn5L4G4624dzeKPE3TTelvggQSyZJ+x/s6KcHf9L4yAiTiSgxh1JqlUq122MXzB
         4CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZqfBKUXmncS+f99++ptXSxdqupLw9zmhEoHFhOKQ3+w=;
        b=QicSWIEPL6VcBZe9+gwUdbQ8+sr0BBVk+R/hfklREvvhFY5y5jKM9umwBIJEZWRqwf
         /sIsiTzpQOowXCs0M9UYDwnpKKzatQ9ulwuHGoXU3aonFNr1d/ajoZ5ZDZhVhFjAsVo3
         ZCfVMfQAhQRw9RJh9l+t1Q9iGMBpRRUtuqxjdFDarRB2Cxsr4HgyPjtR3vWEn5L7Jm6e
         IryzGKeuadGY9TCD9L2GadGAtYtW2jYR3SG7yEMgldyHH5J5LKyK4e/rhK0yKt1aje7R
         17b98zVfpsSBWIFr2KcNXu07gEYrgA9BuvnGz9Z3aOtAi9QBSYHhCMJGSxlOVPjLqGz/
         RXVw==
X-Gm-Message-State: APjAAAVJbr2YTgZjs/XraMPObEWoIqlDnIYy6hG7YpvDuLDWVulHKZZQ
        N1SKGt4MdJc9vXOn6oKbA0t+Wg==
X-Google-Smtp-Source: APXvYqzND3qJO+X7rGwmXjyWOGo7yuQQOnxCqVFCr+1kxGCEKNbb6bF5poI+TQvkmuF3C5Oy1BVzkw==
X-Received: by 2002:a50:a886:: with SMTP id k6mr51048650edc.211.1558020559731;
        Thu, 16 May 2019 08:29:19 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id b4sm1889513edf.7.2019.05.16.08.29.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 08:29:19 -0700 (PDT)
Date:   Thu, 16 May 2019 17:29:16 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, jannh@google.com,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        keescook@chromium.org, luto@amacapital.net, luto@kernel.org,
        tglx@linutronix.de, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, joel@joelfernandes.org,
        dancol@google.com, serge@hallyn.com,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516152915.3t2wofeu3xsyhfbd@brauner.io>
References: <20190516135944.7205-1-christian@brauner.io>
 <20190516142659.GB22564@redhat.com>
 <20190516145607.j43xyj26k6l5vmbd@yavin>
 <20190516150611.GC22564@redhat.com>
 <20190516151202.hrawrx7hxllmz2di@yavin>
 <20190516152252.GD22564@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516152252.GD22564@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 16, 2019 at 05:22:53PM +0200, Oleg Nesterov wrote:
> On 05/17, Aleksa Sarai wrote:
> >
> > On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > > On 05/17, Aleksa Sarai wrote:
> > > > On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > > > > On 05/16, Christian Brauner wrote:
> > > > > > With the introduction of pidfds through CLONE_PIDFD it is possible to
> > > > > > created pidfds at process creation time.
> > > > >
> > > > > Now I am wondering why do we need CLONE_PIDFD, you can just do
> > > > >
> > > > > 	pid = fork();
> > > > > 	pidfd_open(pid);
> > > >
> > > > While the race window would be exceptionally short, there is the
> > > > possibility that the child will die
> > >
> > > Yes,
> > >
> > > > and their pid will be recycled
> > > > before you do pidfd_open().
> > >
> > > No.
> > >
> > > Unless the caller's sub-thread does wait() before pidfd_open(), of course.
> > > Or unless you do signal(SIGCHILD, SIG_IGN).
> >
> > What about CLONE_PARENT?
> 
> I should have mentioned CLONE_PARENT ;)
> 
> Of course in this case the child can be reaped before pidfd_open(). But how often
> do you or other people use clone(CLONE_PARENT) ? not to mention you can trivially
> eliminate/detect this race if you really need this.
> 
> Don't get me wrong, I am not trying to say that CLONE_PIDFD is a bad idea.
> 
> But to me pidfd_open() is much more useful. Say, as a perl programmer I can easily
> use pidfd_open(), but not CLONE_PIDFD.

Right, but for a libc, service- or container manager CLONE_PIDFD is much
nicer when spawning processes quickly. :) I think both are very good to
have.

Thanks, Oleg. As always super helpful reviews. :)
Christian
