Return-Path: <linux-api+bounces-1803-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1E91C07B
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 16:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED872863F2
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFF1BF31A;
	Fri, 28 Jun 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L5byYxpa"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712C1BE843;
	Fri, 28 Jun 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583750; cv=none; b=U1VMM65vetFpPfSP1PaDgh5Em4FchndeBWivp2wgjJ8c4+VMuqToXl9xm5EghpudIIUToC3RqHa7yJry/28LigSr460iWMQmvd4lUd09niZ6DigCjnLK2fW/L4BNr0//EsXmmNMcHJ5hpVJcOxJOoGza656uDhyO3GeSU3UA/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583750; c=relaxed/simple;
	bh=PoxoWWl88O12e6KbvoEyRiWn5b5ve/LBlpPDCEhGhsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI+AjVJWP0QTSbTjDOrLYMkNOBOog5bJ/OptEiFqmZdayoV6qlwFdeDw8jDfbCo7bptokXnGZ5TF5KSwJaONQ0PTMomjtZgdiKIv0geTszO90L5leTktQnlz+x95J7Rz5VtNnLJPL3eOWzqSaYETZI2XM0hJxMG8Ab0R89HUpy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=L5byYxpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3304BC116B1;
	Fri, 28 Jun 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L5byYxpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1719583746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9G/8NSfD5bhb15ffQL7z+PnF+QkyW7FSyBk5NRxv10=;
	b=L5byYxpa+NDlWYcN1RTTJibXvDJ5F9efTq0kO48Ze/QE2GCBmnGaNPM/R7dxzJ5S4Pjpvb
	+5Eup6rRM20VxMq5Y/buyBUM+W1+Y+xy80UDu/gNrelTynZvhbzg3Y/bUCDzaB+3UlZcig
	JooVYqDIomzZCidMd60ZHRjU8z294Lc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ff92fdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Jun 2024 14:09:05 +0000 (UTC)
Date: Fri, 28 Jun 2024 16:09:01 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v18 2/5] random: add vgetrandom_alloc() syscall
Message-ID: <Zn7D_YBC2SXTa_jX@zx2c4.com>
References: <20240620005339.1273434-1-Jason@zx2c4.com>
 <20240620005339.1273434-3-Jason@zx2c4.com>
 <20240620.020423-puny.wheat.mobile.arm-1wWnJHwWYyAl@cyphar.com>
 <ZnQeCRjgNXEAQjEo@zx2c4.com>
 <87v81txjb7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v81txjb7.ffs@tglx>

On Fri, Jun 28, 2024 at 03:56:12PM +0200, Thomas Gleixner wrote:
> Jason!
> 
> On Thu, Jun 20 2024 at 14:18, Jason A. Donenfeld wrote:
> > On Wed, Jun 19, 2024 at 07:13:26PM -0700, Aleksa Sarai wrote:
> >> Then again, I guess since libc is planned to be the primary user,
> >> creating a new syscall in a decade if necessary is probably not that big
> >> of an issue.
> >
> > I'm not sure going the whole big struct thing is really necessary, and
> > for an additional reason: this is only meant to be used with the vDSO
> > function, which is also coupled with the kernel. It doesn't return
> > information that's made to be used (or allowed to be used) anywhere
> > else. So both the vdso code and the syscall code are part of the same
> > basic thing that will evolve together. So I'm not convinced extensible
> > struct really makes sense for this, as neat as it is.
> >
> > If there's wide consensus that it's desirable, in contrast to what I'm
> > saying, I'm not vehemently opposed to it and could do it, but it just
> > seems like massive overkill and not at all necessary. Things are
> > intentionally as simple and straightforward as can be.
> 
> Right, but the problem is that this is a syscall, so people are free to
> explore it even without the vdso part. Now when you want to change it
> later then you are caught in the no-regression trap.
> 
> So making it extensible with backwards compability in place (add the
> unused flag field and check for 0) will allow you to expand without
> breaking users.

Okay, so it sounds like you're also in camp-struct. I guess let's do it
then. This opens up a few questions, but I think we can get them sorted.
Right now this version of the patch has this signature:

  void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each,
                         unsigned long addr, unsigned int flags);

The semantics are currently:

- [in] unsigned int num - desired number of states
- [in] unsigned long addr - reserved, nothing
- [in] unsigned int flags - reserved, nothing
- [out] unsigned int num - actual number of states
- [out] unsigned int size_per_each - size of each state
- [out] void* return value - the allocated thing

Following Aleksa's suggestion, we keep the `[out] void* return value` as
a return value, but move all the other into a struct:

    void *vgetrandom_alloc(struct vgetrandom_args *arg, size_t size);

So now the struct can become:

    struct vgetrandom_args {
        [in] u64 flags;
        [in/out] u32 num;
        [out] u32 size_per_each;
    }

Alternatively, this now opens the possibility to incorporate Eric's
suggestion of also returning the number of allocated bytes, which is
perhaps definitely to deal with, but I didn't do because I wanted
symmetry in the argument list. So doing that, now we have:

    struct vgetrandom_args {
        [in] u64 flags;
        [in/out] u32 num;
        [out] u32 size_per_each;
        [out] u64 bytes_allocated;
    }

Does that seem reasonable? There's a little bit of mixing of ins and
outs within the struct, and the return value is still a return value,
rather than a `[out] void *ret` inside of the struct. But maybe that's
fine. Also I used u32 there for the two smaller arguments, but maybe
that's silly and we should go straight to u64?

Anyway, how does that look to you?

Jason

