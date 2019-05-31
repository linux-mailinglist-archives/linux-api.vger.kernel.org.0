Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8BCF316F1
	for <lists+linux-api@lfdr.de>; Sat,  1 Jun 2019 00:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEaWIU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 18:08:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45740 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfEaWIU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 18:08:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so7391056wrq.12
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ko+Wfyi0i3W9WpJFYljQ2csSgtbI9KzNY6clfhR9vIY=;
        b=Xkl2M46O4ONXQoKukrh9dDHZI44Fdkjsyy2ix0AyrV4jZZTexqNuY0GkXgSG/30iRD
         iOWtIkxPnFM0RQTqKRl+cMC5qPNoPscKekDEP9DpSpIApMr+2krumjnPat8cZOX3rYCD
         25cI9u4R3ddTTb455a4bxxTbr+kZH/3GL9qKoawUxCRxVZ08atYeitfzLosAQq4QYmOT
         Ra9TE2EjDPC5KpRYYV9YJaNzWPd4fQvboEveN3PiK8IM7tkZsg0EDwSPeY7vvK429s2J
         wt4WtbY52JJ7VfHMXO8LDbULlJ6LcEie+x2CcEJMvhz/SufHgqQrqcEwPKVoBtRJgacV
         TWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ko+Wfyi0i3W9WpJFYljQ2csSgtbI9KzNY6clfhR9vIY=;
        b=VQ7AZ+5t9LeSPoBZHCa6CjOolooTadS0EN+OzEVht6L8TVsor5J1sfTSyoO4skIJWK
         VU87Gi+tw0Px+NxZTO+etQl5ElROBiXUYUfxRlrc2Ywz3Cmuyxe+1pIwhgWdHPQpTHXW
         J2lY/70XZ+wgs9GkBhMjBAHwfe4QWFRNSc7vDtZxtmJ2hI/vBXmH51mRDSOvsOlJ+4UE
         TqlQnZHj3ruJOuswADWUFukis/XooxzSSEB9RHv0Hyze/ZIx6YTV6CJ+ijdhkbupLCuq
         FCUQr8pH9gAVzWQ+C9k6wXdYS+xoQRQaI/XOIHUIieTyZ/0Bv9LZ4+y5mCeAiu7wW7ZF
         U63A==
X-Gm-Message-State: APjAAAUrQj2+vgRRE2xoXSaEvQnNX/To+SdOCE4LFcz0cZT0y6ZNf8FL
        2VCT3rfExefTmFSkbD9jdHgykA==
X-Google-Smtp-Source: APXvYqzFdnv3qzEAIcXHR3zG4OGdyoA5rAUUUsYFs30nC2YlkL1BuHJpjp4kIfaRFe2SEJMKXHNsfg==
X-Received: by 2002:a05:6000:1149:: with SMTP id d9mr2285752wrx.154.1559340498233;
        Fri, 31 May 2019 15:08:18 -0700 (PDT)
Received: from brauner.io (93-32-55-82.ip32.fastwebnet.it. [93.32.55.82])
        by smtp.gmail.com with ESMTPSA id 65sm14341721wro.85.2019.05.31.15.08.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 15:08:17 -0700 (PDT)
Date:   Sat, 1 Jun 2019 00:08:16 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v1 1/2] fork: add clone3
Message-ID: <20190531220815.owrc5kbbdemmwdhs@brauner.io>
References: <20190529152237.10719-1-christian@brauner.io>
 <1058006e0df4b52b3e53c7b3202c04140899aeb5.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1058006e0df4b52b3e53c7b3202c04140899aeb5.camel@opteya.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 29, 2019 at 05:42:14PM +0200, Yann Droneaud wrote:
> Le mercredi 29 mai 2019 à 17:22 +0200, Christian Brauner a écrit :
> > This adds the clone3 system call.
> > 
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index b4cba953040a..6bc3e3d17150 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2472,7 +2475,96 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
> >  		 unsigned long, tls)
> >  #endif
> >  {
> > -	return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr, tls);
> > +	struct kernel_clone_args args = {
> > +		.flags = clone_flags,
> > +		.stack = newsp,
> > +		.pidfd = parent_tidptr,
> > +		.parent_tidptr = parent_tidptr,
> > +		.tls = tls,
> > +		.child_tidptr = child_tidptr,
> > +	};
> > +
> > +	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
> > +	if ((clone_flags & CLONE_PIDFD) && (clone_flags & CLONE_PARENT_SETTID))
> > +		return -EINVAL;
> > +
> > +	return _do_fork(&args);
> > +}
> > +
> > +static bool clone3_flags_valid(u64 flags)
> > +{
> > +	if (flags & CLONE_DETACHED)
> > +		return false;
> > +
> > +	if (flags & ~CLONE_MAX)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> > +				     struct clone_args __user *uargs,
> > +				     size_t size)
> > +{
> > +	struct clone_args args;
> > +
> > +	if (unlikely(size > PAGE_SIZE))
> > +		return -E2BIG;
> > +
> > +	if (unlikely(size < sizeof(struct clone_args)))
> > +		return -EINVAL;
> > +
> > +	if (unlikely(!access_ok(uargs, size)))
> > +		return -EFAULT;
> > +
> > +	if (size > sizeof(struct clone_args)) {
> > +		unsigned char __user *addr;
> > +		unsigned char __user *end;
> > +		unsigned char val;
> > +
> > +		addr = (void __user *)uargs + sizeof(struct clone_args);
> > +		end = (void __user *)uargs + size;
> > +
> > +		for (; addr < end; addr++) {
> > +			if (get_user(val, addr))
> > +				return -EFAULT;
> > +			if (val)
> > +				return -E2BIG;
> 
> Should be -EINVAL: having something after the structure should be
> handled just like an invalid flags, while still allowing future
> userspace program to probe for support for newer feature.

(Traveling until Monday, so sorry for delayed responses.)

This copies what:

kernel/sched/core.c:sched_copy_attr()
kernel/event/core.c:perf_copy_attr()

are already doing. Consistency might be good here but, I think.

Christian
