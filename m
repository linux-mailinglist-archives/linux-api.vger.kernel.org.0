Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C33B751C
	for <lists+linux-api@lfdr.de>; Tue, 29 Jun 2021 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhF2P1G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Jun 2021 11:27:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43671 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234675AbhF2P1D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Jun 2021 11:27:03 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15TFOQv1003604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 11:24:27 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5626E15C3CD8; Tue, 29 Jun 2021 11:24:26 -0400 (EDT)
Date:   Tue, 29 Jun 2021 11:24:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Rob Landley <rob@landley.net>
Cc:     Denys Vlasenko <vda.linux@googlemail.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: lsattr: incorrect size for ioctl result
Message-ID: <YNs7KsXJLdPp78Q5@mit.edu>
References: <CAK1hOcO3qHFO6QOkpjnC_A4LVhwed02XxCYZvEn+8t+HnyGjZA@mail.gmail.com>
 <b1b801af-d309-829e-fd48-6487661df809@landley.net>
 <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
 <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net>
 <YNn5v7CTRsDo1mDO@mit.edu>
 <b5f013f0-7720-e6fb-f512-c1ff7114dfb6@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f013f0-7720-e6fb-f512-c1ff7114dfb6@landley.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 28, 2021 at 02:35:24PM -0500, Rob Landley wrote:
> 
> Let me see if I understand:
> 
> 1) The API the kernel exports is not what the kernel is doing.
> 2) Userspace can't reliably use the API the way it's currently exported.
> 3) Even other kernel devs "didn't understand" it.
> 4) Fixing it would involve scare quotes and result from a pearl clutching fit.
> 
> ... no, I'm pretty sure I don't understand.
> 
> *shrug* I've cc'd Michael Kerrisk in hopes he can update the man pages. "man
> ioctl_list" already documents these ioctls correctishly (modulo the
> signed/unsigned part) but might benefit from some sort of "warning, do not trust
> the kernel headers here, they are wrong" comment.

The philosophical question is whether the encoding of _IO* is actually
part of an exported "API", or just a way of encoding codepoints such
that when data structures change size, the codepoint automatically
changes/breaks.

We have historically speaking, a non-trivial number of ioctl's which
don't follow the _IO[RW] convention.  For example, most of the block
ioctls predate the _IO[RW] convention, and they set or get memory
without specifying the size of the type that is set or get.  Oh, noos!
The kernel is (clutchign pearls) *violating* an API "promise".
(Although, in reality, these code points existed for long before we
imposed this _IO[RW] "API".)  Should we break userspace to "fix" this
supposed API violation?  Or should we go through a huge amount of
effort to fix them all?

At one point, I had made an attempt to define the "correct" codepoint
via a definition of EXT4_IOC_GETVERSION and EXT4_IOC_GETVERSION_OLD,
so the kernel would support the "correct" and "wrong" ioctl codepoint.
Unfortunate, this got broken when other folks tried to unify
everything to use FS_IOC_GETVERSION defined in
include/uapi/linux/fs.h.  And given that we would have to support the
"wrong" codepoint for a decade or more, personally, I've stopped
caring about it, especially since we've lived with it for a decade or
more, and very few people been harmed.

If someone wants to fix up all of the ioctl code points, perhaps so it
would make life easier for strace, or some such, it's not a *terrible*
idea.  (At the very least, it's more useful than KPI-hacking folks
submitting whitespace fixes that don't even fix all of the
checkpatch.pl "violations".)  But forcing all of the ioctl codepoints
into the procrustean bed of the _IO[RW] covention is a huge amount of
work, and would take years before userspace could depend on this
"API".

Cheers,

					- Ted
