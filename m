Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49C83B66CE
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhF1Qff (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 12:35:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41459 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233189AbhF1Qff (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 12:35:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15SGX3Lq021340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 12:33:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4DD1015C3CD8; Mon, 28 Jun 2021 12:33:03 -0400 (EDT)
Date:   Mon, 28 Jun 2021 12:33:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Rob Landley <rob@landley.net>
Cc:     Denys Vlasenko <vda.linux@googlemail.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: lsattr: incorrect size for ioctl result
Message-ID: <YNn5v7CTRsDo1mDO@mit.edu>
References: <CAK1hOcO3qHFO6QOkpjnC_A4LVhwed02XxCYZvEn+8t+HnyGjZA@mail.gmail.com>
 <b1b801af-d309-829e-fd48-6487661df809@landley.net>
 <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
 <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 25, 2021 at 04:01:27AM -0500, Rob Landley wrote:
> > No. The above is a lie.
> 
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -203,8 +203,8 @@ struct fsxattr {
> 
>  #define        FS_IOC_GETFLAGS                 _IOR('f', 1, long)
>  #define        FS_IOC_SETFLAGS                 _IOW('f', 2, long)
> -#define        FS_IOC_GETVERSION               _IOR('v', 1, long)
> -#define        FS_IOC_SETVERSION               _IOW('v', 2, long)
> +#define        FS_IOC_GETVERSION               _IOR('v', 1, unsigned int)
> +#define        FS_IOC_SETVERSION               _IOW('v', 2, unsigned int)
>  #define FS_IOC_FIEMAP                  _IOWR('f', 11, struct fiemap)
>  #define FS_IOC32_GETFLAGS              _IOR('f', 1, int)
>  #define FS_IOC32_SETFLAGS              _IOW('f', 2, int)

The problem is that there are a large number of userspace programs
which are using _IOR('v', 1, long) (the codepoint for
FS_IOC_GETVERSION for decades), but are expecting the kernel to fill
in an int.

We could do something like this:

#define        FS_IOC_GETVERSION               _IOR('v', 1, int)
#define        FS_IOC_GETVERSION_OLD           _IOR('v', 1, long)

But the key is that we keep support for the codepoint of _IOR('v', 1,
long) essentially forever, or we will break userspace binary
compatibility, which is verboten.

We also need to be a bit careful when we make these sorts of changes
of #defines, so we don't break kernel code like this: 

long ext2_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
	/* These are just misnamed, they actually get/put from/to user an int */
	switch (cmd) {
	case EXT2_IOC32_GETFLAGS:
		cmd = EXT2_IOC_GETFLAGS;
		break;
	case EXT2_IOC32_SETFLAGS:
		cmd = EXT2_IOC_SETFLAGS;
		break;
	case EXT2_IOC32_GETVERSION:
		cmd = EXT2_IOC_GETVERSION;
		break;
	case EXT2_IOC32_SETVERSION:
		cmd = EXT2_IOC_SETVERSION;
		break;
	default:
		return -ENOIOCTLCMD;
	}
	return ext2_ioctl(file, cmd, (unsigned long) compat_ptr(arg));
}

(This is from 4.4's fs/ext2/ioct.c; the point is if we want to "fix"
the definition of *_IOC_GETFLAGS because of a pearl clutching fit that
even though the code point is _IOR('v', 1, long), we're reading and
writing an int, we need to be careful and check all of the kernel
codepaths that refer to IOC_{GET,SET}{FLAGS,VERSION}.

> Which raises the question "why is there an IOC32 version of this when it was
> never NOT 32 bit" and "does GETFLAGS have the same problem"? (Haven't looked...)

Probably because the people who added the IOC32 versions didn't
understand this at the time?  :-)

					- Ted
