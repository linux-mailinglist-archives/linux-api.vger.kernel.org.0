Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79E03B79A6
	for <lists+linux-api@lfdr.de>; Tue, 29 Jun 2021 23:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhF2VGv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Jun 2021 17:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhF2VGu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Jun 2021 17:06:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38C5A61D04;
        Tue, 29 Jun 2021 21:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625000663;
        bh=wWQVuoebBfPIM/qDpYZ9DKJc4agU0R2QORPDCvwFKZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/kf8BYFpI/jVlE+11Zbq6XbPUNukgK7sCjFj9GSAGaUkH0LmkBaFXDSCgBEwkjSM
         4XITPnRv5cHZVDfb0nqbzdcZ4JPw7MrSCqdY13nGCcxdIyGlD6OpUNRtJ5ALdHjEoB
         qGijJxw4zc8f2Cgt737AHJlTAi1xj6CP5zcskfqmlZdKBDu0Fg/3LptFP2lQPJLA8/
         YAMqbiQfLKpl4W0+PN/mvy0I2Iq5xH1GT6D3RV88o8WjlAX918WgwHop6EGAWTxEX1
         pPqQzuEZDDwHY/YjyG6Z3wSP+6R0uyvVrqbQfZyMLZOnvYPlOefpaltjyIesirlXcf
         HOjr6r4vmDKqw==
Date:   Tue, 29 Jun 2021 14:04:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Rob Landley <rob@landley.net>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: lsattr: incorrect size for ioctl result
Message-ID: <20210629210422.GD13767@locust>
References: <CAK1hOcO3qHFO6QOkpjnC_A4LVhwed02XxCYZvEn+8t+HnyGjZA@mail.gmail.com>
 <b1b801af-d309-829e-fd48-6487661df809@landley.net>
 <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
 <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net>
 <YNn5v7CTRsDo1mDO@mit.edu>
 <b5f013f0-7720-e6fb-f512-c1ff7114dfb6@landley.net>
 <YNs7KsXJLdPp78Q5@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNs7KsXJLdPp78Q5@mit.edu>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 29, 2021 at 11:24:26AM -0400, Theodore Ts'o wrote:
> On Mon, Jun 28, 2021 at 02:35:24PM -0500, Rob Landley wrote:
> > 
> > Let me see if I understand:
> > 
> > 1) The API the kernel exports is not what the kernel is doing.
> > 2) Userspace can't reliably use the API the way it's currently exported.
> > 3) Even other kernel devs "didn't understand" it.
> > 4) Fixing it would involve scare quotes and result from a pearl clutching fit.
> > 
> > ... no, I'm pretty sure I don't understand.
> > 
> > *shrug* I've cc'd Michael Kerrisk in hopes he can update the man pages. "man
> > ioctl_list" already documents these ioctls correctishly (modulo the
> > signed/unsigned part) but might benefit from some sort of "warning, do not trust
> > the kernel headers here, they are wrong" comment.
> 
> The philosophical question is whether the encoding of _IO* is actually
> part of an exported "API", or just a way of encoding codepoints such
> that when data structures change size, the codepoint automatically
> changes/breaks.
> 
> We have historically speaking, a non-trivial number of ioctl's which
> don't follow the _IO[RW] convention.  For example, most of the block
> ioctls predate the _IO[RW] convention, and they set or get memory
> without specifying the size of the type that is set or get.  Oh, noos!
> The kernel is (clutchign pearls) *violating* an API "promise".
> (Although, in reality, these code points existed for long before we
> imposed this _IO[RW] "API".)  Should we break userspace to "fix" this
> supposed API violation?  Or should we go through a huge amount of
> effort to fix them all?
> 
> At one point, I had made an attempt to define the "correct" codepoint
> via a definition of EXT4_IOC_GETVERSION and EXT4_IOC_GETVERSION_OLD,
> so the kernel would support the "correct" and "wrong" ioctl codepoint.
> Unfortunate, this got broken when other folks tried to unify
> everything to use FS_IOC_GETVERSION defined in
> include/uapi/linux/fs.h.  And given that we would have to support the
> "wrong" codepoint for a decade or more, personally, I've stopped
> caring about it, especially since we've lived with it for a decade or
> more, and very few people been harmed.
> 
> If someone wants to fix up all of the ioctl code points, perhaps so it
> would make life easier for strace, or some such, it's not a *terrible*
> idea.  (At the very least, it's more useful than KPI-hacking folks
> submitting whitespace fixes that don't even fix all of the
> checkpatch.pl "violations".)  But forcing all of the ioctl codepoints
> into the procrustean bed of the _IO[RW] covention is a huge amount of
> work, and would take years before userspace could depend on this
> "API".

Why don't we deprecate FS_IOC_[GS]ETFLAGS and tell everyone to use
FS[GS]ETXATTR?  They use the same code paths and vfs helpers now.

--D

> 
> Cheers,
> 
> 					- Ted
