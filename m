Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA23B7C51
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 05:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhF3EAj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 00:00:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47548 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229446AbhF3EAi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 00:00:38 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15U3vxQq002163
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 23:58:00 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 532E915C3C8E; Tue, 29 Jun 2021 23:57:59 -0400 (EDT)
Date:   Tue, 29 Jun 2021 23:57:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Rob Landley <rob@landley.net>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: lsattr: incorrect size for ioctl result
Message-ID: <YNvrx+Wt0WmA+gGJ@mit.edu>
References: <CAK1hOcO3qHFO6QOkpjnC_A4LVhwed02XxCYZvEn+8t+HnyGjZA@mail.gmail.com>
 <b1b801af-d309-829e-fd48-6487661df809@landley.net>
 <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
 <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net>
 <YNn5v7CTRsDo1mDO@mit.edu>
 <b5f013f0-7720-e6fb-f512-c1ff7114dfb6@landley.net>
 <YNs7KsXJLdPp78Q5@mit.edu>
 <20210629210422.GD13767@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629210422.GD13767@locust>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 29, 2021 at 02:04:22PM -0700, Darrick J. Wong wrote:
> 
> Why don't we deprecate FS_IOC_[GS]ETFLAGS and tell everyone to use
> FS[GS]ETXATTR?  They use the same code paths and vfs helpers now.

The FS_IOC_[GS]ETXATTR ioctls use struct fsxattr, which contains
fsx_xflags.  But there are flags returned (and set) by
FS_IOC_[GS]ETFLAGS that are not in fsx_xflags --- and vice versa, of
course.

That's not a problem for xfs, since fsx_xflags was originally designed
for xfs (and so it has some xfs-specific flags such as
FS_XFLAG_REALTIME, FS_XFLAG_RTINHERIT, FS_XFLAG_FILESTREAM,
FS_XFLAG_COWEXTSIZE, etc.).

But for other file systems, including btrfs, ext4 and f2fs, which
utilize FS_IOC_[GS]ETFLAGS flags which are not supported by
FS_IOC_[GS]ETXATTR's fsx_xflags.  Examples of such flags include
FS_ENCRYPT_FL, FS_TOPDIR_FL, FS_NOCMP_FL, and FS_CASEFOLD_FL.

There is also the _IO[RW] long vs int "API violation" for the
FS_IOC_[GS]ETVERSION which isn't addressed by FS_IOC_[GS]ETATTR.

So FS_IOC_[GS]ETATTR isn't a complete replacement/solution for these
"problem" ioctls.  And of course, even if we were to start telling
everyone to start using a new interface, it'll be many years before
any transition is complete.

						- Ted
